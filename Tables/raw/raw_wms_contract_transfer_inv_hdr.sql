CREATE TABLE raw.raw_wms_contract_transfer_inv_hdr (
    raw_id bigint NOT NULL,
    wms_cont_transfer_inv_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_transfer_inv_ou integer NOT NULL,
    wms_cont_transfer_inv_date timestamp without time zone,
    wms_cont_inv_no character varying(72) COLLATE public.nocase,
    wms_cont_inv_date timestamp without time zone,
    wms_cont_flag character varying(32) COLLATE public.nocase,
    wms_cont_timestamp integer,
    wms_cont_created_by character varying(120) COLLATE public.nocase,
    wms_cont_created_dt timestamp without time zone,
    wms_cont_modified_by character varying(120) COLLATE public.nocase,
    wms_cont_modified_dt timestamp without time zone,
    wms_cont_tran_type character varying(100) COLLATE public.nocase,
    wms_cont_rcti_flag character varying(100) COLLATE public.nocase,
    wms_cont_billing_profile character varying(100) COLLATE public.nocase,
    wms_cont_transfer_received_by character varying(120) COLLATE public.nocase,
    wms_cont_transfer_date_received timestamp without time zone,
    wms_cont_transfer_inv_value numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_contract_transfer_inv_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_contract_transfer_inv_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_contract_transfer_inv_hdr
    ADD CONSTRAINT raw_wms_contract_transfer_inv_hdr_pkey PRIMARY KEY (raw_id);