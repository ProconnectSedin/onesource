CREATE TABLE raw.raw_fact_outbound_wave (
    raw_id bigint NOT NULL,
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

ALTER TABLE raw.raw_fact_outbound_wave ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_wave_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_wave
    ADD CONSTRAINT raw_fact_outbound_wave_pkey PRIMARY KEY (raw_id);