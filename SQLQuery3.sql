Create Database hospital
--USE nom_db
use hospital


IF OBJECT_ID('FactTable') IS NOT NULL DROP TABLE FactTable
GO
IF OBJECT_ID('dimPatient') IS NOT NULL DROP TABLE dimPatient
GO
IF OBJECT_ID('dimPhysician') IS NOT NULL DROP TABLE dimPhysician
GO
IF OBJECT_ID('dimTransaction') IS NOT NULL DROP TABLE dimTransaction
GO
IF OBJECT_ID('dimPayer') IS NOT NULL DROP TABLE dimPayer
GO
IF OBJECT_ID('dimLocation') IS NOT NULL DROP TABLE dimLocation
GO
IF OBJECT_ID('dimDiagnosisCode') IS NOT NULL DROP TABLE dimDiagnosisCode
GO
IF OBJECT_ID('dimCptCode') IS NOT NULL DROP TABLE dimCptCode
GO
IF OBJECT_ID('dimDate') IS NOT NULL DROP TABLE dimDate
GO


CREATE TABLE [dbo].[FactTable](
	[FactTablePK] varchar(255)					Not NULL Primary Key
	,[dimPatientPK] varchar(255)				Not NULL 
	,[dimPhysicianPK] varchar(255)				Not NULL
	,[dimDatePostPK] varchar(255)				Not NULL
	,[dimDateServicePK] varchar(255)			Not NULL
	,[dimCPTCodePK] varchar(255)				Not NULL
	,[dimPayerPK] varchar(255)					Not NULL
	,[dimTransactionPK] varchar(255)			Not NULL
	,[dimLocationPK] varchar(255)				Not NULL
	,[PatientNumber] varchar(255)				Not NULL
	,[dimDiagnosisCodePK] varchar(255)			Not NULL
	,[CPTUnits] varchar(255)					NULL Default 0
	,[GrossCharge] varchar(255)				NULL Default 0
	,[Payment] varchar(255)					NULL Default 0
	,[Adjustment] varchar(255)					NULL Default 0
	,[AR] varchar(255)							NULL Default 0
	) 

CREATE TABLE [dbo].[dimPatient](
	[dimPatientPK] varchar(255)					Not Null Primary Key
	,[PatientNumber] varchar(255)				NULL
	,[FirstName] varchar(255)					NULL
	,[LastName] varchar(255)					NULL
	,[Email] varchar(255)						NULL
	,[PatientGender] varchar(255)				NULL
	,[PatientAge] int							NULL
	,[City] varchar(255)						NULL
	,[State] varchar(255)						NULL)

CREATE TABLE [dbo].[dimPhysician](
	[dimPhysicianPK] varchar(255)				Not NULL Primary Key
	,[ProviderNpi] varchar(255)					NULL
	,[ProviderName] varchar(255)				NULL
	,[ProviderSpecialty] varchar(255)			NULL
	,[ProviderFTE] varchar(255)				NULL Default 0)

CREATE TABLE [dbo].[dimTransaction](
	[dimTransactionPK] varchar(255)				Not NULL Primary Key
	,[TransactionType] varchar(255)				NULL
	,[Transaction] varchar(255)					NULL
	,[AdjustmentReason] varchar(255)			NULL)

CREATE TABLE [dbo].[dimPayer](
	[dimPayerPK] varchar(255)					Not NULL Primary Key
	,[PayerName] varchar(255)					NULL) 

CREATE TABLE [dbo].[dimLocation](
	[dimLocationPK] varchar(255)				Not NULL Primary Key
	,[LocationName] varchar(255)				NULL)

CREATE TABLE [dbo].[dimDiagnosisCode](
	[dimDiagnosisCodePK] varchar(255)			Not NULL Primary Key
	,[DiagnosisCode] varchar(255)				NULL
	,[DiagnosisCodeDescription] varchar(255)	NULL
	,[DiagnosisCodeGroup] varchar(255)			NULL)

CREATE TABLE [dbo].[dimCptCode](
	[dimCPTCodePK] varchar(255)					Not NULL Primary Key
	,[CptCode] varchar(255)						NULL
	,[CptDesc] varchar(255)						NULL
	,[CptGrouping] varchar(255)					NULL)

