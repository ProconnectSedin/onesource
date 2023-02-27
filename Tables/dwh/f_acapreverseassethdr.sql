-- Table: dwh.f_acapreverseassethdr

-- DROP TABLE IF EXISTS dwh.f_acapreverseassethdr;

CREATE TABLE IF NOT EXISTS dwh.f_acapreverseassethdr
(
    acap_reverse_asset_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    document_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    tran_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_group character varying(50) COLLATE public.nocase,
    remarks character varying(200) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_acapreverseassethdr_pkey PRIMARY KEY (acap_reverse_asset_hdr_key),
    CONSTRAINT f_acapreverseassethdr_ukey UNIQUE (ou_id, document_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_acapreverseassethdr
    OWNER to proconnect;