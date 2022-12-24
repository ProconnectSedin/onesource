CREATE TABLE dwh.f_inboundplantracking (
    pln_tracking_key bigint NOT NULL,
    pln_date_key bigint NOT NULL,
    pln_lineno integer,
    pln_ou integer,
    pln_stage character varying(20) COLLATE public.nocase,
    pln_pln_no character varying(40) COLLATE public.nocase,
    pln_exe_no character varying(40) COLLATE public.nocase,
    pln_exe_status character varying(20) COLLATE public.nocase,
    pln_user character varying(60) COLLATE public.nocase,
    pln_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);