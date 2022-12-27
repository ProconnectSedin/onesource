CREATE TABLE dwh.d_astaxyearhdr (
    taxyr_hdr_key bigint NOT NULL,
    taxyr_code character varying(20) COLLATE public.nocase,
    a_timestamp integer,
    taxyr_desc character varying(80) COLLATE public.nocase,
    taxyr_startdt timestamp without time zone,
    taxyr_enddt timestamp without time zone,
    frequency character varying(40) COLLATE public.nocase,
    taxyr_status character varying(10) COLLATE public.nocase,
    resou_id integer,
    rescomp_code character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_astaxyearhdr ALTER COLUMN taxyr_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_astaxyearhdr_taxyr_hdr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_astaxyearhdr
    ADD CONSTRAINT d_astaxyearhdr_pkey PRIMARY KEY (taxyr_hdr_key);

ALTER TABLE ONLY dwh.d_astaxyearhdr
    ADD CONSTRAINT d_astaxyearhdr_ukey UNIQUE (taxyr_code);