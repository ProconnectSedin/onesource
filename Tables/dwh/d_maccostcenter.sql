-- Table: dwh.d_maccostcenter

-- DROP TABLE IF EXISTS dwh.d_maccostcenter;

CREATE TABLE IF NOT EXISTS dwh.d_maccostcenter
(
    maccostcenter_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ou_id integer,
    company_code character varying(20) COLLATE public.nocase,
    ma_center_no character varying(80) COLLATE public.nocase,
    ma_center_leaf character varying(10) COLLATE public.nocase,
    ma_center_sdesc character varying(80) COLLATE public.nocase,
    ma_center_ldesc character varying(510) COLLATE public.nocase,
    ma_effective_date timestamp without time zone,
    ma_expiry_date timestamp without time zone,
    ma_center_resp character varying(40) COLLATE public.nocase,
    ma_ctrl_acc character varying(80) COLLATE public.nocase,
    ma_center_flag character varying(10) COLLATE public.nocase,
    ma_center_type character varying(10) COLLATE public.nocase,
    ma_par_cmpy_center character varying(64) COLLATE public.nocase,
    ma_user_id integer,
    ma_datetime timestamp without time zone,
    ma_createdby character varying(80) COLLATE public.nocase,
    ma_timestamp integer,
    ma_createdate timestamp without time zone,
    ma_modifiedby character varying(80) COLLATE public.nocase,
    ma_modifydate timestamp without time zone,
    ma_status character varying(10) COLLATE public.nocase,
    ma_org_unit integer,
    bu_id character varying(40) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    ma_wf_status character varying(50) COLLATE public.nocase,
    wf_flag character varying(30) COLLATE public.nocase,
    ma_guid character varying(260) COLLATE public.nocase,
    workflow_error character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_maccostcenter_pkey PRIMARY KEY (maccostcenter_key),
    CONSTRAINT d_maccostcenter_ukey UNIQUE (ou_id, company_code, ma_center_no, ma_center_leaf, ma_center_sdesc, ma_effective_date)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_maccostcenter
    OWNER to proconnect;
-- Index: d_maccostcenter_key_idx1

-- DROP INDEX IF EXISTS dwh.d_maccostcenter_key_idx1;

CREATE INDEX IF NOT EXISTS d_maccostcenter_key_idx1
    ON dwh.d_maccostcenter USING btree
    (ou_id ASC NULLS LAST, company_code COLLATE public.nocase ASC NULLS LAST, ma_center_no COLLATE public.nocase ASC NULLS LAST, ma_center_leaf COLLATE public.nocase ASC NULLS LAST, ma_center_sdesc COLLATE public.nocase ASC NULLS LAST, ma_effective_date ASC NULLS LAST)
    TABLESPACE pg_default;