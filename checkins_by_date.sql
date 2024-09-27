--metadb:function checkins_by_date

DROP FUNCTION IF EXISTS checkins_by_date;

CREATE FUNCTION checkins_by_date(
    start_date date DEFAULT '2024-01-01',
    end_date date DEFAULT '9999-12-31')
RETURNS TABLE(
    checkin_date date,
    count integer,
    more integer,
    less integer
)
AS $$
SELECT date(occurred_date_time) as checkin_date, count(*), int(1+count(*)) as more, int(count(*)/2) as less
	FROM folio_circulation.check_in__t
	WHERE start_date <= occurred_date_time::date AND occurred_date_time::date < end_date
	GROUP BY date(occurred_date_time)
	ORDER BY date(occurred_date_time)
$$
LANGUAGE SQL
STABLE
PARALLEL SAFE;
