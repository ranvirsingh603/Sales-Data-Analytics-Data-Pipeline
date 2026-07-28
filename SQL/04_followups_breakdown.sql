CREATE OR REPLACE TABLE `reliable-aloe-423606-g8.CRR_SYSTEM.avg_max_no_of_followups`
AS
WITH
pendingInqs AS
  (SELECT
    Inq_No,
    Client_No
  FROM
    `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Order' AND
    Planned IS NOT NULL AND
    Actual IS NULL
  ),


closedInqs AS
  (SELECT
    Inq_No,
    Client_No
  FROM
    `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Order' AND
    Actual IS NOT NULL
  ),


FollpPerInq AS
  (SELECT
    Inq_No,
    COUNT(Actual) as no_of_followps_by_Inq
  FROM
    `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
  WHERE
    Step = 'Proposal to Order Followup'
  GROUP BY
    Inq_No
  ),


AvgFollClosedInq AS
  (SELECT
   c.Client_No,
   ROUND(COUNT(o.Actual)/ COUNT(distinct c.Inq_No)) AS avg_followps_by_client
  FROM
    closedInqs AS c
  LEFT JOIN
    `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table` AS o
  ON c.Inq_No = o.Inq_No AND o.Step = 'Proposal to Order Followup'
  GROUP BY
    c.Client_No),


MaxFollClosedInq AS
  (SELECT
    t.Client_No,
    MAX(followps) as max_followups_by_client
  FROM
    (SELECT
      c.Client_No,
      c.Inq_No,
      COUNT(Actual) as followps
    FROM
      closedInqs AS c
    LEFT JOIN
      `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table` AS o
    ON c.Inq_No = o.Inq_No AND o.Step = 'Proposal to Order Followup'
    GROUP BY c.Client_No,c.Inq_No) t
    GROUP BY t.Client_No
  )


SELECT
  p.Inq_No,
  p.Client_No,
  no_of_followps_by_Inq,
  avg_followps_by_client,
  max_followups_by_client
FROM
  pendingInqs p
LEFT JOIN
  FollpPerInq f
ON p.Inq_No = f.Inq_No
LEFT JOIN
  AvgFollClosedInq a
ON p.Client_No = a.Client_No
LEFT JOIN
  MaxFollClosedInq m
ON p.Client_No = m.Client_No;
