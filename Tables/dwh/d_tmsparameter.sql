CREATE TABLE dwh.d_tmsparameter (
    tms_key bigint NOT NULL,
    tms_componentname character varying(30) COLLATE public.nocase,
    tms_paramcategory character varying(20) COLLATE public.nocase,
    tms_paramtype character varying(50) COLLATE public.nocase,
    tms_paramcode character varying(20) COLLATE public.nocase,
    tms_paramdesc character varying(510) COLLATE public.nocase,
    tms_langid integer,
    tms_optionvalue character varying(20) COLLATE public.nocase,
    tms_sequenceno integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);