CREATE OR REPLACE TABLE `reliable-aloe-423606-g8.CRR_SYSTEM.avg_inq_to_order_by_client`
AS
SELECT
  o.Client_No,
  AVG(DATE_DIFF(Actual, Planned,day)-1) AS avg_days
FROM
  (SELECT
    Client_No,
    Inq_No,
    Planned
  FROM `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Proposal') p
INNER JOIN
  (SELECT
    Client_No,
    Inq_No,
    Actual
  FROM `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Order' AND Actual IS NOT NULL) o
  ON p.Inq_No = o.Inq_No
GROUP BY
  o.Client_No
