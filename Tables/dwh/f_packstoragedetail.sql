CREATE TABLE dwh.f_packstoragedetail (
    pack_storage_dtl_key bigint NOT NULL,
    pack_storage_dtl_loc_key bigint NOT NULL,
    pack_location character varying(510) COLLATE public.nocase,
    pack_ou integer,
    pack_lineno integer,
    pack_storage_zone character varying(20) COLLATE public.nocase,
    pack_pack_zone character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);