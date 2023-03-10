CREATE TABLE stg.stg_tms_brcds_consgt_additional_services (
    cds_ouinstance integer NOT NULL,
    cds_br_id character varying(72) NOT NULL COLLATE public.nocase,
    cds_vehicle_type character varying(160) COLLATE public.nocase,
    cds_equipment_type character varying(160) COLLATE public.nocase,
    cds_cha_required character(4) COLLATE public.nocase,
    cds_vas_required character(4) COLLATE public.nocase,
    cds_project_cargo character(4) COLLATE public.nocase,
    cds_special_instructions character varying(16000) COLLATE public.nocase,
    cds_temp_controlled character(4) COLLATE public.nocase,
    cds_min_temp numeric,
    cds_max_temp numeric,
    cds_temp_uom character varying(60) COLLATE public.nocase,
    cds_origin_sea_air_port character varying(160) COLLATE public.nocase,
    cds_destination_sea_air_port character varying(160) COLLATE public.nocase,
    cds_pref_agent1 character varying(160) COLLATE public.nocase,
    cds_pref_carrier_airline1 character varying(160) COLLATE public.nocase,
    cds_pref_vessal_ac_type1 character varying(160) COLLATE public.nocase,
    cds_pref_voyage_flight_no1 character varying(160) COLLATE public.nocase,
    cds_pref_agent2 character varying(160) COLLATE public.nocase,
    cds_pref_carrier_airline2 character varying(160) COLLATE public.nocase,
    cds_pref_vessal_ac_type2 character varying(160) COLLATE public.nocase,
    cds_pref_voyage_flight_no2 character varying(160) COLLATE public.nocase,
    cds_cargo_drop_by_shipper character(4) COLLATE public.nocase,
    cds_cargo_pickup_by_shipper character(4) COLLATE public.nocase,
    cds_cargo_pickup_by_consignee character(4) COLLATE public.nocase,
    cds_cargo_drop_by_agent character(4) COLLATE public.nocase,
    cds_cargo_pickup_by_agent character(4) COLLATE public.nocase,
    cds_direct_tran_ship_mode character(4) COLLATE public.nocase,
    cds_created_by character varying(120) COLLATE public.nocase,
    cds_created_date timestamp without time zone,
    cds_last_modified_date timestamp without time zone,
    cds_last_modified_by character varying(120) COLLATE public.nocase,
    cds_material_handling_required character varying(160) COLLATE public.nocase,
    cds_permanent_instructions character varying(1020) COLLATE public.nocase,
    cds_ship_legistry_no character varying(160) COLLATE public.nocase,
    cds_timestamp integer,
    cds_no_of_vehicle integer,
    cds_no_of_equipment integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_tms_brcds_consgt_additional_services
    ADD CONSTRAINT pk_tms_brcds_consgt_additional_services PRIMARY KEY (cds_ouinstance, cds_br_id);