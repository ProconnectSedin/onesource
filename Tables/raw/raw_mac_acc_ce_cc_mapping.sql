-- Table: raw.raw_mac_acc_ce_cc_mapping

-- DROP TABLE IF EXISTS "raw".raw_mac_acc_ce_cc_mapping;

CREATE TABLE IF NOT EXISTS "raw".raw_mac_acc_ce_cc_mapping
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    account_no character varying(128) COLLATE public.nocase NOT NULL,
    element_no character varying(128) COLLATE public.nocase NOT NULL,
    center_no character varying(128) COLLATE public.nocase NOT NULL,
    effective_date timestamp without time zone NOT NULL,
    expiry_date timestamp without time zone NOT NULL,
    user_id integer NOT NULL,
    mod_datetime timestamp without time zone NOT NULL,
    "timestamp" integer,
    bu_id character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT raw_mac_acc_ce_cc_mapping_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_mac_acc_ce_cc_mapping
    OWNER to proconnect;