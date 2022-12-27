CREATE TABLE stg.stg_pcsit_multicarrier_tbl (
    rowid integer NOT NULL,
    br_number character varying(800) COLLATE public.nocase,
    invoice_number character varying(600) COLLATE public.nocase,
    br_value character varying(400) COLLATE public.nocase,
    service_type character varying(400) COLLATE public.nocase,
    mode_of_transport character varying(400) COLLATE public.nocase,
    customer_code character varying(400) COLLATE public.nocase,
    location_code character varying(400) COLLATE public.nocase,
    source_location character varying(400) COLLATE public.nocase,
    source_address character varying(4000) COLLATE public.nocase,
    source_city character varying(400) COLLATE public.nocase,
    source_pin character varying(40) COLLATE public.nocase,
    customer_name character varying(1000) COLLATE public.nocase,
    consignee_address character varying(10000) COLLATE public.nocase,
    consignee_city character varying(1000) COLLATE public.nocase,
    consignee_pin character varying(1000) COLLATE public.nocase,
    tripplan_number character varying(800) COLLATE public.nocase,
    tender_number character varying(800) COLLATE public.nocase,
    sp_code character varying(80) COLLATE public.nocase,
    sp_name character varying(800) COLLATE public.nocase,
    docket_no character varying(800) COLLATE public.nocase,
    docket_date timestamp without time zone,
    thu_type character varying(800) COLLATE public.nocase,
    thu_name character varying(800) COLLATE public.nocase,
    consignment_category character varying(800) COLLATE public.nocase,
    thu_count character varying(800) COLLATE public.nocase,
    thu_length numeric(18,4),
    thu_breadth numeric(18,4),
    thu_height numeric(18,4),
    thu_vol_weight numeric(18,4),
    actual_weight numeric(18,4),
    type_of_vehicle character varying(400) COLLATE public.nocase,
    vehicle_no character varying(400) COLLATE public.nocase,
    despatch_date_time timestamp without time zone,
    diver_name character varying(600) COLLATE public.nocase,
    driver_contact character varying(600) COLLATE public.nocase,
    expected_delivery character varying(800) COLLATE public.nocase,
    expected_tat character varying(600) COLLATE public.nocase,
    remarks character varying(600) COLLATE public.nocase,
    identifier character varying(600) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_multicarrier_tbl ALTER COLUMN rowid ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_multicarrier_tbl_rowid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);