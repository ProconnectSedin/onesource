-- Table: click.f_packexecheader

-- DROP TABLE IF EXISTS click.f_packexecheader;

CREATE TABLE IF NOT EXISTS click.f_packexecheader
(
    pack_exe_hdr_key bigint NOT NULL,
    pack_loc_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_exec_date timestamp without time zone,
    pack_exec_status character varying(20) COLLATE public.nocase,
    pack_pln_no character varying(40) COLLATE public.nocase,
    pack_employee character varying(40) COLLATE public.nocase,
    pack_packing_bay character varying(40) COLLATE public.nocase,
    pack_pre_pack_bay character varying(40) COLLATE public.nocase,
    pack_created_by character varying(60) COLLATE public.nocase,
    pack_created_date timestamp without time zone,
    pack_modified_by character varying(60) COLLATE public.nocase,
    pack_modified_date timestamp without time zone,
    pack_timestamp integer,
    pack_exec_start_date timestamp without time zone,
    pack_exec_end_date timestamp without time zone,
    pack_exe_urgent integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_packexecheader_pkey PRIMARY KEY (pack_exe_hdr_key),
    CONSTRAINT f_packexecheader_ukey UNIQUE (pack_loc_code, pack_exec_no, pack_exec_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_packexecheader
    OWNER to proconnect;