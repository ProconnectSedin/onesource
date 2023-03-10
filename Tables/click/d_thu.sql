CREATE TABLE click.d_thu (
    thu_key bigint NOT NULL,
    thu_id character varying(80) COLLATE public.nocase,
    thu_ou integer,
    thu_description character varying(510) COLLATE public.nocase,
    thu_bulk integer,
    thu_class character varying(80) COLLATE public.nocase,
    thu_status character varying(20) COLLATE public.nocase,
    thu_reason_code character varying(80) COLLATE public.nocase,
    thu_tare numeric(13,2),
    thu_max_allowable numeric(13,2),
    thu_weight_uom character varying(20) COLLATE public.nocase,
    thu_uom character varying(20) COLLATE public.nocase,
    thu_int_length numeric(13,2),
    thu_int_width numeric(13,2),
    thu_int_height numeric(13,2),
    thu_int_uom character varying(20) COLLATE public.nocase,
    thu_ext_length numeric(13,2),
    thu_ext_width numeric(13,2),
    thu_ext_height numeric(13,2),
    thu_ext_uom character varying(20) COLLATE public.nocase,
    thu_timestamp integer,
    thu_created_by character varying(60) COLLATE public.nocase,
    thu_created_date timestamp without time zone,
    thu_modified_by character varying(60) COLLATE public.nocase,
    thu_modified_date timestamp without time zone,
    thu_size character varying(80) COLLATE public.nocase,
    thu_eligible_cubing integer,
    thu_area numeric(13,2),
    thu_weight_const integer,
    thu_volume_const integer,
    thu_unit_pallet_const integer,
    thu_max_unit_permissable integer,
    thu_stage_mapping integer,
    thu_ser_cont integer,
    thu_is_ethu integer,
    thu_volume_uom character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_thu
    ADD CONSTRAINT d_thu_pkey PRIMARY KEY (thu_key);

ALTER TABLE ONLY click.d_thu
    ADD CONSTRAINT d_thu_ukey UNIQUE (thu_id, thu_ou);