CREATE OR REPLACE TABLE `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
AS
SELECT
  int64_field_1 as Inq_No,
  string_field_2 as Client_No,
  timestamp_field_10 as Planned,
  timestamp_field_11 as Actual,
  IF(timestamp_field_11 IS NULL, NULL, string_field_12) as Status,
  'Proposal' as Step
FROM `reliable-aloe-423606-g8.CRR_SYSTEM.Crr_First_Sheet` WHERE int64_field_1 IS NOT NULL
UNION ALL
SELECT
  int64_field_1 as Inq_No,
  string_field_2 as Client_No,
  timestamp_field_15 as Planned,
  timestamp_field_16 as Actual,
  IF(timestamp_field_16 IS NULL, NULL,string_field_17) as Status,
  'Order' as Step
FROM `reliable-aloe-423606-g8.CRR_SYSTEM.Crr_First_Sheet` WHERE int64_field_1 IS NOT NULL
UNION ALL
SELECT
  int64_field_1 as Inq_No,
  string_field_2 as Client_No,
  timestamp_field_22 as Planned,
  timestamp_field_23 as Actual,
  IF(timestamp_field_23 IS NULL, NULL, CAST(bool_field_24 AS STRING)) as Status,
  'Check if PO is Acceptable' as Step
FROM `reliable-aloe-423606-g8.CRR_SYSTEM.Crr_First_Sheet` WHERE int64_field_1 IS NOT NULL
UNION ALL
SELECT
  int64_field_1 as Inq_No,
  string_field_2 as Client_No,
  timestamp_field_28 as Planned,
  timestamp_field_29 as Actual,
  IF(timestamp_field_29 IS NULL,NULL, CAST(bool_field_30 AS STRING)) as Status,
  'Fill G.F. for O2D' as Step
FROM `reliable-aloe-423606-g8.CRR_SYSTEM.Crr_First_Sheet` WHERE int64_field_1 IS NOT NULL
UNION ALL
SELECT
  int64_field_2 AS Inq_No,
  string_field_3 as Client_No,
  timestamp_field_15 as Planned,
  timestamp_field_16 as Actual,
  IF(timestamp_field_16 IS NULL, NULL, 'Done') as Status,
  "Proposal to Order Followup" as Step
FROM `reliable-aloe-423606-g8.CRR_SYSTEM.crr_prop_to_order_followup`
WHERE int64_field_2 IS NOT NULL
