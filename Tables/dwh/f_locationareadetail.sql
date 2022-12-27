CREATE TABLE dwh.f_locationareadetail (
    loc_pop_dtl_key bigint NOT NULL,
    loc_pop_loc_key bigint NOT NULL,
    loc_pop_code character varying(20) COLLATE public.nocase,
    loc_pop_ou integer,
    loc_pop_length numeric(13,2),
    loc_pop_breath numeric(13,2),
    loc_pop_uom character varying(20) COLLATE public.nocase,
    loc_pop_area_uom character varying(20) COLLATE public.nocase,
    loc_pop_tot_area numeric(13,2),
    loc_pop_tot_stag_area numeric(13,2),
    loc_pop_storg_area numeric(13,2),
    loc_pop_no_of_bins integer,
    loc_pop_no_of_zones integer,
    loc_other_area numeric(13,2),
    loc_office_area numeric(13,2),
    loc_outbound_area numeric(13,2),
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    warehouse_loc_radio character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_locationareadetail ALTER COLUMN loc_pop_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_locationareadetail_loc_pop_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_locationareadetail
    ADD CONSTRAINT f_locationareadetail_pkey PRIMARY KEY (loc_pop_dtl_key);

ALTER TABLE ONLY dwh.f_locationareadetail
    ADD CONSTRAINT f_locationareadetail_ukey UNIQUE (loc_pop_code, loc_pop_ou);

CREATE INDEX f_locationareadetail_key_idx ON dwh.f_locationareadetail USING btree (loc_pop_loc_key);