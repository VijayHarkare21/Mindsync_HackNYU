# Generated by Django 5.1.6 on 2025-02-09 00:34

from django.db import migrations, models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='EEGSession',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('recordings', models.JSONField()),
                ('session_type', models.CharField(choices=[('beats', 'EEG Beats'), ('chat', 'EEG Chat')], max_length=10)),
                ('conversation_thread', models.TextField(blank=True, null=True)),
                ('session_length', models.DurationField()),
                ('start_time', models.DateTimeField()),
                ('end_time', models.DateTimeField()),
                ('start_date', models.DateField()),
                ('user_reference', models.CharField(max_length=255)),
            ],
        ),
    ]
