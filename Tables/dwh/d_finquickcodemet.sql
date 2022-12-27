CREATE TABLE dwh.d_finquickcodemet (
    d_finquickcodemet_key bigint NOT NULL,
    component_id character varying(40) COLLATE public.nocase,
    parameter_type character varying(20) COLLATE public.nocase,
    parameter_category character varying(40) COLLATE public.nocase,
    parameter_code character varying(40) COLLATE public.nocase,
    parameter_text character varying(510) COLLATE public.nocase,
    "timestamp" integer,
    language_id integer,
    extension_flag character varying(10) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    sequence_no integer,
    cml_len integer,
    cml_translate character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_finquickcodemet ALTER COLUMN d_finquickcodemet_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_finquickcodemet_d_finquickcodemet_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_finquickcodemet
    ADD CONSTRAINT d_finquickcodemet_pkey PRIMARY KEY (d_finquickcodemet_key);