CREATE TABLE dwh.f_spypaybatchhdr (
    paybatch_hdr_key bigint NOT NULL,
    curr_key bigint NOT NULL,
    ou_id integer,
    paybatch_no character varying(40) COLLATE public.nocase,
    ptimestamp integer,
    paybatch_notype character varying(20) COLLATE public.nocase,
    voucher_notype character varying(20) COLLATE public.nocase,
    request_date timestamp without time zone,
    pay_date timestamp without time zone,
    payment_route character varying(20) COLLATE public.nocase,
    elect_payment character varying(40) COLLATE public.nocase,
    pay_mode character varying(50) COLLATE public.nocase,
    relpay_ou character varying(40) COLLATE public.nocase,
    pay_chargeby character varying(40) COLLATE public.nocase,
    priority character varying(30) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    status character varying(50) COLLATE public.nocase,
    pay_currency character varying(10) COLLATE public.nocase,
    basecur_erate numeric(20,2),
    tran_type character varying(50) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    batch_id character varying(300) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    unadjppchk_flag character varying(30) COLLATE public.nocase,
    crosscur_erate numeric(20,2),
    unadjdebitchk_flag character varying(30) COLLATE public.nocase,
    ict_flag character varying(30) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_spypaybatchhdr ALTER COLUMN paybatch_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_spypaybatchhdr_paybatch_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_spypaybatchhdr
    ADD CONSTRAINT f_spypaybatchhdr_pkey PRIMARY KEY (paybatch_hdr_key);

ALTER TABLE ONLY dwh.f_spypaybatchhdr
    ADD CONSTRAINT f_spypaybatchhdr_ukey UNIQUE (ou_id, paybatch_no, ptimestamp, ict_flag);

CREATE INDEX f_spypaybatchhdr_key_idx ON dwh.f_spypaybatchhdr USING btree (curr_key);