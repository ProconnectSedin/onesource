CREATE TABLE stg.stg_fact_outbound_wave (
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    wave_ou integer NOT NULL,
    wave_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wave_no character varying(72) COLLATE public.nocase,
    wave_lineno integer,
    wave_item_code character varying(128) COLLATE public.nocase,
    wave_qty numeric,
    wave_date timestamp without time zone,
    wave_status character varying(32) COLLATE public.nocase,
    wave_pln_start_date timestamp without time zone,
    wave_pln_end_date timestamp without time zone,
    wave_created_by character varying(120) COLLATE public.nocase,
    wave_created_date timestamp without time zone,
    wave_modified_by character varying(120) COLLATE public.nocase,
    wave_modified_date timestamp without time zone,
    wave_userdefined1 character varying(1020) COLLATE public.nocase,
    wave_userdefined2 character varying(1020) COLLATE public.nocase,
    wave_userdefined3 character varying(1020) COLLATE public.nocase,
    wave_alloc_rule character varying(32) COLLATE public.nocase,
    wave_alloc_value numeric,
    wave_alloc_uom character varying(32) COLLATE public.nocase,
    wave_no_of_pickers integer,
    wave_run_no character varying(72) COLLATE public.nocase,
    wave_gen_flag character varying(32) COLLATE public.nocase,
    wave_staging_id character varying(72) COLLATE public.nocase,
    wave_replenish_flag character varying(48) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_fact_outbound_wave
    ADD CONSTRAINT pk__fact_out__4cd9458e13a853f2 PRIMARY KEY (refkey);