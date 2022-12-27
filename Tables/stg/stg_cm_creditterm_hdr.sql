CREATE TABLE stg.stg_cm_creditterm_hdr (
    companybu_code character varying(80) NOT NULL COLLATE public.nocase,
    type_flag character varying(16) NOT NULL COLLATE public.nocase,
    creditterm_code character varying(80) NOT NULL COLLATE public.nocase,
    "timestamp" integer NOT NULL,
    creditterm_desc character varying(400) COLLATE public.nocase,
    single_orderlimit numeric,
    total_orderlimit numeric,
    dunning_reqd character varying(16) COLLATE public.nocase,
    creditchk_action character varying(1020) COLLATE public.nocase,
    creditchk_level character varying(120) COLLATE public.nocase,
    discntgrace_days integer,
    regrace_days integer,
    reswriteoff_per numeric,
    reswriteoff_amt numeric,
    creditterm_status character varying(8) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    app_res_writeoff character(12) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_cm_creditterm_hdr
    ADD CONSTRAINT cm_creditterm_hdr_pkey PRIMARY KEY (companybu_code, type_flag, creditterm_code);