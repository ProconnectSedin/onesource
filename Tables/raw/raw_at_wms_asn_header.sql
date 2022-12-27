CREATE TABLE raw.raw_at_wms_asn_header (
    raw_id bigint NOT NULL,
    wms_asn_ou integer NOT NULL,
    wms_asn_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_asn_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_asn_prefdoc_type character varying(1020) COLLATE public.nocase,
    wms_asn_prefdoc_no character varying(72) COLLATE public.nocase,
    wms_asn_prefdoc_date timestamp without time zone,
    wms_asn_date timestamp without time zone,
    wms_asn_status character varying(1020) COLLATE public.nocase,
    wms_asn_ib_order character varying(72) COLLATE public.nocase,
    wms_asn_ship_frm character varying(40) COLLATE public.nocase,
    wms_asn_ship_date timestamp without time zone,
    wms_asn_dlv_loc character varying(40) COLLATE public.nocase,
    wms_asn_dlv_date timestamp without time zone,
    wms_asn_sup_asn_no character varying(72) COLLATE public.nocase,
    wms_asn_sup_asn_date timestamp without time zone,
    wms_asn_sent_by character varying(160) COLLATE public.nocase,
    wms_asn_rem character varying(1020) COLLATE public.nocase,
    wms_asn_shp_ref_typ character varying(160) COLLATE public.nocase,
    wms_asn_shp_ref_no character varying(72) COLLATE public.nocase,
    wms_asn_shp_ref_date timestamp without time zone,
    wms_asn_shp_carrier character varying(160) COLLATE public.nocase,
    wms_asn_shp_mode character varying(160) COLLATE public.nocase,
    wms_asn_shp_vh_typ character varying(160) COLLATE public.nocase,
    wms_asn_shp_vh_no character varying(120) COLLATE public.nocase,
    wms_asn_shp_eqp_typ character varying(160) COLLATE public.nocase,
    wms_asn_shp_eqp_no character varying(120) COLLATE public.nocase,
    wms_asn_shp_grs_wt numeric,
    wms_asn_shp_nt_wt numeric,
    wms_asn_shp_wt_uom character varying(40) COLLATE public.nocase,
    wms_asn_shp_vol numeric,
    wms_asn_shp_vol_uom character varying(40) COLLATE public.nocase,
    wms_asn_shp_pallt integer,
    wms_asn_shp_rem character varying(1020) COLLATE public.nocase,
    wms_asn_cnt_typ character varying(1020) COLLATE public.nocase,
    wms_asn_cnt_no character varying(280) COLLATE public.nocase,
    wms_asn_cnt_qtyp character varying(1020) COLLATE public.nocase,
    wms_asn_cnt_qsts character varying(1020) COLLATE public.nocase,
    wms_asn_timestamp integer,
    wms_asn_usrdf1 character varying(1020) COLLATE public.nocase,
    wms_asn_usrdf2 character varying(1020) COLLATE public.nocase,
    wms_asn_usrdf3 character varying(1020) COLLATE public.nocase,
    wms_asn_createdby character varying(120) COLLATE public.nocase,
    wms_asn_created_date timestamp without time zone,
    wms_asn_modifiedby character varying(120) COLLATE public.nocase,
    wms_asn_modified_date timestamp without time zone,
    at_change_type character varying(32) COLLATE public.nocase,
    at_datetime timestamp without time zone,
    at_user character varying(120) COLLATE public.nocase,
    wms_dock_no character varying(1020) COLLATE public.nocase,
    wms_total_value numeric,
    wms_asn_gate_no character varying(160) COLLATE public.nocase,
    wms_asn_type character varying(32) COLLATE public.nocase,
    wms_asn_reason_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_at_wms_asn_header ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_at_wms_asn_header_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_at_wms_asn_header
    ADD CONSTRAINT raw_at_wms_asn_header_pkey PRIMARY KEY (raw_id);