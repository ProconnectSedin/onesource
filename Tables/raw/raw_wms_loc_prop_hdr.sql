CREATE TABLE raw.raw_wms_loc_prop_hdr (
    raw_id bigint NOT NULL,
    wms_loc_pop_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_pop_ou integer NOT NULL,
    wms_loc_pop_length numeric,
    wms_loc_pop_breath numeric,
    wms_loc_pop_uom character varying(40) COLLATE public.nocase,
    wms_loc_pop_area_uom character varying(40) COLLATE public.nocase,
    wms_loc_pop_tot_area numeric,
    wms_loc_pop_tot_stag_area numeric,
    wms_loc_pop_storg_area numeric,
    wms_loc_pop_no_of_bins integer,
    wms_loc_pop_no_of_zones integer,
    wms_loc_other_area numeric,
    wms_loc_office_area numeric,
    wms_loc_outbound_area numeric,
    created_by character varying(120) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    warehouse_loc_radio character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_loc_prop_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_loc_prop_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_loc_prop_hdr
    ADD CONSTRAINT raw_wms_loc_prop_hdr_pkey PRIMARY KEY (raw_id);