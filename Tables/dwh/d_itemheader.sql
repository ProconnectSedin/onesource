CREATE TABLE dwh.d_itemheader (
    itm_hdr_key bigint NOT NULL,
    itm_ou integer,
    itm_code character varying(80) COLLATE public.nocase,
    itm_short_desc character varying(1000) COLLATE public.nocase,
    itm_long_desc character varying(1500) COLLATE public.nocase,
    itm_mas_unit character varying(20) COLLATE public.nocase,
    itm_customer character varying(40) COLLATE public.nocase,
    itm_class character varying(80) COLLATE public.nocase,
    itm_status character varying(10) COLLATE public.nocase,
    itm_ref_no character varying(80) COLLATE public.nocase,
    itm_subs_item1 character varying(80) COLLATE public.nocase,
    itm_hs_code character varying(40) COLLATE public.nocase,
    itm_price numeric,
    itm_currency character varying(20) COLLATE public.nocase,
    itm_tracking character varying(40) COLLATE public.nocase,
    itm_lot_numbering character varying(20) COLLATE public.nocase,
    itm_serial_numbering character varying(20) COLLATE public.nocase,
    itm_remarks character varying(2000) COLLATE public.nocase,
    itm_instructions character varying(2000) COLLATE public.nocase,
    itm_hazardous integer,
    itm_length numeric,
    itm_breadth numeric,
    itm_height numeric,
    itm_uom character varying(20) COLLATE public.nocase,
    itm_volume numeric,
    itm_volume_uom character varying(20) COLLATE public.nocase,
    itm_weight numeric,
    itm_weight_uom character varying(20) COLLATE public.nocase,
    itm_storage_from_temp integer,
    itm_storage_to_temp integer,
    itm_storage_temp_uom character varying(20) COLLATE public.nocase,
    itm_shelf_life integer,
    itm_shelf_life_uom character varying(20) COLLATE public.nocase,
    itm_timestamp integer,
    itm_created_by character varying(60) COLLATE public.nocase,
    itm_created_dt timestamp(3) without time zone,
    itm_modified_by character varying(60) COLLATE public.nocase,
    itm_modified_dt timestamp(3) without time zone,
    itm_reason_code character varying(80) COLLATE public.nocase,
    itm_type character varying(80) COLLATE public.nocase,
    itm_user_defined1 character varying(510) COLLATE public.nocase,
    itm_user_defined2 character varying(510) COLLATE public.nocase,
    itm_itemgroup character varying(80) COLLATE public.nocase,
    itm_criticaldays integer,
    itm_criticaldays_uom character varying(20) COLLATE public.nocase,
    itm_movement_type character varying(80) COLLATE public.nocase,
    itm_volume_factor numeric,
    itm_volume_weight numeric,
    itm_item_url character varying(510) COLLATE public.nocase,
    itm_compilance character varying(80) COLLATE public.nocase,
    itm_new_item integer,
    itm_customer_serial_no character varying(510) COLLATE public.nocase,
    itm_warranty_serial_no character varying(510) COLLATE public.nocase,
    itm_gift_card_serial_no character varying(510) COLLATE public.nocase,
    itm_oe_serial_no character varying(510) COLLATE public.nocase,
    itm_oub_customer_serial_no character varying(510) COLLATE public.nocase,
    itm_oub_warranty_serial_no character varying(510) COLLATE public.nocase,
    itm_oub_gift_card_serial_no character varying(510) COLLATE public.nocase,
    itm_oub_oe_serial_no character varying(510) COLLATE public.nocase,
    itm_inbound character varying(510) COLLATE public.nocase,
    itm_outbound character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    itm_volume_calc numeric
);

ALTER TABLE dwh.d_itemheader ALTER COLUMN itm_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_itemheader_itm_hdr_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_itemheader
    ADD CONSTRAINT d_itemheader_pkey PRIMARY KEY (itm_hdr_key);

ALTER TABLE ONLY dwh.d_itemheader
    ADD CONSTRAINT d_itemheader_ukey UNIQUE (itm_code, itm_ou);

CREATE INDEX d_itemheader_idx ON dwh.d_itemheader USING btree (itm_ou, itm_code);

CREATE INDEX d_itemheader_idx1 ON dwh.d_itemheader USING btree (itm_ou, itm_customer);