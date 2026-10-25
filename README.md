# Healthcare Insurance Claims Fraud Analysis

## Project Overview

This project analyzes healthcare insurance claims to identify fraud patterns, high-risk provider categories, claim amount ranges, provider-patient distance patterns, and other factors associated with fraudulent claims.

The project demonstrates an end-to-end data analytics workflow using Python, Pandas, MySQL, and Tableau.

## Key KPIs

- Total Claims: 19,928
- Fraudulent Claims: 4,911
- Non-Fraudulent Claims: 15,017
- Overall Fraud Rate: 24.64%

## Tools & Technologies

- Python
- Pandas
- NumPy
- Matplotlib
- Seaborn
- MySQL
- Tableau
- Google Colab
- GitHub

## Data Cleaning

The dataset was cleaned and prepared using Python and Pandas. Key steps included:

- Checked dataset structure and data types
- Checked and handled missing values
- Checked duplicate records
- Converted date columns to appropriate datetime formats
- Cleaned and prepared categorical variables
- Prepared numerical and categorical columns for analysis
- Created a cleaned dataset for further analysis

## SQL Analysis

MySQL was used to analyze:

- Overall claim and fraud KPIs
- Fraud rates by provider specialty
- Fraud rates by provider type
- Claim amount ranges
- Patient age and gender patterns
- Provider-patient distance
- Previous claim patterns
- Hospital, diagnosis, and procedure patterns
- Monthly and yearly trends
- High-value fraudulent claims
- Rankings using window functions
- CTE-based analysis

## Tableau Dashboard

An interactive Tableau dashboard was developed to visualize healthcare insurance fraud patterns.

The dashboard includes:

- Total Claims
- Fraudulent Claims
- Fraud Rate
- Fraudulent Claim Amount
- Fraud Rate by Provider Specialty
- Fraud Rate by Provider Type
- Monthly Fraud Rate Trend
- Fraud Rate by Provider-Patient Distance
- Fraud Rate by Claim Amount Range
- Interactive filters for Provider Specialty, Provider Type, and Claim Date

## Key Findings

- Cardiology and Orthopedics showed some of the highest fraud rates among provider specialties.
- Cardiology had a fraud rate of approximately 46%.
- Orthopedics had a fraud rate of approximately 45%.
- Specialist Office providers showed a fraud rate of approximately 49.68%.
- Provider-patient distances of 500+ miles showed higher fraud rates compared with shorter distances.
- Claims in higher claim-amount ranges showed higher fraud rates.
- The overall fraud rate was approximately 24.64%.

## Repository Files

- `Data_analysis_(healthcare_fraud_analysis).ipynb` - Python/Pandas data cleaning and exploratory analysis
- `Healthcare-Fraud-Analysis.sql` - MySQL analysis queries
- `healthcare_fraud_final.csv` - Healthcare insurance claims dataset
- `Healthcare Insurance Claims Fraud Analysis final.twbx` - Tableau packaged workbook

## Project Workflow

Raw Data → Data Cleaning → Exploratory Analysis → SQL Analysis → Tableau Dashboard → Insights
