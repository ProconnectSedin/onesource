CREATE TABLE raw.raw_wms_pack_hdr (
    raw_id bigint NOT NULL,
    wms_pack_location character varying(1020) NOT NULL COLLATE public.nocase,
    wms_pack_ou integer NOT NULL,
    wms_pack_pack_rule character varying(1020) COLLATE public.nocase,
    wms_pack_single_step character varying(1020) COLLATE public.nocase,
    wms_pack_two_step character varying(1020) COLLATE public.nocase,
    wms_pack_by_customer character varying(48) COLLATE public.nocase,
    wms_pack_by_item character varying(48) COLLATE public.nocase,
    wms_pack_by_pick_numb character varying(48) COLLATE public.nocase,
    wms_pack_storage_pickbay character varying(48) COLLATE public.nocase,
    wms_pack_load_balancing character varying(48) COLLATE public.nocase,
    wms_pack_item_type character varying(48) COLLATE public.nocase,
    wms_pack_timestamp integer,
    wms_pack_created_by character varying(120) COLLATE public.nocase,
    wms_pack_created_date timestamp without time zone,
    wms_pack_modified_by character varying(120) COLLATE public.nocase,
    wms_pack_modified_date timestamp without time zone,
    wms_pack_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pack_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pack_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pack_step character varying(80) COLLATE public.nocase,
    wms_pack_short_pick integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_pack_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_pack_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_pack_hdr
    ADD CONSTRAINT raw_wms_pack_hdr_pkey PRIMARY KEY (raw_id);