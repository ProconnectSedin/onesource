CREATE VIEW ods.running_queries AS
 SELECT pg_stat_activity.pid,
    age(clock_timestamp(), pg_stat_activity.query_start) AS age,
    pg_stat_activity.usename,
    pg_stat_activity.query,
    pg_stat_activity.query_start,
    pg_stat_activity.state_change,
    pg_stat_activity.wait_event,
    pg_stat_activity.wait_event_type
   FROM pg_stat_activity
  WHERE ((pg_stat_activity.query <> '<IDLE>'::text) AND (pg_stat_activity.query !~~* '%pg_stat_activity%'::text) AND (pg_stat_activity.state = 'active'::text))
  ORDER BY pg_stat_activity.query_start DESC;
  