-- Table: click.f_waveheader

-- DROP TABLE IF EXISTS click.f_waveheader;

CREATE TABLE IF NOT EXISTS click.f_waveheader
(
    wave_hdr_key bigint NOT NULL,
    wave_loc_key bigint NOT NULL,
    wave_loc_code character varying(20) COLLATE public.nocase,
    wave_no character varying(40) COLLATE public.nocase,
    wave_ou integer,
    wave_date timestamp without time zone,
    wave_status character varying(20) COLLATE public.nocase,
    wave_pln_start_date timestamp without time zone,
    wave_pln_end_date timestamp without time zone,
    wave_timestamp integer,
    wave_created_by character varying(60) COLLATE public.nocase,
    wave_created_date timestamp without time zone,
    wave_modified_by character varying(60) COLLATE public.nocase,
    wave_modified_date timestamp without time zone,
    wave_alloc_rule character varying(20) COLLATE public.nocase,
    wave_alloc_value numeric(13,2),
    wave_alloc_uom character varying(20) COLLATE public.nocase,
    wave_no_of_pickers integer,
    wave_gen_flag character varying(20) COLLATE public.nocase,
    wave_staging_id character varying(40) COLLATE public.nocase,
    wave_replenish_flag character varying(30) COLLATE public.nocase,
    consolidated_flg character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_waveheader_pkey PRIMARY KEY (wave_hdr_key),
    CONSTRAINT f_waveheader_ukey UNIQUE (wave_loc_code, wave_no, wave_ou)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_waveheader
    OWNER to proconnect;