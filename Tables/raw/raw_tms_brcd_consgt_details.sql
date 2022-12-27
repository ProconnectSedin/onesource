CREATE TABLE raw.raw_tms_brcd_consgt_details (
    raw_id bigint NOT NULL,
    cd_ouinstance integer NOT NULL,
    cd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    cd_line_no integer NOT NULL,
    cd_thu_id character varying(160) COLLATE public.nocase,
    cd_thu_qty numeric,
    cd_thu_qty_uom character varying(60) COLLATE public.nocase,
    cd_declared_value_of_goods numeric,
    cd_insurance_value numeric,
    cd_currency character(20) COLLATE public.nocase,
    cd_class_of_stores character varying(160) COLLATE public.nocase,
    cd_volume numeric,
    cd_volume_uom character varying(60) COLLATE public.nocase,
    cd_gross_weight numeric,
    cd_weight_uom character varying(60) COLLATE public.nocase,
    cd_creation_date timestamp without time zone,
    cd_created_by character varying(120) COLLATE public.nocase,
    cd_last_modified_date timestamp without time zone,
    cd_last_modified_by character varying(120) COLLATE public.nocase,
    cd_unique_id character varying(512) NOT NULL COLLATE public.nocase,
    cd_br_billing_status character varying(32) COLLATE public.nocase,
    cd_no_of_pallet_space numeric,
    cd_added_for_equ_vehicle character(4) COLLATE public.nocase,
    cd_transfer_type character varying(160) COLLATE public.nocase,
    cd_transfer_to character varying(160) COLLATE public.nocase,
    cd_transfer_account character varying(160) COLLATE public.nocase,
    cd_vendor_thu_id character varying(72) COLLATE public.nocase,
    cd_trans_doc_no character varying(160) COLLATE public.nocase,
    cd_vendor_ac_no character varying(160) COLLATE public.nocase,
    cd_commoditycode character varying(72) COLLATE public.nocase,
    cd_commodityqty numeric,
    cd_commodityuom character varying(160) COLLATE public.nocase,
    cd_com_parent_line_id character varying(512) COLLATE public.nocase,
    cd_net_weight numeric,
    cd_timestamp integer,
    cd_amount_collected numeric,
    cd_shipper_invoice_no character varying(160) COLLATE public.nocase,
    cd_shipper_invoice_value numeric,
    cd_shipper_invoice_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_brcd_consgt_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_brcd_consgt_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_brcd_consgt_details
    ADD CONSTRAINT raw_tms_brcd_consgt_details_pkey PRIMARY KEY (raw_id);