-- Table: dwh.f_sinpogrmap

-- DROP TABLE IF EXISTS dwh.f_sinpogrmap;

CREATE TABLE IF NOT EXISTS dwh.f_sinpogrmap
(
    sinpogrmap_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    line_no integer,
    ref_doc_ou integer,
    ref_doc_no character varying(40) COLLATE public.nocase,
    ref_doc_line_no integer,
    pors_type character varying(20) COLLATE public.nocase,
    po_ou integer,
    po_no character varying(40) COLLATE public.nocase,
    po_line_no integer,
    po_amendment_no integer,
    item_type character varying(10) COLLATE public.nocase,
    item_tcd_code character varying(80) COLLATE public.nocase,
    item_tcd_var character varying(80) COLLATE public.nocase,
    recd_qty numeric(25,2),
    recd_amount numeric(25,2),
    acc_qty numeric(25,2),
    acc_amount numeric(25,2),
    billed_qty numeric(25,2),
    billed_amount numeric(25,2),
    matching_type character varying(80) COLLATE public.nocase,
    tolerance_type character varying(50) COLLATE public.nocase,
    tolreance_perc integer,
    proposed_qty numeric(25,2),
    proposed_rate numeric(25,2),
    proposed_amount numeric(25,2),
    matched_qty numeric(25,2),
    matched_amount numeric(25,2),
    match_status character varying(10) COLLATE public.nocase,
    positivematch_status character varying(10) COLLATE public.nocase,
    negativematch_status character varying(10) COLLATE public.nocase,
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
    CONSTRAINT f_sinpogrmap_pkey PRIMARY KEY (sinpogrmap_key),
    CONSTRAINT f_sinpogrmap_ukey UNIQUE (tran_ou, tran_no, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sinpogrmap
    OWNER to proconnect;
-- Index: f_sinpogrmap_key_idx

-- DROP INDEX IF EXISTS dwh.f_sinpogrmap_key_idx;

CREATE INDEX IF NOT EXISTS f_sinpogrmap_key_idx
    ON dwh.f_sinpogrmap USING btree
    (tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;