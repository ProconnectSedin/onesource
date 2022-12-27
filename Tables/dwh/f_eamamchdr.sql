CREATE TABLE dwh.f_eamamchdr (
    amc_hdr_key bigint NOT NULL,
    amc_vendor_key bigint NOT NULL,
    amc_curr_key bigint NOT NULL,
    amc_amcno character varying(140) COLLATE public.nocase,
    amc_amcou integer,
    amc_date timestamp without time zone,
    amc_fromdate timestamp without time zone,
    amc_todate timestamp without time zone,
    amc_revno integer,
    amc_timestamp integer,
    amc_type character varying(20) COLLATE public.nocase,
    amc_pay_mode character varying(20) COLLATE public.nocase,
    amc_freq character varying(20) COLLATE public.nocase,
    amc_suppcode character varying(40) COLLATE public.nocase,
    amc_amcamount numeric(20,2),
    amc_pono character varying(40) COLLATE public.nocase,
    amc_supp_amcrefno character varying(140) COLLATE public.nocase,
    amc_curr character varying(20) COLLATE public.nocase,
    amc_cont_person character varying(90) COLLATE public.nocase,
    amc_mailid character varying(510) COLLATE public.nocase,
    amc_createdby character varying(60) COLLATE public.nocase,
    amc_createdate timestamp without time zone,
    amc_modifiedby character varying(60) COLLATE public.nocase,
    amc_modifieddate timestamp without time zone,
    amc_status character varying(20) COLLATE public.nocase,
    amc_bill_basedon character varying(20) COLLATE public.nocase,
    amc_exp_opt character varying(20) COLLATE public.nocase,
    amc_inv_type character varying(20) COLLATE public.nocase,
    amc_fixed_rate numeric(20,2),
    amc_rate_exc_param numeric(20,2),
    amc_remarks character varying(510) COLLATE public.nocase,
    amc_doctyp character varying(20) COLLATE public.nocase,
    amc_doclineno integer,
    amc_agr_pre_visit integer,
    amc_agr_brkdwn_visit integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_eamamchdr ALTER COLUMN amc_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_eamamchdr_amc_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_eamamchdr
    ADD CONSTRAINT f_eamamchdr_pkey PRIMARY KEY (amc_hdr_key);

ALTER TABLE ONLY dwh.f_eamamchdr
    ADD CONSTRAINT f_eamamchdr_ukey UNIQUE (amc_amcno, amc_amcou, amc_date, amc_fromdate, amc_todate, amc_revno, amc_suppcode, amc_createdate);

CREATE INDEX f_eamamchdr_key_idx ON dwh.f_eamamchdr USING btree (amc_vendor_key, amc_curr_key);