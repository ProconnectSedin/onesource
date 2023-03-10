CREATE TABLE dwh.d_currency (
    curr_key bigint NOT NULL,
    iso_curr_code character varying(10) COLLATE public.nocase,
    serial_no integer,
    ctimestamp integer,
    num_curr_code character varying(10) COLLATE public.nocase,
    curr_symbol character varying(10) COLLATE public.nocase,
    curr_desc character varying(250) COLLATE public.nocase,
    curr_sub_units integer,
    curr_sub_unit_desc character varying(250) COLLATE public.nocase,
    curr_units integer,
    currency_status character varying(60) COLLATE public.nocase,
    curr_symbol_flag character varying(40) COLLATE public.nocase,
    effective_from timestamp without time zone,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_currency ALTER COLUMN curr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_currency_curr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_currency
    ADD CONSTRAINT d_currency_pkey PRIMARY KEY (curr_key);

ALTER TABLE ONLY dwh.d_currency
    ADD CONSTRAINT d_currency_ukey UNIQUE (iso_curr_code, serial_no);