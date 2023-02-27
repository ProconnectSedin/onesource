-- Table: dwh.f_tariffaccesshirerenthdr

-- DROP TABLE IF EXISTS dwh.f_tariffaccesshirerenthdr;

CREATE TABLE IF NOT EXISTS dwh.f_tariffaccesshirerenthdr
(
    tf_tariffaccesshirerenthdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tf_uomkey bigint NOT NULL,
    tf_acc_hrt_id character varying(36) COLLATE public.nocase,
    tf_acc_hrt_ou integer,
    tf_acc_hrt_desc character varying(510) COLLATE public.nocase,
    tf_acc_hrt_type_code character varying(16) COLLATE public.nocase,
    tf_acc_hrt_status character varying(16) COLLATE public.nocase,
    tf_acc_hrt_division character varying(32) COLLATE public.nocase,
    tf_acc_hrt_validity_id character varying(36) COLLATE public.nocase,
    tf_acc_hrt_applicability character varying(80) COLLATE public.nocase,
    tf_acc_hrt_type character varying(510) COLLATE public.nocase,
    tf_acc_hrt_time character varying(510) COLLATE public.nocase,
    tf_acc_hrt_min_charge_app integer,
    tf_acc_hrt_uom character varying(20) COLLATE public.nocase,
    tf_acc_hrt_from_space character varying(510) COLLATE public.nocase,
    tf_acc_hrt_to_space character varying(510) COLLATE public.nocase,
    tf_acc_hrt_timestamp integer,
    tf_acc_hrt_created_by character varying(60) COLLATE public.nocase,
    tf_acc_hrt_created_dt timestamp without time zone,
    tf_acc_hrt_modified_by character varying(60) COLLATE public.nocase,
    tf_acc_hrt_modified_dt timestamp without time zone,
    tf_acc_hrt_multilvl_apprvl integer,
    tf_acc_hrt_previous_status character varying(16) COLLATE public.nocase,
    tf_acc_hrt_fr_sp numeric(20,2),
    tf_acc_hrt_to_sp numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_tariffaccesshirerenthdr_pkey PRIMARY KEY (tf_tariffaccesshirerenthdr_key),
    CONSTRAINT f_tariffaccesshirerenthdr_ukey UNIQUE (tf_acc_hrt_id, tf_acc_hrt_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_tariffaccesshirerenthdr
    OWNER to proconnect;
-- Index: f_tariffaccesshirerenthdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_tariffaccesshirerenthdr_key_idx;

CREATE INDEX IF NOT EXISTS f_tariffaccesshirerenthdr_key_idx
    ON dwh.f_tariffaccesshirerenthdr USING btree
    (tf_acc_hrt_id COLLATE public.nocase ASC NULLS LAST, tf_acc_hrt_ou ASC NULLS LAST)
    TABLESPACE pg_default;