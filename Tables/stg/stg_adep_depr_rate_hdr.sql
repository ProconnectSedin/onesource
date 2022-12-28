CREATE TABLE stg.stg_adep_depr_rate_hdr (
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

ALTER TABLE ONLY stg.stg_adep_depr_rate_hdr
    ADD CONSTRAINT adep_depr_rate_hdr_pkey PRIMARY KEY (ou_id, asset_class, depr_rate_id);