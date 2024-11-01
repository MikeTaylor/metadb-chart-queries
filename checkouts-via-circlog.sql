--metadb:function checkins_via_circlog

-- Many thanks to Joshua Lambert (Missouri State University)
-- See Slack thread at https://metadb-project.slack.com/archives/C03ETMXU3QF/p1727377387325839

-- XXX this is not ready to use

SELECT substr(date_trunc('month', cli."date"::timestamptz)::varchar, 1, 7) AS "Month",
         substr(date_trunc('day', cli."date"::timestamptz)::varchar, 10, 2) AS "Day",
         -- substr(date_trunc('hour', cli."date"::timestamptz)::varchar, 12, 2) AS "Hour",
         COUNT(cli.date::timestamptz)
  FROM folio_reporting.circulation_logs__t__items cli
  WHERE cli.OBJECT = 'Loan'
    AND (cli.action = 'Checked out'
         OR cli.action = 'Renewed')
    AND cli.date >= '2024-07-01'
    AND cli.date < '2025-07-01'
  GROUP BY "Month", "Day";
