CREATE TABLE dwh.f_acapassethdr (
    f_acapassethdr_key bigint NOT NULL,
    ou_id integer,
    cap_number character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    a_timestamp integer,
    cap_date timestamp without time zone,
    cap_status character varying(50) COLLATE public.nocase,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    asset_group character varying(50) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    asset_cost numeric(13,2),
    asset_location character varying(40) COLLATE public.nocase,
    seq_no integer,
    as_on_date timestamp without time zone,
    asset_type character varying(20) COLLATE public.nocase,
    asset_status character varying(50) COLLATE public.nocase,
    transaction_date timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    remarks character varying(510) COLLATE public.nocase,
    laccount_code character varying(80) COLLATE public.nocase,
    laccount_desc character varying(120) COLLATE public.nocase,
    lcost_center character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_acapassethdr ALTER COLUMN f_acapassethdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_acapassethdr_f_acapassethdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_acapassethdr
    ADD CONSTRAINT f_acapassethdr_pkey PRIMARY KEY (f_acapassethdr_key);

ALTER TABLE ONLY dwh.f_acapassethdr
    ADD CONSTRAINT f_acapassethdr_ukey UNIQUE (ou_id, cap_number, asset_number);

CREATE INDEX f_acapassethdr_key_idx ON dwh.f_acapassethdr USING btree (ou_id, cap_number, asset_number);