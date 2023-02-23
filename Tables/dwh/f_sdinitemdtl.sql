-- Table: dwh.f_sdinitemdtl

-- DROP TABLE IF EXISTS dwh.f_sdinitemdtl;

CREATE TABLE IF NOT EXISTS dwh.f_sdinitemdtl
(
    sdin_itm_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(36) COLLATE public.nocase,
    line_no integer,
    "timestamp" integer,
    visible_line_no integer,
    gr_ou integer,
    gr_no character varying(36) COLLATE public.nocase,
    item_tcd_code character varying(64) COLLATE public.nocase,
    item_tcd_var character varying(64) COLLATE public.nocase,
    uom character varying(30) COLLATE public.nocase,
    item_qty numeric(25,2),
    item_rate numeric(25,2),
    rate_per numeric(25,2),
    item_amount numeric(25,2),
    line_amount numeric(25,2),
    base_amount numeric(25,2),
    usage character varying(80) COLLATE public.nocase,
    proposal_no character varying(36) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    base_value numeric(25,2),
    accountusageid character varying(40) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    decl_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sdinitemdtl_pkey PRIMARY KEY (sdin_itm_dtl_key),
    CONSTRAINT f_sdinitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sdinitemdtl
    OWNER to proconnect;