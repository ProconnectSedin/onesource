CREATE TABLE dwh.f_aplanacqproposalhdr (
    pln_pro_key bigint NOT NULL,
    pln_pro_curr_key bigint NOT NULL,
    ou_id integer,
    fb_id character varying(40) COLLATE public.nocase,
    financial_year character varying(30) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    currency_code character varying(10) COLLATE public.nocase,
    proposal_number character varying(40) COLLATE public.nocase,
    "timestamp" integer,
    proposal_date timestamp without time zone,
    numbering_typeno character varying(20) COLLATE public.nocase,
    proposal_desc character varying(80) COLLATE public.nocase,
    budget_number character varying(40) COLLATE public.nocase,
    board_ref character varying(200) COLLATE public.nocase,
    board_ref_date timestamp without time zone,
    expiry_date timestamp without time zone,
    exchange_rate numeric(13,2),
    total_proposed_cost_bc numeric(13,2),
    proposed_cost_variance numeric(13,2),
    proposal_status character varying(50) COLLATE public.nocase,
    amendment_number character varying(40) COLLATE public.nocase,
    proposed_cost numeric(13,2),
    commited_amount numeric(13,2),
    liability_amount numeric(13,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    addnl_entity character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_aplanacqproposalhdr ALTER COLUMN pln_pro_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_aplanacqproposalhdr_pln_pro_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_pkey PRIMARY KEY (pln_pro_key);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_ukey UNIQUE (ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, addnl_entity);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_pln_pro_curr_key_fkey FOREIGN KEY (pln_pro_curr_key) REFERENCES dwh.d_currency(curr_key);

CREATE INDEX f_aplanacqproposalhdr_key_idx ON dwh.f_aplanacqproposalhdr USING btree (pln_pro_curr_key);

CREATE INDEX f_aplanacqproposalhdr_key_idx1 ON dwh.f_aplanacqproposalhdr USING btree (ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, addnl_entity);