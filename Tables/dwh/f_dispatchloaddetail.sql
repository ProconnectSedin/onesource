CREATE TABLE dwh.f_dispatchloaddetail (
    disp_load_dtl_key bigint NOT NULL,
    disp_load_loc_key bigint NOT NULL,
    disp_load_customer_key bigint NOT NULL,
    disp_location character varying(20) COLLATE public.nocase,
    disp_ou integer,
    disp_lineno integer,
    disp_customer character varying(40) COLLATE public.nocase,
    disp_profile character varying(40) COLLATE public.nocase,
    disp_ship_mode character varying(510) COLLATE public.nocase,
    disp_urgent character varying(510) COLLATE public.nocase,
    disp_lsp character varying(40) COLLATE public.nocase,
    disp_integ_tms character varying(510) COLLATE public.nocase,
    disp_status character varying(510) COLLATE public.nocase,
    disp_tms_location character varying(20) COLLATE public.nocase,
    disp_dispatch_bay character varying(40) COLLATE public.nocase,
    disp_bkreq_status character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchloaddetail ALTER COLUMN disp_load_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchloaddetail_disp_load_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchloaddetail_pkey PRIMARY KEY (disp_load_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchloaddetail_ukey UNIQUE (disp_location, disp_ou, disp_lineno);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_load_customer_key_fkey FOREIGN KEY (disp_load_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_load_loc_key_fkey FOREIGN KEY (disp_load_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_dispatchloaddetail_key_idx ON dwh.f_dispatchloaddetail USING btree (disp_load_loc_key, disp_load_customer_key);