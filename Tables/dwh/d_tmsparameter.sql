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

ALTER TABLE dwh.d_tmsparameter ALTER COLUMN tms_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_tmsparameter_tms_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_pkey PRIMARY KEY (tms_key);

ALTER TABLE ONLY dwh.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_ukey UNIQUE (tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid);