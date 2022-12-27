CREATE TABLE dwh.d_vehicle (
    veh_key bigint NOT NULL,
    veh_ou integer,
    veh_id character varying(60) COLLATE public.nocase,
    veh_desc character varying(510) COLLATE public.nocase,
    veh_status character varying(20) COLLATE public.nocase,
    veh_rsn_code character varying(80) COLLATE public.nocase,
    veh_vin character varying(40) COLLATE public.nocase,
    veh_type character varying(80) COLLATE public.nocase,
    veh_own_typ character varying(80) COLLATE public.nocase,
    veh_agency_id character varying(40) COLLATE public.nocase,
    veh_agency_contno character varying(40) COLLATE public.nocase,
    veh_build_date timestamp without time zone,
    veh_def_loc character varying(40) COLLATE public.nocase,
    veh_cur_loc character varying(40) COLLATE public.nocase,
    veh_cur_loc_since timestamp without time zone,
    veh_trans_typ character varying(510) COLLATE public.nocase,
    veh_fuel_used character varying(80) COLLATE public.nocase,
    veh_steering_type character varying(80) COLLATE public.nocase,
    veh_colour character varying(40) COLLATE public.nocase,
    veh_wt_uom character varying(20) COLLATE public.nocase,
    veh_tare numeric(13,2),
    veh_vehicle_gross numeric(13,2),
    veh_gross_com numeric(13,2),
    veh_dim_uom character varying(20) COLLATE public.nocase,
    veh_length numeric(13,2),
    veh_width numeric(13,2),
    veh_height numeric(13,2),
    veh_created_by character varying(60) COLLATE public.nocase,
    veh_created_date timestamp without time zone,
    veh_modified_by character varying(60) COLLATE public.nocase,
    veh_modified_date timestamp without time zone,
    veh_timestamp integer,
    veh_refrigerated integer,
    veh_intransit integer,
    veh_route character varying(40) COLLATE public.nocase,
    veh_and character varying(510) COLLATE public.nocase,
    veh_between character varying(510) COLLATE public.nocase,
    veh_category character varying(80) COLLATE public.nocase,
    veh_use_of_haz integer,
    veh_in_dim_uom character varying(20) COLLATE public.nocase,
    veh_in_length numeric(13,2),
    veh_in_width numeric(13,2),
    veh_in_height numeric(13,2),
    veh_vol_uom character varying(20) COLLATE public.nocase,
    veh_over_vol numeric(13,2),
    veh_internal_vol numeric(13,2),
    veh_purchase_date timestamp without time zone,
    veh_induct_date timestamp without time zone,
    veh_rigid integer,
    veh_home_geo_type character varying(510) COLLATE public.nocase,
    veh_current_geo_type character varying(510) COLLATE public.nocase,
    veh_ownrshp_eftfrm timestamp without time zone,
    veh_raise_int_drfbill integer,
    veh_prev_geo_type character varying(80) COLLATE public.nocase,
    veh_prev_loc character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_vehicle ALTER COLUMN veh_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_vehicle_veh_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_vehicle
    ADD CONSTRAINT d_vehicle_pkey PRIMARY KEY (veh_key);

ALTER TABLE ONLY dwh.d_vehicle
    ADD CONSTRAINT d_vehicle_ukey UNIQUE (veh_ou, veh_id);

CREATE INDEX d_vehicle_idx ON dwh.d_vehicle USING btree (veh_ou, veh_id);

CREATE INDEX d_vehicle_key_ndx ON dwh.d_vehicle USING btree (veh_ou, veh_id);