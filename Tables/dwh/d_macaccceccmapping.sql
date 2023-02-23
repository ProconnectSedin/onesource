-- Table: dwh.d_macaccceccmapping

-- DROP TABLE IF EXISTS dwh.d_macaccceccmapping;

CREATE TABLE IF NOT EXISTS dwh.d_macaccceccmapping
(
    mac_acc_cecc_mapping_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    account_no character varying(64) COLLATE public.nocase,
    element_no character varying(64) COLLATE public.nocase,
    center_no character varying(64) COLLATE public.nocase,
    effective_date timestamp without time zone,
    expiry_date timestamp without time zone,
    user_id integer,
    mod_datetime timestamp without time zone,
    "timestamp" integer,
    bu_id character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_macaccceccmapping_pkey PRIMARY KEY (mac_acc_cecc_mapping_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_macaccceccmapping
    OWNER to proconnect;