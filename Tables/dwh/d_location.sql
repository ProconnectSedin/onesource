CREATE TABLE dwh.d_location (
    loc_key bigint NOT NULL,
    loc_ou integer,
    loc_code character varying(20) COLLATE public.nocase,
    loc_desc character varying(510) COLLATE public.nocase,
    loc_status character varying(20) COLLATE public.nocase,
    loc_type character varying(80) COLLATE public.nocase,
    reason_code character varying(80) COLLATE public.nocase,
    finance_book character varying(40) COLLATE public.nocase,
    costcenter character varying(20) COLLATE public.nocase,
    address1 character varying(200) COLLATE public.nocase,
    address2 character varying(200) COLLATE public.nocase,
    country character varying(80) COLLATE public.nocase,
    state character varying(80) COLLATE public.nocase,
    city character varying(100) COLLATE public.nocase,
    zip_code character varying(40) COLLATE public.nocase,
    contperson character varying(100) COLLATE public.nocase,
    contact_no character varying(100) COLLATE public.nocase,
    time_zone_id character varying(80) COLLATE public.nocase,
    loc_lat numeric(13,2),
    loc_long numeric(13,2),
    ltimestamp integer,
    created_by character varying(60) COLLATE public.nocase,
    created_dt timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_dt timestamp without time zone,
    def_plan_mode character varying(80) COLLATE public.nocase,
    loc_shp_point character varying(80) COLLATE public.nocase,
    loc_cubing integer,
    blanket_count_sa integer,
    enable_uid_prof integer,
    loc_linked_hub character varying(20) COLLATE public.nocase,
    loc_enable_bin_chkbit integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    div_key bigint,
    div_code character varying(20) COLLATE public.nocase
);

ALTER TABLE dwh.d_location ALTER COLUMN loc_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_location_loc_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_location
    ADD CONSTRAINT d_location_pkey PRIMARY KEY (loc_key);

ALTER TABLE ONLY dwh.d_location
    ADD CONSTRAINT d_location_ukey UNIQUE (loc_code, loc_ou);

CREATE INDEX d_location_key_idx ON dwh.d_location USING btree (loc_code, loc_ou);