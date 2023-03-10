CREATE TABLE stg.stg_wms_tran_perf_log_grput (
    guid character varying(512) COLLATE public.nocase,
    puser character varying(120) COLLATE public.nocase,
    plocation character varying(40) COLLATE public.nocase,
    plan_no character varying(72) COLLATE public.nocase,
    exec_no character varying(72) COLLATE public.nocase,
    spname character varying(1020) COLLATE public.nocase,
    servicename character varying(1020) COLLATE public.nocase,
    block character varying COLLATE public.nocase,
    in_time timestamp without time zone,
    out_time timestamp without time zone,
    no_of_exec_lines integer,
    duration_of_exec integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);