CREATE TABLE [dbo].[dimDate](
	[dimDatePostPK] varchar(255)				Not NULL Primary Key
	,[Date] varchar(255)								NULL
	,[Year] varchar(255)						NULL
	,[Month] varchar(255)						NULL
	,[MonthPeriod] varchar(255)					NULL
	,[MonthYear] varchar(255)					NULL
	,[Day] varchar(255)							NULL
	,[DayName] varchar(255)						NULL)
GO



IF OBJECT_ID('FK_dimPatientPK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimPatientPK
GO
IF OBJECT_ID('FK_dimPhysicianPK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimPhysicianPK
GO
IF OBJECT_ID('FK_dimTransactionPK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimTransactionPK
GO
IF OBJECT_ID('FK_dimPayerPK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimPayerPK
GO
IF OBJECT_ID('FK_dimLocationPK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimLocationPK
GO
IF OBJECT_ID('FK_dimDiagnosisCodePK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimDiagnosisCodePK
GO
IF OBJECT_ID('FK_dimCptCodePK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimCptCodePK
GO
IF OBJECT_ID('FK_dimDatePK') IS NOT NULL Alter Table FactTable DROP Constraint FK_dimDatePK
GO


CREATE VIEW View_FactTable_Complete AS
SELECT FactTablePK, ft.PatientNumber, FirstName, LastName, PatientGender, PatientAge, City,ProviderNpi, ProviderName, ProviderSpecialty,
[Date], CptCode,CptGrouping, PayerName, TransactionType, AdjustmentReason, LocationName,
DiagnosisCode, DiagnosisCodeDescription, CPTUnits, GrossCharge, Payment, Adjustment, AR
FROM FactTable as ft
LEFT JOIN dimPatient as pa ON ft.dimPatientPK = pa.dimPatientPK
LEFT JOIN dimPhysician as ph ON ft.dimPhysicianPK = ph.dimPhysicianPK
LEFT JOIN dimDate as dd ON ft.dimDatePostPK = dd.dimDatePostPK
LEFT JOIN dimCptCode as cp ON ft.dimCPTCodePK = cp.dimCPTCodePK
LEFT JOIN dimPayer as py ON ft.dimPayerPK = py.dimPayerPK
LEFT JOIN dimTransaction as tr ON ft.dimTransactionPK = tr.dimTransactionPK
LEFT JOIN dimLocation as lc ON ft.dimLocationPK = lc.dimLocationPK
LEFT JOIN dimDiagnosisCode as dg ON ft.dimDiagnosisCodePK = dg.dimDiagnosisCodePK;


--question 1
select count(*) from View_FactTable_Complete
where cast(GrossCharge as decimal(10,2)) > 100


-- question 2
SELECT count(distinct PatientNumber) FROM View_FactTable_Complete


-- question 3
SELECT DISTINCT CptGrouping, count(*) FROM View_FactTable_Complete
group by CptGrouping


-- qestion 4
SELECT count(distinct ProviderNpi) FROM View_FactTable_Complete
where PayerName = 'Medicare'
group by PayerName


-- questio 5

SELECT COUNT(*) FROM (
    SELECT CptCode
    FROM View_FactTable_Complete
    GROUP BY CptCode
    HAVING COUNT(CptCode) > 100
) AS sub



-- question 6
select * from View_FactTable_Complete
group by ProviderNpi
where payer


-- question 7
select CPTUnits, count(DiagnosisCode) from View_FactTable_Complete
where DiagnosisCode like 'J%'
group by CPTUnits


-- question 8
select FirstName, LastName, Email,PatientAge, City, [State] from dimPatient
where PatientAge < 18

select FirstName, LastName, Email,PatientAge, City, [State] from dimPatient
where PatientAge < 65 and PatientAge >= 18

select FirstName, LastName, Email,PatientAge, City, [State] from dimPatient
where PatientAge >= 65


-- question 9
SELECT SUM(CAST(Adjustment AS DECIMAL(18,2))) AS Total_Perte_Credentialing FROM View_FactTable_Complete
WHERE AdjustmentReason = 'Credentialing';

