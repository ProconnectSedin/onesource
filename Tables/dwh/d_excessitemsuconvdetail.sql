CREATE TABLE dwh.d_excessitemsuconvdetail (
    d_ex_itm_key bigint NOT NULL,
    ex_excessitem_key bigint,
    ex_location_key bigint,
    ex_itm_ou integer,
    ex_itm_code character varying(80) COLLATE public.nocase,
    ex_itm_loc_code character varying(20) COLLATE public.nocase,
    ex_itm_line_no integer,
    ex_itm_storage_unit character varying(20) COLLATE public.nocase,
    ex_itm_operator character varying(20) COLLATE public.nocase,
    ex_itm_quantity numeric(13,2),
    ex_itm_master_uom character varying(30) COLLATE public.nocase,
    ex_itm_stack_ability numeric(13,2),
    ex_itm_stack_count numeric(13,2),
    ex_itm_stack_height numeric(13,2),
    ex_itm_stack_weight numeric(13,2),
    ex_itm_su_volume numeric(13,2),
    ex_itm_volume_uom character varying(20) COLLATE public.nocase,
    ex_itm_factory_pack character varying(40) COLLATE public.nocase,
    ex_itm_default integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    ex_itm_hdr_key bigint
);

ALTER TABLE dwh.d_excessitemsuconvdetail ALTER COLUMN d_ex_itm_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_excessitemsuconvdetail_d_ex_itm_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_excessitemsuconvdetail
    ADD CONSTRAINT d_excessitemsuconvdetail_pkey PRIMARY KEY (d_ex_itm_key);

CREATE INDEX d_excessitemsuconvdetail_idx ON dwh.d_excessitemsuconvdetail USING btree (ex_itm_ou, ex_itm_code);