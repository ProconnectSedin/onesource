CREATE TABLE stg.stg_wms_lnm_lh_lotnohistory (
    lh_lotno_ou integer NOT NULL,
    lh_item_code character varying(128) NOT NULL COLLATE public.nocase,
    lh_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    lh_trans_no character varying(72) NOT NULL COLLATE public.nocase,
    lh_seq_no integer,
    lh_sup_batch_no character varying(112) COLLATE public.nocase,
    lh_trans_type character varying(100) COLLATE public.nocase,
    lh_trans_date timestamp without time zone,
    lh_serial_no character varying(112) COLLATE public.nocase,
    lh_warehouse character varying(40) COLLATE public.nocase,
    lh_zone character varying(40) COLLATE public.nocase,
    lh_bin character varying(40) COLLATE public.nocase,
    lh_qty numeric,
    lh_stock_status character varying(32) COLLATE public.nocase,
    lh_created_user character varying(120) COLLATE public.nocase,
    lh_created_date timestamp without time zone,
    lh_seqno_unique bigint NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_wms_lnm_lh_lotnohistory ALTER COLUMN lh_seqno_unique ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_wms_lnm_lh_lotnohistory_lh_seqno_unique_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1
);

ALTER TABLE ONLY stg.stg_wms_lnm_lh_lotnohistory
    ADD CONSTRAINT wms_lnm_lh_lotnohistory_pk PRIMARY KEY (lh_seqno_unique);