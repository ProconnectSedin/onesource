CREATE TABLE raw.raw_wms_stockbal_lot (
    raw_id bigint NOT NULL,
    sbl_wh_code character varying(40) NOT NULL COLLATE public.nocase,
    sbl_ouinstid integer NOT NULL,
    sbl_item_code character varying(128) NOT NULL COLLATE public.nocase,
    sbl_lot_no character varying(112) NOT NULL COLLATE public.nocase,
    sbl_zone character varying(40) NOT NULL COLLATE public.nocase,
    sbl_bin character varying(40) NOT NULL COLLATE public.nocase,
    sbl_stock_status character varying(32) NOT NULL COLLATE public.nocase,
    sbl_quantity numeric NOT NULL,
    sbl_wh_bat_no character varying(112) COLLATE public.nocase,
    sbl_supp_bat_no character varying(112) COLLATE public.nocase,
    sbl_ido_no character varying(72) COLLATE public.nocase,
    sbl_gr_no character varying(72) COLLATE public.nocase,
    sbl_trantype character varying(100) DEFAULT 'WMS_GR'::character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT wms_stockbal_lot_check CHECK ((sbl_quantity >= (0)::numeric))
);

ALTER TABLE raw.raw_wms_stockbal_lot ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stockbal_lot_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stockbal_lot
    ADD CONSTRAINT raw_wms_stockbal_lot_pkey PRIMARY KEY (raw_id);