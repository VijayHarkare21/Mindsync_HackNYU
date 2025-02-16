# eeg/views.py
from rest_framework import viewsets
from .models import EEGSession
from .serializers import EEGSessionSerializer
from django.utils import timezone
from django.http import JsonResponse
from django.views import View
from datetime import timedelta
from rest_framework import status
from rest_framework.views import APIView
from rest_framework.response import Response
# from .serializers import EEGSessionCreateSerializer
import os
import mne
from mne.time_frequency import psd_array_welch
from .binaural import generate_binaural_beat
from django.conf import settings

class EEGSessionViewSet(viewsets.ModelViewSet):
    queryset = EEGSession.objects.all()
    serializer_class = EEGSessionSerializer

class BinauralBeatRecommendationView(APIView):
    """
    API endpoint that accepts an EDF file (representing a 20-second EEG recording),
    computes the PSD for target channels (T7 and T8), generates binaural beat recommendations,
    and updates the EEGSession record by aggregating band time and detailed band power.
    
    Expected POST data:
      - edf_file: The uploaded EDF file.
      - scenario: One of "Study", "Work", "Stress", "Mindfulness", "Sleep".
      - session_id (optional): Primary key of the existing EEGSession to update.
      - user_reference (optional): If no session_id is provided, this identifies the user.
    """
    def post(self, request, *args, **kwargs):
        edf_file = request.FILES.get('edf_file')
        scenario = request.data.get('scenario')
        session_id = request.data.get('session_id')
        user_reference = request.data.get('user_reference', 'unknown')
        
        if edf_file is None or scenario is None:
            return Response(
                {"error": "edf_file and scenario are required."},
                status=status.HTTP_400_BAD_REQUEST
            )
        
        # Save the file temporarily
        tmp_dir = os.path.join(settings.BASE_DIR, 'tmp')
        os.makedirs(tmp_dir, exist_ok=True)
        temp_path = os.path.join(tmp_dir, edf_file.name)
        with open(temp_path, 'wb+') as destination:
            for chunk in edf_file.chunks():
                destination.write(chunk)
        
        try:
            raw = mne.io.read_raw_edf(temp_path, preload=True, verbose=False)
            # Only process target channels T7 and T8
            raw.pick_channels(['T7', 'T8'])
            raw.filter(l_freq=1.0, h_freq=40.0, fir_design='firwin')
            
            data = raw.get_data()  # shape: (n_channels, n_times)
            sfreq = raw.info['sfreq']
            
            # Compute PSD using Welch's method
            fmin, fmax = 1.0, 40.0
            psds, freqs = psd_array_welch(data, sfreq=sfreq, fmin=fmin, fmax=fmax, n_fft=512, average='mean')
            
            # Define clip duration in seconds (assumed 20 seconds)
            clip_duration = 20.0
            recommendation = generate_binaural_beat(psds, freqs, scenario, clip_duration=clip_duration)
        except Exception as e:
            return Response({"error": str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        finally:
            os.remove(temp_path)
        
        # Update the EEGSession record: either retrieve existing or create new.
        try:
            if session_id:
                session = EEGSession.objects.get(pk=session_id)
                # Update end_time to now
                session.end_time = timezone.now()
                # Increment session_length by clip_duration
                # Convert clip_duration (in seconds) to timedelta
                session.session_length += timedelta(seconds=clip_duration)
            else:
                # Create a new session record.
                now = timezone.now()
                session = EEGSession.objects.create(
                    recordings={},  # Placeholder; adjust as needed.
                    session_type='beats',  # or derive from scenario if appropriate.
                    conversation_thread='',
                    session_length=timedelta(seconds=clip_duration),
                    start_time=now,
                    end_time=now + timedelta(seconds=clip_duration),
                    start_date=now.date(),
                    user_reference=user_reference,
                    band_power={},  # Will store the latest detailed band powers.
                    time_in_bands={"delta": 0, "theta": 0, "alpha": 0, "beta": 0, "gamma": 0}
                )
            
            # Update band_power: here we simply overwrite with the latest computed values.
            session.band_power = recommendation.get("detailed_band_powers", {})
            
            # Update time_in_bands: add clip_duration seconds to the dominant band.
            current_time_in_bands = session.time_in_bands or {}
            dominant_band = recommendation.get("dominant_band")
            if dominant_band:
                current_time = current_time_in_bands.get(dominant_band, 0)
                # Add the clip duration (in seconds)
                current_time_in_bands[dominant_band] = current_time + clip_duration
            session.time_in_bands = current_time_in_bands
            
            session.save()
            
            # Optionally, include the updated session id in the response.
            recommendation["session_id"] = session.pk
            
        except Exception as e:
            return Response({"error": "Error updating session: " + str(e)}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
        return Response(recommendation, status=status.HTTP_200_OK)


# class CreateEEGSessionView(APIView):
#     """
#     API view to create a new EEG session with multiple .edf files in the recordings field.
#     """

#     def options(self, request, *args, **kwargs):
#         response = super().options(request, *args, **kwargs)
#         print("Allowed methods:", response['Allow'])
#         return response

#     def post(self, request):
#         serializer = EEGSessionCreateSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class SessionsPast7DaysView(APIView):
    """
    API view to retrieve all EEG sessions for the past 7 days without the recordings field.
    If there are no sessions in that period, return all sessions available.
    """
    def get(self, request, *args, **kwargs):
        end_date = timezone.now()
        start_date = end_date - timedelta(days=7)
        
        sessions_qs = EEGSession.objects.filter(
            start_time__gte=start_date,
            end_time__lte=end_date
        ).values(
            'session_type', 'conversation_thread', 'session_length', 'start_time', 'end_time', 'start_date', 'user_reference'
        )
        
        if not sessions_qs.exists():
            sessions_qs = EEGSession.objects.all().values(
                'session_type', 'conversation_thread', 'session_length', 'start_time', 'end_time', 'start_date', 'user_reference'
            )
        
        return Response(list(sessions_qs), status=status.HTTP_200_OK)
