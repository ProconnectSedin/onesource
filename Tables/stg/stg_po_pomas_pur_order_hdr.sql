CREATE TABLE stg.stg_po_pomas_pur_order_hdr (
    pomas_poou integer NOT NULL,
    pomas_pono character varying(72) NOT NULL COLLATE public.nocase,
    pomas_poamendmentno integer NOT NULL,
    pomas_podate timestamp without time zone NOT NULL,
    pomas_poauthdate timestamp without time zone,
    pomas_podocstatus character varying(32) NOT NULL COLLATE public.nocase,
    pomas_potype character varying(32) NOT NULL COLLATE public.nocase,
    pomas_loitoorder integer NOT NULL,
    pomas_loi integer NOT NULL,
    pomas_hold integer NOT NULL,
    pomas_orgsource character varying(32) NOT NULL COLLATE public.nocase,
    pomas_requoteno character varying(72) COLLATE public.nocase,
    pomas_suppliercode character varying(64) COLLATE public.nocase,
    pomas_contactperson character varying(180) COLLATE public.nocase,
    pomas_buyercode character varying(80) COLLATE public.nocase,
    pomas_pocurrency character(20) COLLATE public.nocase,
    pomas_exchangerate numeric NOT NULL,
    pomas_pobasicvalue numeric NOT NULL,
    pomas_tcdtotalrate numeric,
    pomas_poaddlncharge numeric,
    pomas_folder character varying(40) COLLATE public.nocase,
    pomas_remarks character varying(1020) COLLATE public.nocase,
    pomas_createdby character varying(120) NOT NULL COLLATE public.nocase,
    pomas_holdreason character varying(40) COLLATE public.nocase,
    pomas_createddate timestamp without time zone NOT NULL,
    pomas_lastmodifiedby character varying(120) NOT NULL COLLATE public.nocase,
    pomas_lastmodifieddate timestamp without time zone NOT NULL,
    pomas_timestamp integer NOT NULL,
    pomas_avgvatrate numeric,
    pomas_vatinclusive character varying(32) COLLATE public.nocase,
    pomas_pcstatus character varying(48) COLLATE public.nocase,
    pomas_filename character varying(1020) COLLATE public.nocase,
    pomas_tax_status character varying(32) COLLATE public.nocase,
    pomas_tcal_total_amount numeric,
    pomas_tcal_excl_amount numeric,
    pomas_qpoflag integer,
    pomas_wfstatus character varying(40) COLLATE public.nocase,
    pomas_imports character(12) COLLATE public.nocase,
    pomas_shipfrm character varying(80) COLLATE public.nocase,
    pomas_numseries character varying(40) COLLATE public.nocase,
    pomas_refdocno character varying(72) COLLATE public.nocase,
    pomas_refdocou integer,
    pomas_ms_app_flag character varying(32) COLLATE public.nocase,
    pomas_retentionperc numeric,
    pomas_ret_postol numeric,
    pomas_ret_negtol numeric,
    pomas_so_no character varying(72) COLLATE public.nocase,
    pomas_so_ou integer,
    pomas_so_amendno integer,
    pomas_amd_srccomp character varying(32) COLLATE public.nocase,
    pomas_poamendmentdate timestamp without time zone,
    gen_from character varying(80) COLLATE public.nocase,
    pomas_clientcode character varying(64) COLLATE public.nocase,
    pomas_budgetdescription character varying(1020) COLLATE public.nocase,
    pomas_location character varying(120) COLLATE public.nocase,
    poitm_location character varying(64) COLLATE public.nocase,
    pomas_contract character(12) COLLATE public.nocase,
    pomas_party_tax_region character varying(40) COLLATE public.nocase,
    pomas_party_regd_no character varying(160) COLLATE public.nocase,
    pomas_own_tax_region character varying(40) COLLATE public.nocase,
    pomas_mail_sent character varying(32) COLLATE public.nocase,
    pomas_cls_code character varying(40) COLLATE public.nocase,
    pomas_scls_code character varying(40) COLLATE public.nocase,
    pomas_auth_remarks character varying(1020) COLLATE public.nocase,
    pomas_reason_return character varying(600) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);