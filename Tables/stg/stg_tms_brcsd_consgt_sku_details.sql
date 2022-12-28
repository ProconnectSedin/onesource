CREATE TABLE stg.stg_tms_brcsd_consgt_sku_details (
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

CREATE INDEX stg_tms_brcsd_consgt_sku_details_key_idx1 ON stg.stg_tms_brcsd_consgt_sku_details USING btree (brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_sku_line_no);