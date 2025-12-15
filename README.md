## Gamma Camera MTF Measurement System (MATLAB Project)

### Project Summary

This MATLAB project implements a **comprehensive Modulation Transfer Function (MTF) measurement system** for gamma camera quality control. The system analyzes quadrant bar phantom images to calculate MTF values at multiple spatial frequencies (4, 5, 6, and 7 lp/mm). Using **advanced signal processing techniques**, the program automatically detects line patterns, computes MTF using the peak-to-valley method, and provides statistical analysis of image quality. The project demonstrates **nuclear medicine imaging physics**, **signal processing algorithms**, and **automated quality control** methodologies for medical imaging systems.

---

### Core Features

* **Multi-Frequency Analysis:** Simultaneously measures MTF at four different spatial frequencies (4-7 lp/mm)
* **Advanced Peak Detection:** Implements adaptive algorithms for robust peak/valley identification in noisy signals
* **Statistical MTF Calculation:** Computes mean, standard deviation, median, min, and max MTF values for each frequency
* **Signal-to-Noise Ratio (SNR) Analysis:** Quantifies image quality using dB-scale SNR measurements
* **Comprehensive Visualization:** Generates multi-panel diagnostic figures for each quadrant
* **Automated Reporting:** Produces detailed CSV reports with complete measurement data
* **Quality Control Metrics:** Provides standardized assessment of gamma camera spatial resolution

---

### Key Methods and Algorithms

#### 1. **Image Segmentation and Quadrant Processing**

* **Automatic Quadrant Division:** Splits phantom image into four equal quadrants using midpoint calculations
* **Frequency Assignment:** Associates each quadrant with known spatial frequency (7, 6, 5, 4 lp/mm clockwise)
* **Center-Row Profiling:** Uses average of 3 center rows for improved SNR in profile extraction

#### 2. **Adaptive Signal Processing**

* **Noise-Adaptive Smoothing:** Adjusts smoothing window (3-5 points) based on local noise characteristics
* **Auto-Prominence Detection:** Dynamically sets peak prominence thresholds (10% of signal range)
* **Robust Peak Detection:** Uses MATLAB's `findpeaks()` with minimum prominence for reliable extremum identification

#### 3. **MTF Calculation Methodology**

* **Standard MTF Formula:** `MTF = (Pmax - Pmin) / (Pmax + Pmin)` where:
  - Pmax = maximum intensity of white bars
  - Pmin = minimum intensity of black bars
* **Line Pair Statistics:** Calculates MTF for each detected line pair within quadrant
* **Statistical Aggregation:** Computes comprehensive statistics across all line pairs

#### 4. **Comprehensive Visualization System**

* **Multi-Panel Diagnostics:** Three-panel figures showing:
  - Signal profile with detected peaks/valleys
  - MTF values per line pair with mean reference
  - Quadrant image with profile location
* **MTF vs Frequency Plot:** Error-bar plot showing mean ± standard deviation across frequencies
* **Annotated Phantom Image:** Original image with quadrant divisions and MTF values overlaid

#### 5. **Automated Analysis and Reporting**

* **Structured Results:** Organizes data in MATLAB structure array with 17 measurement fields
* **CSV Export:** Saves complete results to comma-separated values file for external analysis
* **Console Reporting:** Real-time progress updates and summary statistics
* **Image Archiving:** Saves all diagnostic plots as PNG files for documentation

---

### Skills Demonstrated

* **Medical Imaging Physics:** Understanding of MTF principles and spatial resolution in gamma cameras
* **Signal Processing:** Advanced peak detection, smoothing algorithms, and noise estimation
* **Statistical Analysis:** Computation of mean, standard deviation, median, and confidence metrics
* **Image Processing:** Quadrant segmentation, profile extraction, and intensity analysis
* **Data Visualization:** Creation of publication-quality diagnostic plots and summary figures
* **Automated Quality Control:** Development of standardized measurement protocols
* **MATLAB Programming:** Efficient use of built-in functions, structured data, and file I/O operations
* **Scientific Reporting:** Generation of comprehensive results in multiple formats (text, CSV, images)

