import numpy as np

def compute_band_power(psds, freqs, band):
    """
    Compute the integrated power (area under the PSD curve) in a given frequency band.
    
    Parameters:
      psds (numpy.ndarray): PSD values of shape (n_channels, n_freq_bins)
      freqs (numpy.ndarray): 1D array of frequency bins.
      band (tuple): (fmin, fmax)
      
    Returns:
      float: Integrated power (e.g., in µV²) averaged across channels.
    """
    fmin, fmax = band
    idx_band = np.logical_and(freqs >= fmin, freqs <= fmax)
    delta_f = freqs[1] - freqs[0] if len(freqs) > 1 else 1.0
    power_per_channel = np.sum(psds[:, idx_band], axis=1) * delta_f
    integrated_power = np.mean(power_per_channel)
    return integrated_power

def compute_all_bands_power(psds, freqs):
    """
    Compute integrated power for standard EEG bands.
    
    Returns:
      dict: Keys 'delta', 'theta', 'alpha', 'beta', 'gamma' mapping to their integrated power.
    """
    bands = {
        "delta": (0.5, 4),
        "theta": (4, 8),
        "alpha": (8, 12),
        "beta": (12, 30),
        "gamma": (30, 45)
    }
    band_powers = {}
    for band_name, band_range in bands.items():
        band_powers[band_name] = compute_band_power(psds, freqs, band_range)
    return band_powers

def generate_binaural_beat(psds, freqs, scenario, clip_duration=20.0):
    """
    Generate binaural beat recommendations with detailed band power and time allocation.
    
    Parameters:
      psds (numpy.ndarray): PSD values (n_channels, n_freq_bins)
      freqs (numpy.ndarray): Frequency bins corresponding to psds.
      scenario (str): One of "Study", "Work", "Stress", "Mindfulness", "Sleep".
      clip_duration (float): Duration of the EEG clip in seconds.
      
    Returns:
      dict: Contains the recommended binaural beat frequency and additional details.
    """
    # Define target bands, base frequencies, and expected ratios
    targets = {
        "Study": {"band": (8, 12), "base": 10, "expected_ratio": 0.35},
        "Work": {"band": (15, 20), "base": 18, "expected_ratio": 0.25},
        "Stress": {"band": (4, 8), "base": 6, "expected_ratio": 0.30},
        "Mindfulness": {"band": (6, 8), "base": 7, "expected_ratio": 0.30},
        "Sleep": {"band": (0.5, 4), "base": 3, "expected_ratio": 0.40}
    }
    if scenario not in targets:
        raise ValueError("Unknown scenario. Choose from Study, Work, Stress, Mindfulness, Sleep.")
    
    target_info = targets[scenario]
    target_band = target_info["band"]
    base_frequency = target_info["base"]
    expected_ratio = target_info["expected_ratio"]
    
    # Compute integrated power for all standard bands.
    band_powers = compute_all_bands_power(psds, freqs)
    total_power = sum(band_powers.values())
    
    # Map scenario to a standard band (for simplicity).
    band_name_mapping = {
        "Study": "alpha",
        "Work": "beta",
        "Stress": "theta",
        "Mindfulness": "theta",
        "Sleep": "delta"
    }
    target_band_name = band_name_mapping[scenario]
    target_power = band_powers.get(target_band_name, 0)
    
    # Calculate relative power of the target band.
    relative_power = target_power / total_power if total_power > 0 else 0
    # Adjust the base frequency linearly based on deviation from expected ratio.
    adjustment_factor = 1 + 0.1 * (relative_power - expected_ratio)
    adjusted_frequency = base_frequency * adjustment_factor
    confidence = 1 - abs(relative_power - expected_ratio) / expected_ratio if expected_ratio > 0 else 0
    
    # Determine the dominant band (the one with the highest integrated power)
    dominant_band = max(band_powers, key=band_powers.get) if band_powers else None
    
    # Allocate the clip duration to the dominant band.
    time_in_bands = {"delta": 0, "theta": 0, "alpha": 0, "beta": 0, "gamma": 0}
    if dominant_band in time_in_bands:
        time_in_bands[dominant_band] = clip_duration
    
    return {
        "scenario": scenario,
        "base_frequency": base_frequency,
        "adjusted_frequency": round(adjusted_frequency, 2),
        "target_band": {"fmin": target_band[0], "fmax": target_band[1]},
        "relative_target_power": round(relative_power, 3),
        "expected_ratio": expected_ratio,
        "confidence": round(confidence, 3),
        "detailed_band_powers": {k: round(v, 3) for k, v in band_powers.items()},
        "dominant_band": dominant_band,
        "time_in_bands": time_in_bands
    }
