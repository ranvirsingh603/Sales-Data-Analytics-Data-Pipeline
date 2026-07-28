CREATE OR REPLACE TABLE reliable-aloe-423606-g8.CRR_SYSTEM.closed_vs_pending_inqs_by_clients
AS
WITH cte as (
  SELECT
  Client_No,
  COUNT(Client_No) AS closed_inqs
FROM
  `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
WHERE
  Step = 'Order'  AND
  Status IS NOT NULL
GROUP BY Client_No)


 
SELECT
  cte.client_No,
  closed_inqs,
  IF(Pending_inq IS NULL, 0, Pending_inq) as Pending_inq
FROM cte
LEFT JOIN
  (SELECT
    Client_No,
    COUNT(Client_No) AS Pending_inq
  FROM
    `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Order' AND
    Planned IS NOT NULL AND
    Status IS NULL
  GROUP BY Client_No) p
ON cte.Client_No = p.client_No
ORDER BY
  closed_inqs DESC,
  Pending_inq DESC;
