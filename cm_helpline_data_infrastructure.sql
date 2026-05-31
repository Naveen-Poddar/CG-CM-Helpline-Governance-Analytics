-- ========================================================================
-- Project: CM Helpline Governance Dashboard - Data Infrastructure
-- Engine: Microsoft SQL Server (T-SQL)
-- Author: Naveen Poddar
-- Description: Database creation, schema definition, synthetic data 
--              generation (Chhattisgarh context), and executive analytical queries.
-- ========================================================================

-- 1. Database Creation & Initialization
CREATE DATABASE CM_Helpline_Database;
GO

USE CM_Helpline_Database;
GO

-- 2. Schema Definition for Grievance Tracking Table
CREATE TABLE CM_Helpline_Data (
    Complaint_ID INT PRIMARY KEY,
    Citizen_Name VARCHAR(50),
    District VARCHAR(50),
    Department VARCHAR(50),
    Complaint_Type VARCHAR(100),
    Registered_Date DATE,
    Resolution_Days INT,
    Current_Status VARCHAR(20),
    Assigned_Level VARCHAR(5)
);
GO

-- 3. Seeding Initial Production Records (Sample Case Studies)
INSERT INTO CM_Helpline_Data (Complaint_ID, Citizen_Name, District, Department, Complaint_Type, Registered_Date, Resolution_Days, Current_Status, Assigned_Level)
VALUES 
(1001, 'Ramesh Kumar', 'Durg', 'Electricity', 'Power Outage in Ward 10', '2026-04-01', 2, 'Resolved', 'L3'),
(1002, 'Sita Sahu', 'Raipur', 'Ration/Food', 'Ration Card Not Issued', '2026-04-01', NULL, 'Pending', 'L2'),
(1003, 'Amit Singh', 'Bilaspur', 'Municipal', 'Garbage Collection Issue', '2026-04-02', 1, 'Resolved', 'L3'),
(1004, 'Naveen Sahu', 'Durg', 'Water Supply', 'No Water in Nehru Nagar', '2026-04-02', 4, 'Resolved', 'L3'),
(1005, 'Priya Patel', 'Bastar', 'Health', 'Medicines Unavailable in PHC', '2026-04-03', NULL, 'Pending', 'L2'),
(1006, 'Rajesh Mandavi', 'Kanker', 'Revenue', 'Land Demarcation Delay', '2026-04-03', NULL, 'Pending', 'L2'),
(1007, 'Anjali Verma', 'Durg', 'Electricity', 'High Electricity Bill', '2026-04-04', NULL, 'Pending', 'L1'),
(1008, 'Vikram Chandrakar', 'Dhamtari', 'Agriculture', 'Kisan Subsidy Not Received', '2026-04-05', 7, 'Resolved', 'L3'),
(1009, 'Suresh Korram', 'Surguja', 'Ration/Food', 'Ration Shop Closed frequently', '2026-04-05', NULL, 'Pending', 'L2'),
(1010, 'Deepak Yadav', 'Raipur', 'Municipal', 'Potholes on Main Road', '2026-04-06', NULL, 'Pending', 'L2');
GO

-- 4. Automated Scaled Data Generation Using T-SQL Loop (Populating 90 Additional Records)
DECLARE @cnt INT = 1011;
WHILE @cnt <= 1100
BEGIN
    INSERT INTO CM_Helpline_Data (Complaint_ID, Citizen_Name, District, Department, Complaint_Type, Registered_Date, Resolution_Days, Current_Status, Assigned_Level)
    VALUES (
        @cnt, 
        'Citizen_' + CAST(@cnt AS VARCHAR),
        CASE WHEN @cnt % 4 = 0 THEN 'Durg' WHEN @cnt % 4 = 1 THEN 'Raipur' WHEN @cnt % 4 = 2 THEN 'Bilaspur' ELSE 'Bastar' END,
        CASE WHEN @cnt % 5 = 0 THEN 'Electricity' WHEN @cnt % 5 = 1 THEN 'Ration/Food' WHEN @cnt % 5 = 2 THEN 'Municipal' WHEN @cnt % 5 = 3 THEN 'Water Supply' ELSE 'Revenue' END,
        'Sample Grievance Description ' + CAST(@cnt AS VARCHAR),
        DATEADD(day, @cnt % 15, '2026-04-01'),
        CASE WHEN @cnt % 3 = 0 THEN NULL ELSE (@cnt % 5) + 1 END,
        CASE WHEN @cnt % 3 = 0 THEN 'Pending' ELSE 'Resolved' END,
        CASE WHEN @cnt % 3 = 0 THEN 'L2' ELSE 'L3' END
    );
    SET @cnt = @cnt + 1;
END;
GO

-- Verification Check
SELECT * FROM CM_Helpline_Data;
GO

-- ========================================================================
-- EXECUTIVE ANALYTICAL QUERIES FOR MANAGEMENT REPORTING
-- ========================================================================

-- KPI 1: Geographic Distribution of Grievances (Identifying Critical Districts)
SELECT District, COUNT(Complaint_ID) AS Total_Complaints
FROM CM_Helpline_Data
GROUP BY District
ORDER BY Total_Complaints DESC;

-- KPI 2: Backlog Analysis (Department-wise Pending Ticket Volume)
SELECT Department, COUNT(Complaint_ID) AS Pending_Count
FROM CM_Helpline_Data
WHERE Current_Status = 'Pending'
GROUP BY Department
ORDER BY Pending_Count DESC;

-- KPI 3: Operational Efficiency Matrix (Average Resolution Time in Days)
SELECT Department, AVG(Resolution_Days) AS Avg_Day_To_Resolve
FROM CM_Helpline_Data
WHERE Current_Status = 'Resolved'
GROUP BY Department
ORDER BY Avg_Day_To_Resolve ASC;