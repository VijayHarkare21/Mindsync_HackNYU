# eeg/urls.py
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import EEGSessionViewSet
# from .views import CreateEEGSessionView
from .views import SessionsPast7DaysView
from .views import BinauralBeatRecommendationView

router = DefaultRouter()
router.register(r'sessions', EEGSessionViewSet, basename='session')

urlpatterns = [
    path('binaural-beat/', BinauralBeatRecommendationView.as_view(), name='binaural_beat_recommendation'),
    path('sessions/past_7_days/', SessionsPast7DaysView.as_view(), name='sessions_past_7_days'),
    path('', include(router.urls)),
    # path('sessions/create/', CreateEEGSessionView.as_view(), name='create_eeg_session'),
]
