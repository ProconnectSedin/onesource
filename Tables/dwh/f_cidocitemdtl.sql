-- Table: dwh.f_cidocitemdtl

-- DROP TABLE IF EXISTS dwh.f_cidocitemdtl;

CREATE TABLE IF NOT EXISTS dwh.f_cidocitemdtl
(
    ci_doc_item_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    cidocitemdtl_company_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    batch_id character varying(256) COLLATE public.nocase,
    component_id character varying(32) COLLATE public.nocase,
    company_code character varying(20) COLLATE public.nocase,
    lo_id character varying(40) COLLATE public.nocase,
    item_tcd_code character varying(64) COLLATE public.nocase,
    item_tcd_var character varying(64) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    item_qty numeric(25,2),
    unit_price numeric(25,2),
    item_type character varying(50) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
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
    CONSTRAINT f_cidocitemdtl_pkey PRIMARY KEY (ci_doc_item_dtl_key),
    CONSTRAINT f_cidocitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no),
    CONSTRAINT f_cidocitemdtl_cidocitemdtl_company_key_fkey FOREIGN KEY (cidocitemdtl_company_key)
        REFERENCES dwh.d_company (company_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_cidocitemdtl
    OWNER to proconnect;