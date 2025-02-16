# eeg/freq_id.py
import mne
import numpy as np
import matplotlib.pyplot as plt
import os
from mne.time_frequency import psd_array_welch

# Set the EDF file path (use the simulated file for testing)
raw_fname = "D:\\Vijay\\NYU\\HackNYU\\backend\\django_native\\HackNYU2025\\HackNYU\\eeg\\simulated_eeg.edf"
raw = mne.io.read_raw_edf(raw_fname, preload=True)
sfreq = raw.info['sfreq']
# Only pick channels T7 and T8
raw.pick_channels(['T7', 'T8'])
raw.filter(l_freq=1.0, h_freq=40.0, fir_design='firwin')

data = raw.get_data()
# Define frequency range for PSD
fmin, fmax = 1.0, 40.0
psds, freqs = psd_array_welch(data, sfreq=sfreq, fmin=fmin, fmax=fmax, n_fft=512, average='mean')

# For demonstration: Plot the PSD for T7 and T8
plt.figure(figsize=(10, 6))
for i, ch in enumerate(raw.ch_names):
    plt.plot(freqs, 10*np.log10(psds[i]), label=ch)
plt.xlabel('Frequency (Hz)')
plt.ylabel('PSD (dB/Hz)')
plt.title('PSD for T7 and T8')
plt.legend()
plt.show()



# import mne
# import numpy as np
# import matplotlib.pyplot as plt
# import os
# from mne.time_frequency import psd_array_welch  # Function for array-based PSD computation

# # -------------------------------
# # 1. Load and Preprocess Data
# # -------------------------------
# # For demonstration, load MNE's sample data.
# # Replace the filename below with your file path if needed.
# # For example, using an EDF file:
# # raw_fname = "D:\\Vijay\\NYU\\Fall_24\\Machine Learning\\Project\\BENDR-0.1-alpha\\datasets\\tuheeg\\events_corpus\\edf\\eval\\000\\bckg_000_a_.edf"
# data_path = mne.datasets.sample.data_path()
# print("Data path:", data_path)
# # Use your own file path here:
# # raw_fname = os.path.join(data_path, 'MEG', 'sample', 'sample_audvis_raw.fif')
# raw_fname = "D:\\Vijay\\NYU\\HackNYU\\backend\\django_native\\HackNYU2025\\HackNYU\\eeg\\simulated_eeg.edf"
# raw = mne.io.read_raw_edf(raw_fname, preload=True)
# sfreq = raw.info['sfreq']  # Extract sampling frequency

# # Pick only EEG (and EOG, if needed)
# raw.pick_types(meg=False, eeg=True, eog=True)

# # (Optional) Set a standard montage; if the channel names are non-standard, you may ignore this.
# montage = mne.channels.make_standard_montage('standard_1020')
# raw.set_montage(montage, on_missing='warn')

# # Apply a bandpass filter (e.g., 1-40 Hz) to remove slow drifts and high-frequency noise.
# raw.filter(l_freq=1.0, h_freq=40.0, fir_design='firwin')

# # -------------------------------
# # 2. Define Frequency Range for PSD
# # -------------------------------
# # For an overall PSD, choose a wide frequency range (e.g., 1-40 Hz)
# fmin = 1.0
# fmax = 40.0

# # -------------------------------
# # 3. Compute PSD for All Channels
# # -------------------------------
# # Extract the data as a NumPy array.
# data = raw.get_data()  # shape: (n_channels, n_times)

# # Compute the PSD using Welch's method for the overall frequency range.
# # psd_array_welch returns PSD values with shape (n_channels, n_freq_bins) and an array of frequency bins.
# psds_all, freqs_all = psd_array_welch(
#     data,
#     sfreq=sfreq,
#     fmin=fmin,
#     fmax=fmax,
#     n_fft=512,
#     average='mean'
# )

# # -------------------------------
# # 4. Select One or Two Channels
# # -------------------------------
# # Option 1: Specify the channels by name (if you know them)
# # channels_to_plot = ['Fz', 'Cz']

# # Option 2: Use the first one or two EEG channels regardless of the montage.
# channels_to_plot = raw.ch_names[:20]  # This selects the first two channels available.

# # Get the indices of the channels to plot.
# indices = [raw.ch_names.index(ch) for ch in channels_to_plot]

# # -------------------------------
# # 5. Plot Overlapped PSD for the Selected Channels
# # -------------------------------
# plt.figure(figsize=(10, 6))
# for idx, ch in zip(indices, channels_to_plot):
#     # Convert PSD to dB: 10*log10(power)
#     plt.plot(freqs_all, 10 * np.log10(psds_all[idx]), label=ch)
# plt.xlabel('Frequency (Hz)')
# plt.ylabel('PSD (dB/Hz)')
# plt.title('Overlapped PSD for Selected Channels')
# plt.legend()
# plt.show()
