CREATE OR REPLACE TABLE `reliable-aloe-423606-g8.CRR_SYSTEM.conRatio_maxInqBeforeYes_totalOrderValue_byClient`
AS
WITH max_inqs AS
  (SELECT
    Client_No,
    row_no - IFNULL(LAG(row_no, 1) OVER (PARTITION BY Client_No ORDER BY row_no),0 ) - 1 AS inq_before_yes
  FROM
    (SELECT
      Client_No,
      Status,
      ROW_NUMBER() OVER (PARTITION BY Client_No ORDER BY Inq_No ASC) AS row_no
    FROM
      `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
    WHERE
      Step = 'Order'
    ) t
  WHERE Status = 'Yes'),


  con_ratio AS
  (SELECT
    Client_No,
    IFNULL(ROUND(SAFE_DIVIDE(
      COUNT(DISTINCT CASE WHEN Step = 'Order' AND Status = 'Yes' THEN Inq_No END),
      COUNT(DISTINCT CASE WHEN Step = 'Proposal'THEN Inq_No END) ) * 100, 2), 0) AS inq_order_ratio
    FROM
        `reliable-aloe-423606-g8.CRR_SYSTEM.crr_final_table`
    GROUP BY Client_No
    HAVING inq_order_ratio > 0
  )


SELECT
  c.Client_No,
  inq_order_ratio,
  max_inqs_before_yes,
  total_order_value
FROM con_ratio c
LEFT JOIN
  (SELECT
    Client_No,
    MAX(inq_before_yes) AS max_inqs_before_yes
  FROM
    max_inqs
  GROUP BY Client_No) m
ON c.Client_No = m.Client_No
LEFT JOIN `reliable-aloe-423606-g8.CRR_SYSTEM.Client_total_order` ov
ON c.Client_No = ov.Client_No
ORDER BY inq_order_ratio DESC, total_order_value DESC


