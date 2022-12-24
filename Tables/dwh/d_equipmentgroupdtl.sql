CREATE TABLE dwh.d_equipmentgroupdtl (
    egrp_key bigint NOT NULL,
    egrp_ou integer,
    egrp_id character varying(40) COLLATE public.nocase,
    egrp_lineno integer,
    egrp_eqp_id character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);