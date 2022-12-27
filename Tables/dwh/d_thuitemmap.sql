CREATE TABLE dwh.d_thuitemmap (
    thu_itm_key bigint NOT NULL,
    thu_loc_code character varying(20) COLLATE public.nocase,
    thu_ou integer,
    thu_serial_no character varying(56) COLLATE public.nocase,
    thu_id character varying(80) COLLATE public.nocase,
    thu_item character varying(64) COLLATE public.nocase,
    thu_lot_no character varying(56) COLLATE public.nocase,
    thu_itm_serial_no character varying(56) COLLATE public.nocase,
    thu_qty numeric,
    thu_created_by character varying(60) COLLATE public.nocase,
    thu_created_date timestamp without time zone,
    thu_ser_no character varying(56) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_thuitemmap ALTER COLUMN thu_itm_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_thuitemmap_thu_itm_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_pkey PRIMARY KEY (thu_itm_key);

ALTER TABLE ONLY dwh.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_ukey UNIQUE (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);

CREATE INDEX d_thuitemmap_idx ON dwh.d_thuitemmap USING btree (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);