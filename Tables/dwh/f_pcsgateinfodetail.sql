CREATE TABLE dwh.f_pcsgateinfodetail (
    pcs_gtin_dtl_key bigint NOT NULL,
    datekey bigint NOT NULL,
    id integer,
    orderno character varying(50) COLLATE public.nocase,
    gateno character varying(50) COLLATE public.nocase,
    ewayno character varying(50) COLLATE public.nocase,
    ewaydate character varying(50) COLLATE public.nocase,
    awbno character varying(50) COLLATE public.nocase,
    drivername character varying(150) COLLATE public.nocase,
    contactno character varying(150) COLLATE public.nocase,
    vehno character varying(150) COLLATE public.nocase,
    driverlicenseno character varying(150) COLLATE public.nocase,
    transporter character varying(100) COLLATE public.nocase,
    isnno character varying(100) COLLATE public.nocase,
    createdby character varying(100) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pcsgateinfodetail ALTER COLUMN pcs_gtin_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pcsgateinfodetail_pcs_gtin_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pcsgateinfodetail
    ADD CONSTRAINT f_pcsgateinfodetail_pkey PRIMARY KEY (pcs_gtin_dtl_key);

CREATE INDEX f_pcsgateinfodetail_key_idx ON dwh.f_pcsgateinfodetail USING btree (datekey);