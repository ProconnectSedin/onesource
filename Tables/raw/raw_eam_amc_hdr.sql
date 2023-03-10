CREATE TABLE raw.raw_eam_amc_hdr (
    raw_id bigint NOT NULL,
    amc_amcno character varying(280) NOT NULL COLLATE public.nocase,
    amc_amcou integer NOT NULL,
    amc_date timestamp without time zone NOT NULL,
    amc_fromdate timestamp without time zone NOT NULL,
    amc_todate timestamp without time zone NOT NULL,
    amc_revno integer NOT NULL,
    amc_timestamp integer,
    amc_lastrev_date timestamp without time zone,
    amc_type character varying(32) COLLATE public.nocase,
    amc_pay_mode character varying(32) COLLATE public.nocase,
    amc_freq character varying(32) COLLATE public.nocase,
    amc_suppcode character varying(64) NOT NULL COLLATE public.nocase,
    amc_amcamount numeric,
    amc_pono character varying(72) COLLATE public.nocase,
    amc_supp_amcrefno character varying(280) COLLATE public.nocase,
    amc_curr character(20) COLLATE public.nocase,
    amc_cont_person character varying(180) COLLATE public.nocase,
    amc_cont_no character varying(160) COLLATE public.nocase,
    amc_mailid character varying(1020) COLLATE public.nocase,
    amc_createdby character varying(120) COLLATE public.nocase,
    amc_createdate timestamp without time zone NOT NULL,
    amc_modifiedby character varying(120) COLLATE public.nocase,
    amc_modifieddate timestamp without time zone,
    amc_status character varying(32) COLLATE public.nocase,
    amc_bill_basedon character varying(32) COLLATE public.nocase,
    amc_exp_opt character varying(32) COLLATE public.nocase,
    amc_inv_type character varying(32) COLLATE public.nocase,
    amc_exp_param_val numeric,
    amc_fixed_rate numeric,
    amc_max_param_val numeric,
    amc_rate_exc_param numeric,
    amc_reas_for_rev character varying(280) COLLATE public.nocase,
    amc_expiry_param character varying(80) COLLATE public.nocase,
    amc_remarks character varying(1020) COLLATE public.nocase,
    amc_param_uom character varying(40) COLLATE public.nocase,
    amc_doctyp character varying(32) COLLATE public.nocase,
    amc_doclineno integer,
    amc_showstopper integer,
    amc_medium integer,
    amc_low integer,
    amc_critical integer,
    amc_agr_pre_visit integer,
    amc_agr_brkdwn_visit integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_eam_amc_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_eam_amc_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_eam_amc_hdr
    ADD CONSTRAINT raw_eam_amc_hdr_pkey PRIMARY KEY (raw_id);