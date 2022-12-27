CREATE TABLE raw.raw_adep_depr_rate_hdr (
    raw_id bigint NOT NULL,
    ou_id integer NOT NULL,
    asset_class character varying(80) NOT NULL COLLATE public.nocase,
    depr_rate_id character varying(80) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    depr_rate_desc character varying(160) COLLATE public.nocase,
    depr_rate_status character varying(100) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_adep_depr_rate_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_adep_depr_rate_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_adep_depr_rate_hdr
    ADD CONSTRAINT raw_adep_depr_rate_hdr_pkey PRIMARY KEY (raw_id);