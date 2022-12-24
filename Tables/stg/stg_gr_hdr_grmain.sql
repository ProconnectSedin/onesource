CREATE TABLE stg.stg_gr_hdr_grmain (
    gr_hdr_ouinstid integer NOT NULL,
    gr_hdr_grno character varying(72) NOT NULL COLLATE public.nocase,
    gr_hdr_grdate timestamp without time zone NOT NULL,
    gr_hdr_grstatus character(8) NOT NULL COLLATE public.nocase,
    gr_hdr_numseries character varying(40) NOT NULL COLLATE public.nocase,
    gr_hdr_grfolder character varying(40) COLLATE public.nocase,
    gr_hdr_grtype character varying(32) NOT NULL COLLATE public.nocase,
    gr_hdr_gatepassno character varying(72) COLLATE public.nocase,
    gr_hdr_gatepassdate timestamp without time zone,
    gr_hdr_transmode character varying(40) COLLATE public.nocase,
    gr_hdr_carriername character varying(600) COLLATE public.nocase,
    gr_hdr_vehicleno character varying(80) COLLATE public.nocase,
    gr_hdr_noofitems integer,
    gr_hdr_consweight numeric,
    gr_hdr_consuom character varying(40) COLLATE public.nocase,
    gr_hdr_delynoteno character varying(72) COLLATE public.nocase,
    gr_hdr_delynotedate timestamp without time zone,
    gr_hdr_empcode character varying(80) COLLATE public.nocase,
    gr_hdr_orderdoc character varying(32) NOT NULL COLLATE public.nocase,
    gr_hdr_orderou integer NOT NULL,
    gr_hdr_orderno character varying(72) NOT NULL COLLATE public.nocase,
    gr_hdr_orderamendno integer NOT NULL,
    gr_hdr_orderdate timestamp without time zone NOT NULL,
    gr_hdr_orderapprdate timestamp without time zone,
    gr_hdr_orderfolder character varying(40) COLLATE public.nocase,
    gr_hdr_contperson character varying(240) COLLATE public.nocase,
    gr_hdr_refdoc character varying(32) COLLATE public.nocase,
    gr_hdr_refdocno character varying(72) COLLATE public.nocase,
    gr_hdr_refdoclineno integer,
    gr_hdr_suppcode character varying(72) NOT NULL COLLATE public.nocase,
    gr_hdr_shipfromid character varying(24) NOT NULL COLLATE public.nocase,
    gr_hdr_autoinvoice character varying(32) COLLATE public.nocase,
    gr_hdr_invoiceat integer,
    gr_hdr_pay2sypplier character varying(64) COLLATE public.nocase,
    gr_hdr_invbeforegr character varying(32) COLLATE public.nocase,
    gr_hdr_docvalue numeric,
    gr_hdr_addlcharges numeric,
    gr_hdr_tcdtotalvalue numeric,
    gr_hdr_totalvalue numeric,
    gr_hdr_exchrate numeric,
    gr_hdr_currency character(20) NOT NULL COLLATE public.nocase,
    gr_hdr_frdate timestamp without time zone,
    gr_hdr_fadate timestamp without time zone,
    gr_hdr_fmdate timestamp without time zone,
    gr_hdr_tcddocvalue numeric,
    gr_hdr_otcddocvalue numeric,
    gr_hdr_vatincl character varying(32) COLLATE public.nocase,
    gr_hdr_retainchrg character varying(32) COLLATE public.nocase,
    gr_hdr_createdby character varying(120) NOT NULL COLLATE public.nocase,
    gr_hdr_createdate timestamp without time zone NOT NULL,
    gr_hdr_modifiedby character varying(120) COLLATE public.nocase,
    gr_hdr_modifieddate timestamp without time zone,
    gr_hdr_timestamp integer,
    gr_hdr_invoicevalue numeric,
    gr_hdr_remarks character varying(400) COLLATE public.nocase,
    gr_hdr_refou integer,
    gr_hdr_vatcharges numeric,
    gr_hdr_nonvatcharges numeric,
    gr_hdr_doclvldisc numeric,
    gr_hdr_totexclamt numeric,
    gr_hdr_totinclamt numeric,
    gr_hdr_totvatamt numeric,
    gr_hdr_tcal_status character varying(48) COLLATE public.nocase,
    gr_hdr_total_tcal_amount numeric,
    gr_hdr_tot_excludingtcal_amount numeric,
    gr_hdr_tareweight numeric,
    gr_hdr_grossweight numeric,
    gr_hdr_weight numeric,
    gr_hdr_entryno character varying(72) COLLATE public.nocase,
    gr_hdr_lc_no character varying(120) COLLATE public.nocase,
    gr_hdr_ref_id character varying(160) COLLATE public.nocase,
    gr_hdr_lr_no character varying(300) COLLATE public.nocase,
    gr_hdr_lr_date timestamp without time zone,
    gr_hdr_revdate timestamp without time zone,
    gr_hdr_revremrks character varying(1020) COLLATE public.nocase,
    gr_hdr_revres_cd character varying(40) COLLATE public.nocase,
    gr_hdr_revres_dsc character varying(1020) COLLATE public.nocase,
    gr_hdr_form57f character varying(160) COLLATE public.nocase,
    gr_hdr_staxformno character varying(160) COLLATE public.nocase,
    gr_hdr_roadpermitno character varying(160) COLLATE public.nocase,
    gr_hdr_tripsheetno character varying(160) COLLATE public.nocase,
    gr_hdr_suppinvno character varying(400) COLLATE public.nocase,
    gr_hdr_suppinvdate timestamp without time zone,
    gr_hdr_genfrom character varying(100) COLLATE public.nocase,
    gr_hdr_party_tax_region character varying(40) COLLATE public.nocase,
    gr_hdr_party_regd_no character varying(160) COLLATE public.nocase,
    gr_hdr_own_tax_region character varying(40) COLLATE public.nocase,
    gr_hdr_vessel_code character varying(280) COLLATE public.nocase,
    gr_hdr_vessel_name character varying(1000) COLLATE public.nocase,
    gr_hdr_voyage_id character varying(1000) COLLATE public.nocase,
    gr_hdr_additional_info character varying(4000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);