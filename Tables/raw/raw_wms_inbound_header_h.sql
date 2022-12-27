CREATE TABLE raw.raw_wms_inbound_header_h (
    raw_id bigint NOT NULL,
    wms_inb_loc_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_inb_orderno character varying(1020) NOT NULL COLLATE public.nocase,
    wms_inb_ou integer NOT NULL,
    wms_inb_amendno integer NOT NULL,
    wms_inb_refdoctype character varying(1020) COLLATE public.nocase,
    wms_inb_refdocno character varying(72) COLLATE public.nocase,
    wms_inb_refdocdate timestamp without time zone,
    wms_inb_orderdate timestamp without time zone,
    wms_inb_status character varying(32) COLLATE public.nocase,
    wms_inb_custcode character varying(72) COLLATE public.nocase,
    wms_inb_vendorcode character varying(64) COLLATE public.nocase,
    wms_inb_addressid character varying(24) COLLATE public.nocase,
    wms_inb_address1 character varying(400) COLLATE public.nocase,
    wms_inb_address2 character varying(400) COLLATE public.nocase,
    wms_inb_address3 character varying(400) COLLATE public.nocase,
    wms_inb_unqaddress character varying(160) COLLATE public.nocase,
    wms_inb_postcode character varying(160) COLLATE public.nocase,
    wms_inb_country character varying(160) COLLATE public.nocase,
    wms_inb_state character varying(160) COLLATE public.nocase,
    wms_inb_city character varying(160) COLLATE public.nocase,
    wms_inb_phoneno character varying(80) COLLATE public.nocase,
    wms_inb_secrefdoctype1 character varying(1020) COLLATE public.nocase,
    wms_inb_secrefdoctype2 character varying(1020) COLLATE public.nocase,
    wms_inb_secrefdoctype3 character varying(1020) COLLATE public.nocase,
    wms_inb_secrefdocno1 character varying(72) COLLATE public.nocase,
    wms_inb_secrefdocno2 character varying(72) COLLATE public.nocase,
    wms_inb_secrefdocno3 character varying(72) COLLATE public.nocase,
    wms_inb_secrefdocdate1 timestamp without time zone,
    wms_inb_secrefdocdate2 timestamp without time zone,
    wms_inb_secrefdocdate3 timestamp without time zone,
    wms_inb_shipmode character varying(160) COLLATE public.nocase,
    wms_inb_shiptype character varying(1020) COLLATE public.nocase,
    wms_inb_instructions character varying(1020) COLLATE public.nocase,
    wms_inb_created_by character varying(120) COLLATE public.nocase,
    wms_inb_created_date timestamp without time zone,
    wms_inb_modified_by character varying(120) COLLATE public.nocase,
    wms_inb_modified_date timestamp without time zone,
    wms_inb_timestamp integer,
    wms_inb_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_inb_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_inb_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_inb_operation_status character varying(32) COLLATE public.nocase,
    wms_inb_ord_type character varying(160) COLLATE public.nocase,
    wms_inb_contract_id character varying(72) COLLATE public.nocase,
    wms_inb_contract_amend_no integer,
    wms_inb_custcode_h character varying(72) COLLATE public.nocase,
    wms_inb_type character varying(32) COLLATE public.nocase,
    wms_inb_addr_loc_code character varying(40) COLLATE public.nocase,
    wms_inb_consignor_code character varying(72) COLLATE public.nocase,
    wms_inb_reason_code character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_inbound_header_h ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_inbound_header_h_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_inbound_header_h
    ADD CONSTRAINT raw_wms_inbound_header_h_pkey PRIMARY KEY (raw_id);