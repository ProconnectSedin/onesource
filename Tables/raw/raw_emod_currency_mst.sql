CREATE TABLE raw.raw_emod_currency_mst (
    raw_id bigint NOT NULL,
    iso_curr_code character varying(20) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    ctimestamp integer,
    num_curr_code character varying(20) COLLATE public.nocase,
    curr_symbol character varying(20) COLLATE public.nocase,
    curr_desc character varying(480) COLLATE public.nocase,
    curr_sub_units integer,
    curr_sub_unit_desc character varying(400) COLLATE public.nocase,
    curr_units integer,
    currency_status character varying(100) COLLATE public.nocase,
    curr_symbol_flag character varying(48) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_emod_currency_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_emod_currency_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_emod_currency_mst
    ADD CONSTRAINT raw_emod_currency_mst_pkey PRIMARY KEY (raw_id);