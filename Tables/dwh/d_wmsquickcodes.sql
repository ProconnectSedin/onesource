CREATE TABLE dwh.d_wmsquickcodes (
    code_key bigint NOT NULL,
    code_ou integer,
    code_type character varying(510) COLLATE public.nocase,
    code character varying(80) COLLATE public.nocase,
    code_desc character varying(80) COLLATE public.nocase,
    code_default character varying(20) COLLATE public.nocase,
    seq_no integer,
    status character varying(20) COLLATE public.nocase,
    category character varying(20) COLLATE public.nocase,
    user_flag character varying(20) COLLATE public.nocase,
    code_timestamp integer,
    langid integer,
    created_date timestamp without time zone,
    created_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_wmsquickcodes ALTER COLUMN code_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_wmsquickcodes_code_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_pkey PRIMARY KEY (code_key);

ALTER TABLE ONLY dwh.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_ukey UNIQUE (code_ou, code_type, code);