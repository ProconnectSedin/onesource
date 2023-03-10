CREATE TABLE click.f_wh_space_detail (
    wh_space_dtl_key bigint NOT NULL,
    loc_key bigint,
    div_key bigint,
    ou integer NOT NULL,
    division character varying(20) COLLATE public.nocase,
    division_name character varying(510) COLLATE public.nocase,
    location_name character varying(510) COLLATE public.nocase,
    location_code character varying(20) COLLATE public.nocase,
    customer_name character varying(100) COLLATE public.nocase,
    customer_code character varying(40) COLLATE public.nocase,
    super_buildup numeric(25,2),
    carpet_area numeric(25,2),
    ib_staging_area numeric(25,2),
    ob_staging_area numeric(25,2),
    office_area numeric(25,2),
    others numeric(25,2),
    storage_area numeric(25,2),
    area_uom character varying(20) COLLATE public.nocase,
    customer_ib_area numeric(25,2),
    customer_ob_area numeric(13,2),
    customer_office_area numeric(13,2),
    customer_storage_area numeric(13,2),
    customer_other_area numeric(13,2),
    customer_total_area numeric(13,2),
    customer_area_uom character varying(20) COLLATE public.nocase,
    not_allocated numeric(13,2),
    status character varying(20) COLLATE public.nocase,
    createddate timestamp(3) without time zone
);

ALTER TABLE click.f_wh_space_detail ALTER COLUMN wh_space_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_wh_space_detail_wh_space_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_wh_space_detail
    ADD CONSTRAINT f_wh_space_detail_pkey PRIMARY KEY (wh_space_dtl_key);

ALTER TABLE ONLY click.f_wh_space_detail
    ADD CONSTRAINT f_wh_space_detail_ukey UNIQUE (ou, division, location_code, customer_code);