CREATE TABLE click.d_thuitemmap (
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

ALTER TABLE ONLY click.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_pkey PRIMARY KEY (thu_itm_key);

ALTER TABLE ONLY click.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_ukey UNIQUE (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);

CREATE INDEX d_thuitemmap_idx ON click.d_thuitemmap USING btree (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);

CREATE INDEX d_thuitemmap_idx1 ON click.d_thuitemmap USING btree (COALESCE(etlupdatedatetime, etlcreatedatetime));