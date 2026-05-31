# Chhattisgarh State CM Helpline - Public Governance Analytics Dashboard

This repository contains an end-to-end data analytics project focused on monitoring and improving citizen grievance redressal for the Chhattisgarh State CM Helpline. The project covers data infrastructure setup, automated cleaning, and executive reporting.

---

## Executive Dashboard Preview
![CM Helpline Dashboard](dashboard_screenshot.png)

---

## Tools & Technologies Used
*   **Database Management:** SQL Server (Database creation, schemas, and metrics logging)
*   **Data Cleaning & ETL:** Python / Pandas (Jupyter Notebook used for data type casting, handling missing records, and formatting)
*   **Data Visualization:** Power BI (Data modeling, DAX measures, and dashboard development)

---

## File Structure
*   `cm_helpline_data_infrastructure.sql` - Full SQL script for raw data structure and tables.
*   `data_cleaning_pipeline.ipynb` - Jupyter notebook with Pandas code used to process raw data.
*   `CM_Helpline_Clean_Data.csv` - Final clean dataset exported after the ETL process.
*   `CM_Helpline_Governance_Dashboard.pbix` - Power BI file with interactive dashboards and SLA tracking matrix.

---

## Key Operational Insights
1.  **High Volume Departments:** The analysis shows that Electricity, Municipal, and Ration/Food complaints make up the largest share of the workload across most districts.
2.  **SLA Tracking:** Around 74% of unresolved complaints currently fall within the 0 to 3 days window. Tracking this helps administrators address cases before they breach standard resolution timelines.
3.  **District Performance Matrix:** Built an interactive view cross-referencing districts and departments, allowing public management teams to spot regional blockages instantly.
4.  **Inflow Analysis:** Monitored the daily complaint flow trends to help optimize government resource and staff allocation based on departmental pressure.

---
**Maintained by Naveen Poddar**  
*MBA Candidate (Operations & Data Science) | IT Operations & Data Specialist*
