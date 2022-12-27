CREATE TABLE dwh.f_divisionareadetail (
    div_dtl_key bigint NOT NULL,
    div_key bigint NOT NULL,
    div_code character varying(20) COLLATE public.nocase,
    div_ou integer,
    div_length numeric(20,2),
    div_breath numeric(20,2),
    div_height numeric(20,2),
    div_uom character varying(20) COLLATE public.nocase,
    div_area_uom character varying(20) COLLATE public.nocase,
    div_tot_area numeric(20,2),
    div_tot_stag_area numeric(20,2),
    div_storg_area numeric(20,2),
    div_tot_docks numeric(20,2),
    div_other_area numeric(20,2),
    div_office_area numeric(20,2),
    div_outbound_area numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_divisionareadetail ALTER COLUMN div_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_divisionareadetail_div_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_divisionareadetail
    ADD CONSTRAINT f_divisionareadetail_pkey PRIMARY KEY (div_dtl_key);

ALTER TABLE ONLY dwh.f_divisionareadetail
    ADD CONSTRAINT f_divisionareadetail_ukey UNIQUE (div_code, div_ou);

CREATE INDEX f_divisionareadetail_key_idx ON dwh.f_divisionareadetail USING btree (div_key);