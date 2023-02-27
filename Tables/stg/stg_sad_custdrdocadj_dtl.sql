-- Table: stg.stg_sad_custdrdocadj_dtl

-- DROP TABLE IF EXISTS stg.stg_sad_custdrdocadj_dtl;

CREATE TABLE IF NOT EXISTS stg.stg_sad_custdrdocadj_dtl
(
    ou_id integer NOT NULL,
    adjustment_no character varying(72) COLLATE public.nocase NOT NULL,
    dr_doc_ou integer NOT NULL,
    dr_doc_type character varying(160) COLLATE public.nocase NOT NULL,
    dr_doc_no character varying(72) COLLATE public.nocase NOT NULL,
    term_no character varying(80) COLLATE public.nocase NOT NULL,
    au_due_date timestamp without time zone,
    au_dr_doc_unadj_amt numeric,
    au_cust_code character varying(72) COLLATE public.nocase,
    au_dr_doc_cur character varying(20) COLLATE public.nocase,
    au_crosscur_erate numeric,
    discount numeric,
    charges numeric,
    writeoff_amount numeric,
    dr_doc_adj_amt numeric,
    proposed_discount numeric,
    proposed_charges numeric,
    au_discount_date timestamp without time zone,
    au_billing_point integer,
    au_dr_doc_date timestamp without time zone,
    au_fb_id character varying(80) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    guid character varying(512) COLLATE public.nocase,
    au_base_exrate numeric,
    au_par_base_exrate numeric,
    au_disc_available numeric,
    adjustment_amt numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk__sad_cust__3f15cf30366c5a8a UNIQUE (ou_id, adjustment_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sad_custdrdocadj_dtl
    OWNER to proconnect;
-- Index: stg_sad_custdrdocadj_dtl_key_idx2

-- DROP INDEX IF EXISTS stg.stg_sad_custdrdocadj_dtl_key_idx2;

CREATE INDEX IF NOT EXISTS stg_sad_custdrdocadj_dtl_key_idx2
    ON stg.stg_sad_custdrdocadj_dtl USING btree
    (ou_id ASC NULLS LAST, adjustment_no COLLATE public.nocase ASC NULLS LAST, dr_doc_ou ASC NULLS LAST, dr_doc_type COLLATE public.nocase ASC NULLS LAST, dr_doc_no COLLATE public.nocase ASC NULLS LAST, term_no COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;