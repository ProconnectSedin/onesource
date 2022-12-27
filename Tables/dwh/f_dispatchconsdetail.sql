CREATE TABLE dwh.f_dispatchconsdetail (
    disp_con_dtl_key bigint NOT NULL,
    disp_con_loc_key bigint NOT NULL,
    disp_con_customer_key bigint NOT NULL,
    disp_location character varying(20) COLLATE public.nocase,
    disp_ou integer,
    disp_lineno integer,
    disp_profile_code character varying(40) COLLATE public.nocase,
    disp_customer character varying(40) COLLATE public.nocase,
    disp_lsp character varying(40) COLLATE public.nocase,
    disp_ship_mode character varying(510) COLLATE public.nocase,
    disp_route character varying(510) COLLATE public.nocase,
    disp_ship_point character varying(510) COLLATE public.nocase,
    disp_thuid character varying(510) COLLATE public.nocase,
    disp_delivery_date character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_dispatchconsdetail ALTER COLUMN disp_con_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_dispatchconsdetail_disp_con_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_pkey PRIMARY KEY (disp_con_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_ukey UNIQUE (disp_location, disp_ou, disp_lineno);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_con_customer_key_fkey FOREIGN KEY (disp_con_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_con_loc_key_fkey FOREIGN KEY (disp_con_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_dispatchconsdetail_key_idx ON dwh.f_dispatchconsdetail USING btree (disp_con_loc_key, disp_con_customer_key);