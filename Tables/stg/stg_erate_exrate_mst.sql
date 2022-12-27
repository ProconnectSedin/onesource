CREATE TABLE stg.stg_erate_exrate_mst (
    ou_id integer NOT NULL,
    exchrate_type character varying(40) NOT NULL COLLATE public.nocase,
    from_currency character varying(20) NOT NULL COLLATE public.nocase,
    to_currency character varying(20) NOT NULL COLLATE public.nocase,
    inverse_typeno character varying(4) NOT NULL COLLATE public.nocase,
    start_date timestamp without time zone NOT NULL,
    "timestamp" integer,
    serial_no integer,
    end_date timestamp without time zone,
    exchange_rate numeric,
    tolerance_flag character varying(4) COLLATE public.nocase,
    tolerance_limit numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_erate_exrate_mst
    ADD CONSTRAINT erate_exrate_mst_pkey PRIMARY KEY (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);