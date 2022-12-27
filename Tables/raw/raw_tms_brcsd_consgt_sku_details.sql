CREATE TABLE raw.raw_tms_brcsd_consgt_sku_details (
    raw_id bigint NOT NULL,
    brcsd_ou integer NOT NULL,
    brcsd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    brcsd_thu_line_no character varying(512) NOT NULL COLLATE public.nocase,
    brcsd_serial_no character varying(160) COLLATE public.nocase,
    brcsd_child_thu_id character varying(160) COLLATE public.nocase,
    brcsd_child_serial_no character varying(160) COLLATE public.nocase,
    brcsd_sku_line_no character varying(512) NOT NULL COLLATE public.nocase,
    brcsd_sku_id character varying(160) COLLATE public.nocase,
    brcsd_sku_rate numeric,
    brcsd_sku_quantity numeric,
    brcsd_sku_value numeric,
    brcsd_sku_batch_id character varying(160) COLLATE public.nocase,
    brcsd_sku_mfg_date timestamp without time zone,
    brcsd_sku_expiry_date timestamp without time zone,
    brcsd_created_by character varying(120) COLLATE public.nocase,
    brcsd_created_date timestamp without time zone,
    brcsd_modified_by character varying(120) COLLATE public.nocase,
    brcsd_modified_date timestamp without time zone,
    brcsd_timestamp integer,
    brcsd_igst_amount numeric,
    brcsd_cgst_amount numeric,
    brcsd_sgst_amount numeric,
    brcsd_utgst_amount numeric,
    brcsd_cess_amount numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_tms_brcsd_consgt_sku_details ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_tms_brcsd_consgt_sku_details_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_tms_brcsd_consgt_sku_details
    ADD CONSTRAINT raw_tms_brcsd_consgt_sku_details_pkey PRIMARY KEY (raw_id);