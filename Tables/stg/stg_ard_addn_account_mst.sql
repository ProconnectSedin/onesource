CREATE TABLE stg.stg_ard_addn_account_mst (
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    usage_id character varying(80) NOT NULL COLLATE public.nocase,
    effective_from timestamp without time zone NOT NULL,
    currency_code character varying(20) NOT NULL COLLATE public.nocase,
    drcr_flag character varying(16) NOT NULL COLLATE public.nocase,
    dest_fbid character varying(80) NOT NULL COLLATE public.nocase,
    child_company character varying(40) NOT NULL COLLATE public.nocase,
    dest_company character varying(40) NOT NULL COLLATE public.nocase,
    sequence_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    account_code character varying(128) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    usage_type character varying(16) COLLATE public.nocase,
    ard_type character varying(80) COLLATE public.nocase,
    flag character varying(16) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_ard_addn_account_mst
    ADD CONSTRAINT ard_addn_account_mst_pkey PRIMARY KEY (company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no);