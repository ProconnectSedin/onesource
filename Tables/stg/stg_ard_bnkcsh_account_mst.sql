CREATE TABLE stg.stg_ard_bnkcsh_account_mst (
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    bank_ptt_code character varying(128) NOT NULL COLLATE public.nocase,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    bankptt_account character varying(128) COLLATE public.nocase,
    bankcharge_account character varying(128) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    flag character varying(16) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    interim_account character varying(128) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_ard_bnkcsh_account_mst
    ADD CONSTRAINT ard_bnkcsh_account_mst_pkey PRIMARY KEY (company_code, fb_id, bank_ptt_code, effective_from, sequence_no);