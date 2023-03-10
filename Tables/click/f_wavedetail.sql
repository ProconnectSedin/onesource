-- Table: click.f_wavedetail

-- DROP TABLE IF EXISTS click.f_wavedetail;

CREATE TABLE IF NOT EXISTS click.f_wavedetail
(
    wave_dtl_key bigint NOT NULL,
    wave_loc_key bigint NOT NULL,
    wave_item_key bigint NOT NULL,
    wave_cust_key bigint NOT NULL,
    wave_hdr_key bigint NOT NULL,
    wave_loc_code character varying(20) COLLATE public.nocase,
    wave_no character varying(40) COLLATE public.nocase,
    wave_ou integer,
    wave_lineno integer,
    wave_so_no character varying(40) COLLATE public.nocase,
    wave_so_sr_no integer,
    wave_so_sch_no integer,
    wave_item_code character varying(80) COLLATE public.nocase,
    wave_qty numeric(13,2),
    wave_line_status character varying(20) COLLATE public.nocase,
    wave_outbound_no character varying(40) COLLATE public.nocase,
    wave_customer_code character varying(40) COLLATE public.nocase,
    wave_customer_item_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_wavedetail_pkey PRIMARY KEY (wave_dtl_key),
    CONSTRAINT f_wavedetail_ukey UNIQUE (wave_lineno, wave_no, wave_ou, wave_loc_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wavedetail
    OWNER to proconnect;