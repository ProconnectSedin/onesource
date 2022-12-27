CREATE TABLE stg.stg_wms_stockbal_su_serial (
    sbs_wh_code character varying(40) NOT NULL COLLATE public.nocase,
    sbs_ouinstid integer NOT NULL,
    sbs_item_code character varying(128) NOT NULL COLLATE public.nocase,
    sbs_sr_no character varying(112) NOT NULL COLLATE public.nocase,
    sbs_zone character varying(40) NOT NULL COLLATE public.nocase,
    sbs_bin character varying(40) NOT NULL COLLATE public.nocase,
    sbs_stock_status character varying(160) NOT NULL COLLATE public.nocase,
    sbs_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    sbs_su character varying(40) NOT NULL COLLATE public.nocase,
    sbs_su_type character varying(32) NOT NULL COLLATE public.nocase,
    sbs_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    sbs_su_serial_no character varying(160) NOT NULL COLLATE public.nocase,
    sbs_quantity numeric NOT NULL,
    sbs_wh_bat_no character varying(112) COLLATE public.nocase,
    sbs_supp_bat_no character varying(112) COLLATE public.nocase,
    sbs_ido_no character varying(72) COLLATE public.nocase,
    sbs_gr_no character varying(72) COLLATE public.nocase,
    sbs_trantype character varying(100) DEFAULT 'WMS_GR'::character varying COLLATE public.nocase,
    sbs_thu_serial_no character varying(112) DEFAULT '##'::character varying NOT NULL COLLATE public.nocase,
    sbs_warranty_serial_no character varying(112) COLLATE public.nocase,
    sbs_customer_serial_no character varying(112) COLLATE public.nocase,
    sbs_3pl_serial_no character varying(112) COLLATE public.nocase,
    sbs_su2 character varying(40) COLLATE public.nocase,
    sbs_su_serial_no2 character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_stockbal_su_serial_chk CHECK ((sbs_quantity >= (0)::numeric))
);

ALTER TABLE ONLY stg.stg_wms_stockbal_su_serial
    ADD CONSTRAINT wms_stockbal_su_serial_pk PRIMARY KEY (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_su_serial_no, sbs_thu_serial_no);

CREATE INDEX stg_wms_stockbal_su_serial_key_idx2 ON stg.stg_wms_stockbal_su_serial USING btree (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_su_serial_no, sbs_thu_serial_no);