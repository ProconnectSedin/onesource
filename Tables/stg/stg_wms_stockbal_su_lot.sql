CREATE TABLE stg.stg_wms_stockbal_su_lot (
    sbl_wh_code character varying(40) NOT NULL COLLATE public.nocase,
    sbl_ouinstid integer NOT NULL,
    sbl_item_code character varying(128) NOT NULL COLLATE public.nocase,
    sbl_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    sbl_zone character varying(40) NOT NULL COLLATE public.nocase,
    sbl_bin character varying(40) NOT NULL COLLATE public.nocase,
    sbl_su character varying(40) NOT NULL COLLATE public.nocase,
    sbl_su_type character varying(32) NOT NULL COLLATE public.nocase,
    sbl_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    sbl_stock_status character varying(32) NOT NULL COLLATE public.nocase,
    sbl_quantity numeric NOT NULL,
    sbl_su_serial_no character varying(160) NOT NULL COLLATE public.nocase,
    sbl_wh_bat_no character varying(112) COLLATE public.nocase,
    sbl_supp_bat_no character varying(112) COLLATE public.nocase,
    sbl_ido_no character varying(72) COLLATE public.nocase,
    sbl_gr_no character varying(72) COLLATE public.nocase,
    sbl_trantype character varying(100) DEFAULT 'WMS_GR'::character varying COLLATE public.nocase,
    sbl_thu_serial_no character varying(112) DEFAULT '##'::character varying NOT NULL COLLATE public.nocase,
    sbl_su2 character varying(40) COLLATE public.nocase,
    sbl_su_serial_no2 character varying(112) DEFAULT '##'::character varying NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_stockbal_su_lot_check CHECK ((sbl_quantity >= (0)::numeric))
);

ALTER TABLE ONLY stg.stg_wms_stockbal_su_lot
    ADD CONSTRAINT wms_stockbal_su_lot_pk PRIMARY KEY (sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_stock_status, sbl_su_serial_no, sbl_thu_serial_no, sbl_su_serial_no2);