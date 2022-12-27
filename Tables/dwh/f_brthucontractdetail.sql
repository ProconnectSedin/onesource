CREATE TABLE dwh.f_brthucontractdetail (
    brctd_key bigint NOT NULL,
    br_key bigint NOT NULL,
    brctd_ou integer,
    brctd_br_id character varying(40) COLLATE public.nocase,
    brctd_thu_line_no character varying(300) COLLATE public.nocase,
    brctd_contract_id character varying(40) COLLATE public.nocase,
    brctd_cont_type character varying(20) COLLATE public.nocase,
    brctd_cont_service_type character varying(80) COLLATE public.nocase,
    brctd_cont_valid_from timestamp without time zone,
    brctd_cont_valid_to timestamp without time zone,
    brctd_tariff_id character varying(40) COLLATE public.nocase,
    brctd_tf_tp_type_code character varying(20) COLLATE public.nocase,
    brctd_tf_tp_validity_id character varying(40) COLLATE public.nocase,
    brctd_tf_tp_frm_ship_point character varying(40) COLLATE public.nocase,
    brctd_tf_tp_to_ship_point character varying(40) COLLATE public.nocase,
    brctd_tf_tp_frm_geo_type character varying(20) COLLATE public.nocase,
    brctd_tf_tp_frm_geo character varying(80) COLLATE public.nocase,
    brctd_tf_tp_to_geo_type character varying(20) COLLATE public.nocase,
    brctd_tf_tp_to_geo character varying(80) COLLATE public.nocase,
    brctd_tf_tp_dist_check integer,
    brctd_tf_tp_wt integer,
    brctd_tf_tp_wt_min numeric(25,2),
    brctd_tf_tp_wt_max numeric(25,2),
    brctd_tf_tp_wt_uom character varying(20) COLLATE public.nocase,
    brctd_tf_tp_vol integer,
    brctd_tf_tp_trip_time integer,
    brctd_tf_tp_vol_conversion numeric(25,2),
    brctd_tf_tp_service character varying(80) COLLATE public.nocase,
    brctd_tf_tp_sub_service character varying(80) COLLATE public.nocase,
    brctd_tf_tp_thu_type character varying(80) COLLATE public.nocase,
    brctd_tf_tp_min_no_thu numeric(25,2),
    brctd_tf_tp_max_no_thu numeric(25,2),
    brctd_tf_tp_veh_type character varying(80) COLLATE public.nocase,
    brctd_billable_weight numeric(25,2),
    brctd_rate_for_billable_weight numeric(25,2),
    brctd_stage_of_tariff_derivation character varying(80) COLLATE public.nocase,
    brctd_staging_ref_document character varying(40) COLLATE public.nocase,
    brctd_created_by character varying(60) COLLATE public.nocase,
    brctd_created_date timestamp without time zone,
    brctd_cont_amend_no integer,
    brctd_billable_quantity numeric(25,2),
    brctd_dd_br_volume numeric(25,2),
    brctd_no_of_pallet numeric(25,2),
    brctd_actual_weight numeric(25,2),
    brctd_actual_weight_uom character varying(30) COLLATE public.nocase,
    brctd_actual_volume numeric(25,2),
    brctd_actual_volume_uom character varying(30) COLLATE public.nocase,
    brctd_basic_charge numeric(25,2),
    brctd_cont_min_charge numeric(25,2),
    brctd_chargeable_qty numeric(25,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_brthucontractdetail ALTER COLUMN brctd_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_brthucontractdetail_brctd_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_pkey PRIMARY KEY (brctd_key);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_ukey UNIQUE (brctd_ou, brctd_br_id, brctd_tariff_id, brctd_thu_line_no, brctd_staging_ref_document);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

CREATE INDEX f_brthucontractdetail_key_idx ON dwh.f_brthucontractdetail USING btree (br_key);

CREATE INDEX f_brthucontractdetail_key_idx1 ON dwh.f_brthucontractdetail USING btree (brctd_ou, brctd_br_id, brctd_tariff_id, brctd_thu_line_no, brctd_staging_ref_document);