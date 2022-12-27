CREATE TABLE raw.raw_prq_preqm_pur_reqst_hdr (
    raw_id bigint NOT NULL,
    preqm_prou integer NOT NULL,
    preqm_prno character varying(72) NOT NULL COLLATE public.nocase,
    preqm_prtype character varying(32) NOT NULL COLLATE public.nocase,
    preqm_prmode character varying(32) NOT NULL COLLATE public.nocase,
    preqm_folder character varying(40) COLLATE public.nocase,
    preqm_orgsource character varying(32) COLLATE public.nocase,
    preqm_prdate timestamp without time zone NOT NULL,
    preqm_authdate timestamp without time zone,
    preqm_status character varying(32) NOT NULL COLLATE public.nocase,
    preqm_ou_po integer NOT NULL,
    preqm_ou_gr integer NOT NULL,
    preqm_currency character(20) NOT NULL COLLATE public.nocase,
    preqm_prvalue numeric,
    preqm_pcstatus character varying(48) COLLATE public.nocase,
    preqm_remarks character varying(1020) COLLATE public.nocase,
    preqm_reasoncode character varying(40) COLLATE public.nocase,
    preqm_requesterid character varying(100) COLLATE public.nocase,
    preqm_hold character varying(32) NOT NULL COLLATE public.nocase,
    preqm_createdby character varying(120) NOT NULL COLLATE public.nocase,
    preqm_createddate timestamp without time zone NOT NULL,
    preqm_lastmodifiedby character varying(120) NOT NULL COLLATE public.nocase,
    preqm_lastmodifieddate timestamp without time zone NOT NULL,
    preqm_timestamp_value integer NOT NULL,
    preqm_req_name character varying(480) COLLATE public.nocase,
    wf_status character varying(40) COLLATE public.nocase,
    preqm_exchange_rate numeric DEFAULT 1 NOT NULL,
    preqm_wf_docid character varying(512) COLLATE public.nocase,
    preqm_num_series character varying(40) COLLATE public.nocase,
    preqm_prjcode character varying(280) COLLATE public.nocase,
    preqm_prjou integer,
    preqm_mobile_flag character varying(48) DEFAULT 'N'::character varying NOT NULL COLLATE public.nocase,
    preqm_auth_remarks character varying(1020) COLLATE public.nocase,
    preqm_adhocplng character varying(32) DEFAULT 'NA'::character varying COLLATE public.nocase,
    preqm_clientcode character varying(64) COLLATE public.nocase,
    preqm_budgetdescription character varying(1020) COLLATE public.nocase,
    preqm_requested_for character varying(100) COLLATE public.nocase,
    preqm_createdfrm character varying(40) COLLATE public.nocase,
    preqm_cls_code character varying(40) COLLATE public.nocase,
    preqm_scls_code character varying(40) COLLATE public.nocase,
    preqm_reason_return character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_prq_preqm_pur_reqst_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_prq_preqm_pur_reqst_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_prq_preqm_pur_reqst_hdr
    ADD CONSTRAINT raw_prq_preqm_pur_reqst_hdr_pkey PRIMARY KEY (raw_id);