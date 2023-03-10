CREATE TABLE dwh.f_purchasereqheader (
    preqm_hr_key bigint NOT NULL,
    preqm_hr_curr_key bigint NOT NULL,
    preqm_prou integer,
    preqm_prno character varying(40) COLLATE public.nocase,
    preqm_prtype character varying(20) COLLATE public.nocase,
    preqm_prmode character varying(20) COLLATE public.nocase,
    preqm_folder character varying(20) COLLATE public.nocase,
    preqm_orgsource character varying(20) COLLATE public.nocase,
    preqm_prdate timestamp without time zone,
    preqm_authdate timestamp without time zone,
    preqm_status character varying(20) COLLATE public.nocase,
    preqm_ou_po integer,
    preqm_ou_gr integer,
    preqm_currency character varying(20) COLLATE public.nocase,
    preqm_prvalue numeric(20,2),
    preqm_remarks character varying(510) COLLATE public.nocase,
    preqm_reasoncode character varying(20) COLLATE public.nocase,
    preqm_requesterid character varying(50) COLLATE public.nocase,
    preqm_hold character varying(20) COLLATE public.nocase,
    preqm_createdby character varying(60) COLLATE public.nocase,
    preqm_createddate timestamp without time zone,
    preqm_lastmodifiedby character varying(60) COLLATE public.nocase,
    preqm_lastmodifieddate timestamp without time zone,
    preqm_timestamp_value integer,
    preqm_req_name character varying(250) COLLATE public.nocase,
    preqm_exchange_rate numeric(20,2),
    preqm_num_series character varying(20) COLLATE public.nocase,
    preqm_mobile_flag character varying(30) COLLATE public.nocase,
    preqm_auth_remarks character varying(510) COLLATE public.nocase,
    preqm_adhocplng character varying(20) COLLATE public.nocase,
    preqm_requested_for character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_purchasereqheader ALTER COLUMN preqm_hr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_purchasereqheader_preqm_hr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_pkey PRIMARY KEY (preqm_hr_key);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_ukey UNIQUE (preqm_prou, preqm_prno);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_preqm_hr_curr_key_fkey FOREIGN KEY (preqm_hr_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_purchasereqheader_key_idx ON dwh.f_purchasereqheader USING btree (preqm_hr_curr_key);

CREATE INDEX f_purchasereqheader_key_idx1 ON dwh.f_purchasereqheader USING btree (preqm_prou, preqm_prno);