-- Table: click.f_pickingheader

-- DROP TABLE IF EXISTS click.f_pickingheader;

CREATE TABLE IF NOT EXISTS click.f_pickingheader
(
    pick_hdr_key bigint NOT NULL,
    pick_loc_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_exec_no character varying(40) COLLATE public.nocase,
    pick_exec_ou integer,
    pick_exec_date timestamp without time zone,
    pick_exec_status character varying(20) COLLATE public.nocase,
    pick_pln_no character varying(40) COLLATE public.nocase,
    pick_employee character varying(40) COLLATE public.nocase,
    pick_mhe character varying(60) COLLATE public.nocase,
    pick_staging_id character varying(40) COLLATE public.nocase,
    pick_exec_start_date timestamp without time zone,
    pick_exec_end_date timestamp without time zone,
    pick_created_by character varying(60) COLLATE public.nocase,
    pick_created_date timestamp without time zone,
    pick_modified_by character varying(60) COLLATE public.nocase,
    pick_modified_date timestamp without time zone,
    pick_timestamp integer,
    pick_steps character varying(40) COLLATE public.nocase,
    pk_exe_urgent_cb character varying(510) COLLATE public.nocase,
    pick_gen_from character varying(20) COLLATE public.nocase,
    pick_pln_type character varying(20) COLLATE public.nocase,
    pick_zone_pickby character varying(20) COLLATE public.nocase,
    pick_reset_flg character varying(20) COLLATE public.nocase,
    pick_system_date timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_pickingheader_pkey PRIMARY KEY (pick_hdr_key),
    CONSTRAINT f_pickingheader_ukey UNIQUE (pick_loc_code, pick_exec_no, pick_exec_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_pickingheader
    OWNER to proconnect;