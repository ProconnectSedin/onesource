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

ALTER TABLE dwh.d_equipmentgroupdtl ALTER COLUMN egrp_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_equipmentgroupdtl_egrp_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_pkey PRIMARY KEY (egrp_key);

ALTER TABLE ONLY dwh.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_ukey UNIQUE (egrp_id, egrp_ou, egrp_lineno);