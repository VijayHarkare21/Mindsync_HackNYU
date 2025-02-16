# eeg/models.py
from django.db import models

SESSION_TYPE_CHOICES = (
    ('beats', 'EEG Beats'),
    ('chat', 'EEG Chat'),
)

class EEGSession(models.Model):
    """
    Model representing an EEG session.
    
    Attributes:
        recordings (JSONField): JSON field to store session recordings.
        session_type (CharField): Type of the session, choices are 'beats' or 'chat'.
        conversation_thread (TextField): Conversation thread related to the session.
        session_length (DurationField): Duration of the session.
        start_time (DateTimeField): Start time of the session.
        end_time (DateTimeField): End time of the session.
        start_date (DateField): Start date of the session.
        user_reference (CharField): Reference to the user, such as the user's email.
    """
    recordings = models.JSONField()
    session_type = models.CharField(max_length=10, choices=SESSION_TYPE_CHOICES)
    conversation_thread = models.TextField(blank=True, null=True)
    session_length = models.DurationField()
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    start_date = models.DateField()
    # Reference to the user – you can store an identifier such as the user's email
    user_reference = models.CharField(max_length=255)
    band_power = models.JSONField(blank=True, null=True, default=dict)  # e.g., {"delta": 1.23, "theta": 0.45, ...}
    time_in_bands = models.JSONField(blank=True, null=True, default=dict)  # e.g., {"delta": 20, "theta": 40, ...}

    def __str__(self):
        return f"{self.get_session_type_display()} session for user {self.user_reference} starting at {self.start_time}"
