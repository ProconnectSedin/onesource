CREATE VIEW ods.view_locks AS
 SELECT pg_class.relname AS relation_name,
    pg_stat_activity.query,
    pg_locks.locktype,
    pg_locks.database,
    pg_locks.relation,
    pg_locks.page,
    pg_locks.tuple,
    pg_locks.virtualxid,
    pg_locks.transactionid,
    pg_locks.classid,
    pg_locks.objid,
    pg_locks.objsubid,
    pg_locks.virtualtransaction,
    pg_locks.pid,
    pg_locks.mode,
    pg_locks.granted,
    pg_locks.fastpath,
    pg_locks.waitstart
   FROM ((pg_locks
     JOIN pg_class ON ((pg_locks.relation = pg_class.oid)))
     JOIN pg_stat_activity ON ((pg_locks.pid = pg_stat_activity.pid)));
