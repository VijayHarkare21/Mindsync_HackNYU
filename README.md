# Mindsync

**Mindsync** is an innovative Django-based backend that harnesses EEG signal processing to generate personalized binaural beat recommendations for enhanced cognitive states. By integrating advanced signal processing with a multidatabase approach (PostgreSQL for user data and MongoDB for EEG recordings), Mindsync enables real-time analysis of EEG data—simulated or recorded—to guide brainwave entrainment for scenarios such as studying, working, stress reduction, mindfulness, and sleep.

---

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Architecture](#architecture)
- [Installation & Setup](#installation--setup)
- [Usage](#usage)
  - [Simulation of EEG Signals](#simulation-of-eeg-signals)
  - [API Endpoints](#api-endpoints)
- [Testing with Postman](#testing-with-postman)
- [Research & References](#research--references)
- [Contributing](#contributing)

---

## Overview

Mindsync provides a robust platform for processing EEG data with the goal of generating binaural beats tailored to different cognitive states. The backend:
- **Simulates EEG data** for target channels (T7 and T8).
- **Computes Power Spectral Density (PSD)** using advanced signal processing (MNE-Python, Welch’s method).
- **Generates binaural beat recommendations** based on the integrated power of standard EEG bands.
- **Aggregates session data** by recording the cumulative time spent in each frequency band across multiple 20-second clips.
- **Utilizes a multidatabase architecture** with PostgreSQL and MongoDB to store user and EEG session data separately.

---

## Features

- **Multidatabase Integration:**  
  Uses PostgreSQL for structured user data and MongoDB (via djongo) for storing EEG session data.
  
- **Advanced EEG Signal Processing:**  
  Computes integrated band power (area under the PSD curve) for delta, theta, alpha, beta, and gamma bands.

- **Custom Binaural Beat Generation:**  
  Generates personalized binaural beat frequencies for scenarios such as Study, Work, Stress, Mindfulness, and Sleep based on the relative power distribution in EEG bands.

- **Session Aggregation:**  
  Continuously aggregates the time spent in each EEG frequency band across multiple 20-second EEG clips.

- **RESTful API Endpoints:**  
  Provides endpoints for uploading EDF files, retrieving PSD analysis, and updating session data, all secured and designed with Django REST Framework.

---

## Architecture

- **Backend Framework:** Django with Django REST Framework.
- **Authentication:** User accounts managed via dj‑rest‑auth and django-allauth.
- **EEG Data Processing:**  
  - **Simulation:** Uses NumPy and pyedflib for EDF file generation.
  - **Signal Processing:** MNE-Python for reading EDF files, filtering, and computing PSD.
- **Databases:**  
  - **PostgreSQL:** For user authentication and sessions metadata.
  - **MongoDB:** For EEG session recordings and signal analysis data (via djongo).

---

## Installation & Setup

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/yourusername/yourrepository.git
   cd yourrepository
   git checkout backend
   ```

2. **Set Up Virtual Environment & Install Dependencies:**

   ```bash
   python3 -m venv venv
   source venv/bin/activate  # On Windows use: venv\Scripts\activate
   pip install -r requirements.txt
   ```

   *Dependencies include Django, djangorestframework, djongo, dj-rest-auth, django-allauth, MNE-Python, pyedflib, NumPy, etc.*

3. **Configure Databases:**

   - Set up PostgreSQL (for user accounts) and MongoDB (for EEG recordings) as described in the project documentation.
   - Ensure your `settings.py` includes appropriate settings for `DATABASES` and `DATABASE_ROUTERS`.

4. **Run Migrations:**

   Apply migrations on the default (PostgreSQL) and then on the MongoDB database for the EEG app:
   
   ```bash
   python manage.py migrate --database=default
   python manage.py migrate eeg --database=mongo
   ```

5. **Create a Superuser (Optional):**

   ```bash
   python manage.py createsuperuser
   ```

6. **Start the Server:**

   ```bash
   python manage.py runserver
   ```

---

## Usage

### Simulation of EEG Signals

The simulation script in `eeg/simulation.py` generates an EDF file with simulated EEG data for channels T7 and T8. Run it with:

```bash
python eeg/simulation.py
```

This produces a file (e.g., `simulated_eeg.edf`) which you can use for testing the API endpoints.

### API Endpoints

**Binaural Beat Recommendation Endpoint:**

- **URL:** `/api/eeg/binaural-beat/`
- **Method:** POST
- **Description:**  
  Accepts a 20-second EDF file, computes PSD for channels T7 and T8, generates a binaural beat recommendation based on the specified scenario (Study, Work, Stress, Mindfulness, Sleep), and updates the EEG session record with detailed band power and cumulative time data.
  
- **Expected Form Data:**
  - `edf_file` (File): EDF file upload.
  - `scenario` (Text): e.g., "Study"
  - `session_id` (Optional Text): To update an existing session.
  - `user_reference` (Optional Text): Identifier for the user if creating a new session.

**Other endpoints include:**

- **EEGSessionViewSet:**  
  Provides CRUD operations for EEG session records.
  
- **SessionsPast7DaysView:**  
  Retrieves session records for the past 7 days.

---

## Testing with Postman

1. **Open Postman and Create a New Request:**

   - Click **New** > **Request**.
   - Name the request (e.g., "Binaural Beat Recommendation Test") and add it to your collection.

2. **Set the Request Method and URL:**

   - Method: **POST**
   - URL:  
     ```
     http://localhost:8000/api/eeg/binaural-beat/
     ```

3. **Configure the Request Body:**

   - Click on the **Body** tab.
   - Select **form-data**.
   - Add the following keys:
     
     | Key             | Type  | Value (example)                                |
     |-----------------|-------|------------------------------------------------|
     | edf_file        | File  | Select your `simulated_eeg.edf` file           |
     | scenario        | Text  | Study                                          |
     | session_id      | Text  | (Optional: e.g., `1` if updating an existing session) |
     | user_reference  | Text  | user@example.com                               |

4. **Send the Request:**

   - Click **Send**.
   - Verify that the response (displayed in the lower panel) returns a JSON object containing fields such as:
     - `adjusted_frequency`
     - `detailed_band_powers`
     - `dominant_band`
     - `time_in_bands` (with cumulative seconds per band)
     - `session_id`
     
     Example response:
     ```json
     {
       "scenario": "Study",
       "base_frequency": 10,
       "adjusted_frequency": 10.2,
       "target_band": {"fmin": 8, "fmax": 12},
       "relative_target_power": 0.36,
       "expected_ratio": 0.35,
       "confidence": 0.971,
       "detailed_band_powers": {"delta": 0.12, "theta": 0.08, "alpha": 0.35, "beta": 0.25, "gamma": 0.05},
       "dominant_band": "alpha",
       "time_in_bands": {"delta": 0, "theta": 0, "alpha": 20, "beta": 0, "gamma": 0},
       "session_id": 1
     }
     ```

5. **Verify Database Updates (Optional):**

   - Use your Django admin interface or a database client to check that the EEGSession record has been updated with the new `time_in_bands` and `band_power` values.

---

## Research & References

- **Lane et al. (1998):**  
  [Binaural Auditory Beats Affect Vigilance Performance and Mood](https://pubmed.ncbi.nlm.nih.gov/9493720/)

- **Le Scouarnec et al. (2001):**  
  [Use of Binaural Beat Tapes for Treatment of Anxiety: A Pilot Study](https://www.liebertpub.com/doi/10.1089/107555301300049206)

- **Basar (2012):**  
  [Brain Oscillations in Neuropsychiatric Disease](https://doi.org/10.31887/DCNS.2012.14.4/ebasar)

- **Nunez & Srinivasan (2006):**  
  *Electric Fields of the Brain: The Neurophysics of EEG, ECoG, and MEG*

---

## Contributing

Contributions are welcome!  
If you have suggestions or improvements, please fork the repository, create a feature branch, and submit a pull request.
```

You now have a full README.md file with all the content, excluding the License and Contact sections. Happy coding with Mindsync!
