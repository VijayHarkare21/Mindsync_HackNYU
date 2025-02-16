# eeg/simulation.py
import numpy as np
import pyedflib
import os

def simulate_eeg_signal(duration, fs, 
                        delta_strength=1.0, 
                        theta_strength=0.05, 
                        alpha_strength=0.5, 
                        beta_strength=0.4, 
                        gamma_strength=0.3):
    t = np.linspace(0, duration, int(fs * duration), endpoint=False)
    signal = np.zeros_like(t)
    # Delta band: 1-4 Hz (representative frequency: 2 Hz)
    signal += delta_strength * np.sin(2 * np.pi * 2 * t)
    # Theta band: 4-8 Hz (representative frequency: 6 Hz)
    signal += theta_strength * np.sin(2 * np.pi * 6 * t)
    # Alpha band: 8-12 Hz (representative frequency: 10 Hz)
    signal += alpha_strength * np.sin(2 * np.pi * 10 * t)
    # Beta band: 12-30 Hz (representative frequency: 20 Hz)
    signal += beta_strength * np.sin(2 * np.pi * 20 * t)
    # Gamma band: 30-45 Hz (representative frequency: 40 Hz)
    signal += gamma_strength * np.sin(2 * np.pi * 40 * t)
    # Add Gaussian noise
    signal += 0.1 * np.random.randn(len(t))
    return signal

def create_edf_file(filename, signals, channel_names, fs):
    n_channels = len(signals)
    n_samples = signals[0].shape[0]
    f = pyedflib.EdfWriter(filename, n_channels=n_channels, file_type=pyedflib.FILETYPE_EDFPLUS)
    
    channel_info = []
    for ch_name in channel_names:
        ch_dict = {
            'label': ch_name,
            'dimension': 'uV',
            'sample_frequency': fs,
            'physical_min': -1000,
            'physical_max': 1000,
            'digital_min': -32768,
            'digital_max': 32767,
            'transducer': '',
            'prefilter': ''
        }
        channel_info.append(ch_dict)
    f.setSignalHeaders(channel_info)
    signals_stacked = np.vstack(signals)
    f.writeSamples(signals_stacked)
    f.close()
    print(f"EDF file '{filename}' created with {n_channels} channels and {n_samples} samples per channel.")

def main():
    fs = 250  # Sampling frequency in Hz
    duration = 20.0  # For example, simulate 20 seconds for testing
    channel_names = ['T7', 'T8']  # Only target channels
    signals = []
    for ch in channel_names:
        # Optionally, vary strengths based on channel (for simulation purposes)
        signal = simulate_eeg_signal(duration, fs)
        signals.append(signal)
    
    output_filename = os.path.join(os.getcwd(), "simulated_eeg.edf")
    create_edf_file(output_filename, signals, channel_names, fs)

if __name__ == '__main__':
    main()


# import numpy as np
# import pyedflib
# import os

# def simulate_eeg_signal(duration, fs, 
#                         delta_strength=1.0, 
#                         theta_strength=0.05, 
#                         alpha_strength=0.5, 
#                         beta_strength=0.4, 
#                         gamma_strength=0.3):
#     t = np.linspace(0, duration, int(fs * duration), endpoint=False)
#     signal = np.zeros_like(t)
    
#     # Delta band: 1-4 Hz (using 2 Hz as representative)
#     signal += delta_strength * np.sin(2 * np.pi * 2 * t)
#     # Theta band: 4-8 Hz (using 6 Hz)
#     signal += theta_strength * np.sin(2 * np.pi * 6 * t)
#     # Alpha band: 8-12 Hz (using 10 Hz)
#     signal += alpha_strength * np.sin(2 * np.pi * 10 * t)
#     # Beta band: 12-30 Hz (using 20 Hz)
#     signal += beta_strength * np.sin(2 * np.pi * 20 * t)
#     # Gamma band: 30-45 Hz (using 40 Hz)
#     signal += gamma_strength * np.sin(2 * np.pi * 40 * t)
    
#     # Add some Gaussian noise
#     signal += 0.1 * np.random.randn(len(t))
#     return signal

# def create_edf_file(filename, signals, channel_names, fs):
#     """
#     Create an EDF file from a list of signals.
    
#     Parameters:
#       filename (str): Output EDF filename.
#       signals (list of numpy.ndarray): List of signals (one per channel).
#       channel_names (list of str): Channel labels.
#       fs (int): Sampling frequency.
#     """
#     n_channels = len(signals)
#     n_samples = signals[0].shape[0]

#     # Create the EDF writer object for an EDF+ file
#     f = pyedflib.EdfWriter(filename, n_channels=n_channels, file_type=pyedflib.FILETYPE_EDFPLUS)
    
#     channel_info = []
#     for ch_name in channel_names:
#         ch_dict = {
#             'label': ch_name,
#             'dimension': 'uV',
#             'sample_frequency': fs,
#             'physical_min': -1000,
#             'physical_max': 1000,
#             'digital_min': -32768,
#             'digital_max': 32767,
#             'transducer': '',
#             'prefilter': ''
#         }
#         channel_info.append(ch_dict)
#     f.setSignalHeaders(channel_info)
    
#     # Stack the signals into a 2D array: shape (n_channels, n_samples)
#     signals_stacked = np.vstack(signals)
    
#     # Write all channel signals at once using writeSamples()
#     f.writeSamples(signals_stacked)
    
#     f.close()
#     print(f"EDF file '{filename}' created with {n_channels} channels and {n_samples} samples per channel.")

# def main():
#     fs = 250              # Sampling frequency in Hz
#     duration = 10.0       # Duration in seconds
#     channel_names = ['T3', 'T4', 'T5', 'T6', 'T7', 'T8']
    
#     signals = []
#     for ch in channel_names:
#         if ch == 'T3':
#             signal = simulate_eeg_signal(duration, fs, alpha_strength=2.0, delta_strength=1.0)
#         elif ch == 'T4':
#             signal = simulate_eeg_signal(duration, fs, delta_strength=2.0, alpha_strength=1.0)
#         else:
#             signal = simulate_eeg_signal(duration, fs)
#         signals.append(signal)
    
#     output_filename = os.path.join(os.getcwd(), "simulated_eeg.edf")
#     create_edf_file(output_filename, signals, channel_names, fs)

# if __name__ == '__main__':
#     main()

