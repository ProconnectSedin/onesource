CREATE TABLE stg.stg_scdn_acc_dtl (
    tran_type character varying(40) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    account_code character varying(128) COLLATE public.nocase,
    drcr_id character varying(4) COLLATE public.nocase,
    ref_doc_type character varying(40) COLLATE public.nocase,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_date timestamp without time zone,
    ref_doc_amount numeric,
    ordering_ou integer,
    tran_amount numeric,
    remarks character varying(1020) COLLATE public.nocase,
    cost_center character varying(40) COLLATE public.nocase,
    analysis_code character varying(20) COLLATE public.nocase,
    subanalysis_code character varying(20) COLLATE public.nocase,
    base_amount numeric,
    par_base_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    cfs_refdoc_ou integer,
    cfs_refdoc_no character varying(72) COLLATE public.nocase,
    cfs_refdoc_type character varying(160) COLLATE public.nocase,
    usageid character varying(80) COLLATE public.nocase,
    desti_ou character varying(64) COLLATE public.nocase,
    desti_sac character varying(20) COLLATE public.nocase,
    interfbjvno character varying(72) COLLATE public.nocase,
    desti_ac character varying(20) COLLATE public.nocase,
    desti_acccode character varying(128) COLLATE public.nocase,
    desti_accdescrip character varying(240) COLLATE public.nocase,
    desti_cc character varying(128) COLLATE public.nocase,
    desti_comp character varying(40) COLLATE public.nocase,
    desti_fb character varying(80) COLLATE public.nocase,
    account_code_int character varying(128) COLLATE public.nocase,
    ifb_recon_jvno character varying(72) COLLATE public.nocase,
    own_tax_region character varying(40) COLLATE public.nocase,
    party_tax_region character varying(40) COLLATE public.nocase,
    decl_tax_region character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);