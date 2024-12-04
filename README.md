ERHS 535 Final Project: Alex Alon, Owen Bevis, Arielle Glass, Susan Gogolski

---
title: "Nuclear Explosions Data Analysis"
output: 
  flexdashboard::flex_dashboard:
    storyboard: true
---

### Introduction

This project leverages the **Nuclear Explosions Dataset** sourced from the [Stockholm International Peace Research Institute](https://www.sipri.org/) and tidied via the [rfordatascience](https://github.com/rfordatascience/tidytuesday/tree/master/data/2019/2019-08-20) TidyTuesday repository. The analysis focuses on exploring nuclear explosions by country, deployment methods, regions, yield, and purpose over time using both static and interactive visualizations.
The file with the flexdashboard is called 'Flexdashboard_Storyboard_test.Rmd'.

---

### Data Information

#### Data Source
- **Primary Dataset**: Nuclear Explosions Dataset (via TidyTuesday)
- **Supporting References**:
  - [Wikipedia - Nuclear Weapon Testing](https://en.wikipedia.org/wiki/Nuclear_weapon_testing)
  - [Stockholm International Peace Research Institute (SIPRI)](https://www.sipri.org/)
  - [Our World in Data](https://ourworldindata.org/)

#### Data Dictionary

| Variable Name          | Data Type   | Description                                                                 |
|-------------------------|-------------|-----------------------------------------------------------------------------|
| `date_long`            | Date        | Date of the explosion (YYYY-MM-DD)                                         |
| `year`                 | Numeric     | Year of the explosion                                                      |
| `id_no`                | Numeric     | Unique identifier for the explosion                                        |
| `country`              | Character   | Country conducting the test                                                |
| `region`               | Character   | Region where the test occurred                                             |
| `source`               | Character   | Source reporting the explosion                                             |
| `latitude`             | Numeric     | Latitude coordinate of the test site                                       |
| `longitude`            | Numeric     | Longitude coordinate of the test site                                      |
| `magnitude_body`       | Numeric     | Body wave magnitude of the explosion                                       |
| `magnitude_surface`    | Numeric     | Surface wave magnitude of the explosion                                    |
| `depth`                | Numeric     | Depth of the explosion (positive = underground, negative = above ground)   |
| `yield_lower`          | Numeric     | Lower estimate of the explosion yield (kilotons of TNT)                    |
| `yield_upper`          | Numeric     | Upper estimate of the explosion yield (kilotons of TNT)                    |
| `purpose`              | Character   | Purpose of the test (e.g., military, peaceful use, safety testing)         |
| `name`                 | Character   | Name of the explosion or bomb                                              |
| `type`                 | Character   | Method of deployment (e.g., air drop, underground, water surface, etc.)    |

---

### Objectives

1. **Standardize and Enhance Data**:
   - Normalize country names (e.g., `"USA"` → `"United States"`).
   - Recode deployment types and purposes with descriptive names.
   - Assign unique identifiers to unnamed bombs (e.g., `"Unnamed Bomb 1"`).
   - Map regions to descriptive names with country information.

2. **Create Visualizations**:
   - **Interactive Bar Plots**:
     - Number of nuclear explosions by country per year.
     - Deployment methods by country.
   - **Static Analysis**:
     - Top 10 largest yield bombs.
     - Largest bomb per country with purpose, deployment type, and yield.
     - Most common regions for nuclear bomb deployment.
   - **Global Map**:
     - Worldwide nuclear explosions with interactive details (yield, purpose, deployment type).

3. **Explore Trends and Context**:
   - Analyze the number of tests over time, relating to historical events.
   - Categorize bombs by purpose (e.g., military, safety tests).
   - Evaluate deployment patterns (e.g., atmospheric vs. underground).

---

### Key Transformations

1. **Country Normalization**:
   - Converted shorthand country codes to full names (e.g., `"USA"` → `"United States"`).

2. **Region Mapping**:
   - Replaced region abbreviations with descriptive names, including the country (e.g., `"NTS"` → `"Nevada Test Site, USA"`).

3. **Bomb Names**:
   - Assigned sequential names to bombs with missing names (e.g., `"Unnamed Bomb 1"`).

4. **Type Recoding**:
   - Mapped deployment types to descriptive terms (e.g., `"ATMOSPH"` → `"Atmospheric"`).