---

### File Overview

| File Type | Description |
|-----------|-------------|
| **MTF_Measurement_Gamma_Camera.m** | Main analysis script with complete MTF measurement system |
| **phantom_C9FF1H.gif** | Input bar phantom image (required for analysis) |
| **quadrant_1_analysis.png** | Diagnostic figure for 7 lp/mm quadrant |
| **quadrant_2_analysis.png** | Diagnostic figure for 6 lp/mm quadrant |
| **quadrant_3_analysis.png** | Diagnostic figure for 5 lp/mm quadrant |
| **quadrant_4_analysis.png** | Diagnostic figure for 4 lp/mm quadrant |
| **mtf_vs_frequency.png** | MTF vs spatial frequency plot with error bars |
| **phantom_with_mtf_values.png** | Original phantom with quadrant divisions and MTF annotations |
| **mtf_results.csv** | Comprehensive results data in CSV format |

---

### Analysis Output Example

**Key Measurements:**
- **Quadrant 1 (7 lp/mm):** Highest frequency, typically lowest MTF due to system limitations
- **Quadrant 2 (6 lp/mm):** Intermediate frequency for resolution assessment
- **Quadrant 3 (5 lp/mm):** Reference frequency for standard performance evaluation
- **Quadrant 4 (4 lp/mm):** Lower frequency, typically highest MTF near system maximum

**Typical Results Summary:**
```
Quadrant | Freq (lp/mm) | Mean MTF | Std Dev | Pairs | SNR (dB)
---------|---------------|----------|---------|-------|----------
   1     |      7       |  0.4523  | 0.0231  |   5   |   24.5
   2     |      6       |  0.6124  | 0.0187  |   6   |   26.8
   3     |      5       |  0.7532  | 0.0154  |   5   |   28.3
   4     |      4       |  0.8915  | 0.0122  |   4   |   30.1
```

**Interpretation:**
- **MTF Decrease with Frequency:** Expected trend of decreasing MTF with increasing spatial frequency
- **Standard Deviation:** Indicates measurement consistency across line pairs
- **SNR Values:** Higher SNR in lower frequency quadrants due to better signal contrast
- **Number of Pairs:** Varies by quadrant based on phantom design and image size

---

### How to Run

1. **Prepare Input:** Ensure `phantom_C9FF1H.gif` is in the MATLAB working directory
2. **Execute Script:** Run `MTF_Measurement_Gamma_Camera.m` in MATLAB
3. **View Results:** Check generated PNG files for visual results
4. **Analyze Data:** Open `mtf_results.csv` for numerical analysis in Excel or other tools
5. **Interpret Results:** Compare measured MTF values against manufacturer specifications

---

### Clinical Applications

This system supports:
- **Routine Quality Control:** Regular assessment of gamma camera spatial resolution
- **Acceptance Testing:** Verification of system performance after installation or repair
- **Comparative Studies:** Evaluation of different collimators or system configurations
- **Longitudinal Monitoring:** Tracking resolution changes over time for preventive maintenance

---

### Educational Value

This simulation provides practical understanding of:
- **MTF measurement techniques** in nuclear medicine
- **Signal processing methods** for medical image analysis
- **Quality control protocols** for imaging equipment
- **Statistical analysis** of system performance metrics
- **Automated analysis** workflows in clinical environments

---

### Technical Requirements

* **MATLAB Version:** R2016b or later (requires `findpeaks()` function from Signal Processing Toolbox)
* **Toolboxes:** Signal Processing Toolbox (for peak detection functions)
* **Input Format:** GIF image with standard four-quadrant bar phantom pattern
* **Expected Image Size:** Typically 256×256 or larger with clear quadrant divisions

---

### Customization Options

Users can modify:
- **Smoothing parameters** in lines 47-55 for different noise levels
- **Peak prominence thresholds** in lines 58-60 for varying contrast conditions
- **Profile averaging** in lines 39-41 for alternative SNR optimization
- **Output formats** in the figure generation and CSV export sections
