-- Table: dwh.f_sdinapportionedtcddtl

-- DROP TABLE IF EXISTS dwh.f_sdinapportionedtcddtl;

CREATE TABLE IF NOT EXISTS dwh.f_sdinapportionedtcddtl
(
    sdinapportionedtcddtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    currency_key bigint NOT NULL,
    itm_hdr_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    tcd_version integer,
    "timestamp" integer,
    item_type character varying(10) COLLATE public.nocase,
    tcd_rate numeric(13,2),
    taxable_amt numeric(13,2),
    tcd_amount numeric(13,2),
    tcd_currency character varying(10) COLLATE public.nocase,
    base_amount numeric(13,2),
    par_base_amount numeric(13,2),
    cost_center character varying(20) COLLATE public.nocase,
    analysis_code character varying(10) COLLATE public.nocase,
    subanalysis_code character varying(10) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
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
    CONSTRAINT f_sdinapportionedtcddtl_pkey PRIMARY KEY (sdinapportionedtcddtl_key),
    CONSTRAINT f_sdinapportionedtcddtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, item_tcd_code, item_tcd_var, tcd_version),
    CONSTRAINT f_sdinapportionedtcddtl_currency_key_fkey FOREIGN KEY (currency_key)
        REFERENCES dwh.d_currency (curr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT f_sdinapportionedtcddtl_itm_hdr_key_fkey FOREIGN KEY (itm_hdr_key)
        REFERENCES dwh.d_itemheader (itm_hdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sdinapportionedtcddtl
    OWNER to proconnect;
-- Index: f_sdinapportionedtcddtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_sdinapportionedtcddtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_sdinapportionedtcddtl_key_idx1
    ON dwh.f_sdinapportionedtcddtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST, item_tcd_code COLLATE public.nocase ASC NULLS LAST, item_tcd_var COLLATE public.nocase ASC NULLS LAST, tcd_version ASC NULLS LAST)
    TABLESPACE pg_default;