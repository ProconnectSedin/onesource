-- Table: raw.raw_mac_cost_element

-- DROP TABLE IF EXISTS "raw".raw_mac_cost_element;

CREATE TABLE IF NOT EXISTS "raw".raw_mac_cost_element
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    ma_element_no character varying(128) COLLATE public.nocase NOT NULL,
    ma_element_sdesc character varying(160) COLLATE public.nocase,
    ma_element_ldesc character varying(1020) COLLATE public.nocase,
    ma_element_type character varying(4) COLLATE public.nocase,
    ma_element_uom character varying(40) COLLATE public.nocase,
    ma_effective_date timestamp without time zone NOT NULL,
    ma_expiry_date timestamp without time zone NOT NULL,
    ma_del_status character varying(4) COLLATE public.nocase,
    ma_status character varying(4) COLLATE public.nocase,
    ma_user_id integer NOT NULL,
    ma_datetime timestamp without time zone NOT NULL,
    ma_timestamp integer,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_createdate timestamp without time zone,
    ma_modifedby character varying(160) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    bu_id character varying(80) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT mac_cost_element_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_mac_cost_element
    OWNER to proconnect;