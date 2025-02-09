# eeg/serializers.py
from rest_framework import serializers
from .models import EEGSession

class EEGSessionSerializer(serializers.ModelSerializer):
    class Meta:
        model = EEGSession
        fields = '__all__'

class EEGSessionCreateSerializer(serializers.ModelSerializer):
    class Meta:
        model = EEGSession
        fields = ['recordings', 'session_type', 'conversation_thread', 'session_length', 'start_time', 'end_time', 'start_date', 'user_reference', 'band_power', 'time_in_bands']