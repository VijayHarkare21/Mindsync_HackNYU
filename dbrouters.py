# dbrouters.py
class EEGRouter:
    """
    Routes database operations for the 'eeg' app to the 'mongo' database.
    All other apps use the default database.
    """
    def db_for_read(self, model, **hints):
        if model._meta.app_label == 'eeg':
            return 'mongo'
        return None

    def db_for_write(self, model, **hints):
        if model._meta.app_label == 'eeg':
            return 'mongo'
        return None

    def allow_relation(self, obj1, obj2, **hints):
        # Allow relations if either model is in the eeg app.
        if obj1._meta.app_label == 'eeg' or obj2._meta.app_label == 'eeg':
            return True
        return None

    def allow_migrate(self, db, app_label, model_name=None, **hints):
        if db == 'mongo':
            # Only allow migrations for the 'eeg' app on MongoDB.
            return app_label == 'eeg'
        elif db == 'default':
            # For the default database, disallow migrations for the 'eeg' app.
            return app_label != 'eeg'
        return None
