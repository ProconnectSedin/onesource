-- Table: stg.stg_mac_acc_ce_cc_mapping

-- DROP TABLE IF EXISTS stg.stg_mac_acc_ce_cc_mapping;

CREATE TABLE IF NOT EXISTS stg.stg_mac_acc_ce_cc_mapping
(
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_mac_acc_ce_cc_mapping
    OWNER to proconnect;