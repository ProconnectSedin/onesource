-- Table: stg.stg_mac_cost_center

-- DROP TABLE IF EXISTS stg.stg_mac_cost_center;

CREATE TABLE IF NOT EXISTS stg.stg_mac_cost_center
(
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
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_mac_cost_center
    OWNER to proconnect;
-- Index: stg_mac_cost_center_key_idx2

-- DROP INDEX IF EXISTS stg.stg_mac_cost_center_key_idx2;

CREATE INDEX IF NOT EXISTS stg_mac_cost_center_key_idx2
    ON stg.stg_mac_cost_center USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, ma_center_no COLLATE public.nocase ASC NULLS LAST, ma_center_leaf COLLATE public.nocase ASC NULLS LAST, ma_center_sdesc COLLATE public.nocase ASC NULLS LAST, ma_effective_date ASC NULLS LAST)
    TABLESPACE pg_default;