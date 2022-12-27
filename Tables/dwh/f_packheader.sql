CREATE TABLE dwh.f_packheader (
    pack_hdr_key bigint NOT NULL,
    pack_location character varying(510) COLLATE public.nocase,
    pack_ou integer,
    pack_pack_rule character varying(510) COLLATE public.nocase,
    pack_single_step character varying(510) COLLATE public.nocase,
    pack_by_customer character varying(30) COLLATE public.nocase,
    pack_by_item character varying(30) COLLATE public.nocase,
    pack_by_pick_numb character varying(30) COLLATE public.nocase,
    pack_storage_pickbay character varying(30) COLLATE public.nocase,
    pack_load_balancing character varying(30) COLLATE public.nocase,
    pack_item_type character varying(30) COLLATE public.nocase,
    pack_timestamp integer,
    pack_created_by character varying(60) COLLATE public.nocase,
    pack_created_date timestamp without time zone,
    pack_modified_by character varying(60) COLLATE public.nocase,
    pack_modified_date timestamp without time zone,
    pack_step character varying(40) COLLATE public.nocase,
    pack_short_pick integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_packheader ALTER COLUMN pack_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_packheader_pack_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_packheader
    ADD CONSTRAINT f_packheader_pkey PRIMARY KEY (pack_hdr_key);

ALTER TABLE ONLY dwh.f_packheader
    ADD CONSTRAINT f_packheader_ukey UNIQUE (pack_location, pack_ou);

CREATE INDEX f_packheader_key_idx1 ON dwh.f_packheader USING btree (pack_location, pack_ou);