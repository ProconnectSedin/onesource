CREATE TABLE raw.raw_wms_vendor_hdr (
    raw_id bigint NOT NULL,
    wms_vendor_id character varying(64) NOT NULL COLLATE public.nocase,
    wms_vendor_ou integer NOT NULL,
    wms_vendor_status character varying(32) COLLATE public.nocase,
    wms_vendor_name character varying(240) COLLATE public.nocase,
    wms_vendor_payterm character varying(60) COLLATE public.nocase,
    wms_vendor_reason_code character varying(160) COLLATE public.nocase,
    wms_vendor_classifcation character varying(1020) COLLATE public.nocase,
    wms_vendor_currency character(20) COLLATE public.nocase,
    wms_vendor_pay_addressid character varying(48) COLLATE public.nocase,
    wms_vendor_order_addressid character varying(48) COLLATE public.nocase,
    wms_vendor_ship_addressid character varying(48) COLLATE public.nocase,
    wms_vendor_for_self integer,
    wms_vendor_created_by character varying(120) COLLATE public.nocase,
    wms_vendor_created_date timestamp without time zone,
    wms_vendor_modified_by character varying(120) COLLATE public.nocase,
    wms_vendor_modified_date timestamp without time zone,
    wms_vendor_timestamp integer,
    wms_vendor_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_vendor_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_vendor_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_vendor_address1 character varying(600) COLLATE public.nocase,
    wms_vendor_address2 character varying(600) COLLATE public.nocase,
    wms_vendor_address3 character varying(600) COLLATE public.nocase,
    wms_vendor_city character varying(160) COLLATE public.nocase,
    wms_vendor_state character varying(160) COLLATE public.nocase,
    wms_vendor_country character varying(160) COLLATE public.nocase,
    wms_vendor_phone1 character varying(80) COLLATE public.nocase,
    wms_vendor_phone2 character varying(80) COLLATE public.nocase,
    wms_vendor_email character varying(1020) COLLATE public.nocase,
    wms_vendor_fax character varying(160) COLLATE public.nocase,
    wms_vendor_url character varying(200) COLLATE public.nocase,
    wms_vendor_subzone character varying(160) COLLATE public.nocase,
    wms_vendor_timezone character varying(160) COLLATE public.nocase,
    wms_vendor_zone character varying(160) COLLATE public.nocase,
    wms_vendor_region character varying(160) COLLATE public.nocase,
    wms_vendor_postal_code character varying(160) COLLATE public.nocase,
    wms_vendor_agnt_reg character varying(24) COLLATE public.nocase,
    wms_vendor_agnt_cha character varying(24) COLLATE public.nocase,
    wms_vendor_carrier_road character varying(24) COLLATE public.nocase,
    wms_vendor_carrier_rail character varying(24) COLLATE public.nocase,
    wms_vendor_carrier_air character varying(24) COLLATE public.nocase,
    wms_vendor_carrier_sea character varying(24) COLLATE public.nocase,
    wms_vendor_sub_cntrct_veh character varying(24) COLLATE public.nocase,
    wms_vendor_sub_cntrct_emp character varying(24) COLLATE public.nocase,
    wms_vendor_lat numeric,
    wms_vendor_long numeric,
    wms_vendor_reg character varying(160) COLLATE public.nocase,
    wms_vendor_dept character varying(160) COLLATE public.nocase,
    wms_vendor_ln_business character varying(160) COLLATE public.nocase,
    wms_vendor_bill_profile character varying(160) COLLATE public.nocase,
    wms_vendor_rcti character varying(1020) COLLATE public.nocase,
    wms_vendor_vfg character varying(1020) COLLATE public.nocase,
    wms_vendor_gen_from character varying(100) COLLATE public.nocase,
    wms_vendor_group character varying(160) COLLATE public.nocase,
    wms_vendor_std_contract integer,
    wms_vendor_final_bill_stage character varying(160) COLLATE public.nocase,
    wms_vendor_iata_code character varying(80) COLLATE public.nocase,
    wms_vendor_allwdb_billto integer,
    wms_vendor_suburb character varying(1020) COLLATE public.nocase,
    wms_vendor_insrnc_prvdr character varying(24) COLLATE public.nocase,
    wms_vendor_tempid character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_vendor_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_vendor_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_vendor_hdr
    ADD CONSTRAINT raw_wms_vendor_hdr_pkey PRIMARY KEY (raw_id);