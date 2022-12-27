CREATE TABLE stg.stg_wms_pack_hdr (
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

ALTER TABLE ONLY stg.stg_wms_pack_hdr
    ADD CONSTRAINT wms_pack_hdr_pk PRIMARY KEY (wms_pack_location, wms_pack_ou);

CREATE INDEX stg_wms_pack_hdr_key_idx2 ON stg.stg_wms_pack_hdr USING btree (wms_pack_location, wms_pack_ou);