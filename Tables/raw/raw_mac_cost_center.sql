-- Table: raw.raw_mac_cost_center

-- DROP TABLE IF EXISTS "raw".raw_mac_cost_center;

CREATE TABLE IF NOT EXISTS "raw".raw_mac_cost_center
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer NOT NULL,
    company_code character varying(40) COLLATE public.nocase NOT NULL,
    ma_center_no character varying(128) COLLATE public.nocase NOT NULL,
    ma_center_leaf character(4) COLLATE public.nocase NOT NULL,
    ma_center_sdesc character varying(160) COLLATE public.nocase NOT NULL,
    ma_center_ldesc character varying(1020) COLLATE public.nocase,
    ma_effective_date timestamp without time zone NOT NULL,
    ma_expiry_date timestamp without time zone NOT NULL,
    ma_center_resp character varying(80) COLLATE public.nocase,
    ma_ctrl_acc character varying(128) COLLATE public.nocase NOT NULL,
    ma_center_flag character varying(4) COLLATE public.nocase NOT NULL,
    ma_center_type character varying(16) COLLATE public.nocase NOT NULL,
    ma_par_cmpy_center character varying(128) COLLATE public.nocase NOT NULL,
    ma_user_id integer NOT NULL,
    ma_datetime timestamp without time zone NOT NULL,
    ma_createdby character varying(160) COLLATE public.nocase,
    ma_timestamp integer,
    ma_createdate timestamp without time zone,
    ma_modifiedby character varying(160) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    ma_status character varying(4) COLLATE public.nocase NOT NULL,
    ma_org_unit integer,
    bu_id character varying(80) COLLATE public.nocase,
    lo_id character varying(80) COLLATE public.nocase,
    ma_wf_status character varying(100) COLLATE public.nocase,
    wf_flag character varying(48) COLLATE public.nocase,
    ma_guid character varying(512) COLLATE public.nocase,
    workflow_error character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT mac_cost_center_pkey PRIMARY KEY (raw_id)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS "raw".raw_mac_cost_center
    OWNER to proconnect;