CREATE TABLE dwh.d_zone (
    zone_key bigint NOT NULL,
    zone_code character varying(20) COLLATE public.nocase,
    zone_ou integer,
    zone_loc_code character varying(20) COLLATE public.nocase,
    zone_description character varying(300) COLLATE public.nocase,
    zone_status character varying(16) COLLATE public.nocase,
    zone_reason character varying(80) COLLATE public.nocase,
    zone_type character varying(80) COLLATE public.nocase,
    zone_pick_strategy character varying(80) COLLATE public.nocase,
    zone_pick_req_confirm integer,
    zone_block_picking integer,
    zone_pick_label integer,
    zone_pick_per_picklist numeric(13,0),
    zone_pick_by character varying(80) COLLATE public.nocase,
    zone_pick_sequence character varying(80) COLLATE public.nocase,
    zone_put_strategy character varying(80) COLLATE public.nocase,
    zone_put_req_confirm integer,
    zone_add_existing_stk integer,
    zone_block_putaway integer,
    zone_capacity_check integer,
    zone_mixed_storage integer,
    zone_mixed_stor_strategy character varying(80) COLLATE public.nocase,
    zone_timestamp integer,
    zone_created_by character varying(60) COLLATE public.nocase,
    zone_created_date timestamp without time zone,
    zone_modified_by character varying(60) COLLATE public.nocase,
    zone_modified_date timestamp without time zone,
    zone_step character varying(40) COLLATE public.nocase,
    zone_pick character varying(16) COLLATE public.nocase,
    zone_matchpallet_qty integer,
    zone_batch_allowed integer,
    zone_uid_allowed integer,
    zone_pick_stage character varying(16) COLLATE public.nocase,
    zone_putaway_stage character varying(16) COLLATE public.nocase,
    zone_cap_chk character varying(510) COLLATE public.nocase,
    zone_packing character(1),
    zone_adv_pick_strategy character varying(16) COLLATE public.nocase,
    zone_adv_pwy_strategy character varying(510) COLLATE public.nocase,
    pcs_noofmnth integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_zone ALTER COLUMN zone_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_zone_zone_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_zone
    ADD CONSTRAINT d_zone_pkey PRIMARY KEY (zone_key);

ALTER TABLE ONLY dwh.d_zone
    ADD CONSTRAINT d_zone_ukey UNIQUE (zone_code, zone_ou, zone_loc_code);