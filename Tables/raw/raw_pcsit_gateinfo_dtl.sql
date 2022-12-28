CREATE TABLE raw.raw_pcsit_gateinfo_dtl (
    raw_id bigint NOT NULL,
    id integer NOT NULL,
    orderno character varying(50) COLLATE public.nocase,
    gateno character varying(50) COLLATE public.nocase,
    ewayno character varying(50) COLLATE public.nocase,
    ewaydate character varying(50) COLLATE public.nocase,
    awbno character varying(50) COLLATE public.nocase,
    drivername character varying(150) COLLATE public.nocase,
    contactno character varying(150) COLLATE public.nocase,
    vehno character varying(150) COLLATE public.nocase,
    driverlicenseno character varying(150) COLLATE public.nocase,
    transporter character varying(100) COLLATE public.nocase,
    isnno character varying(100) COLLATE public.nocase,
    createdby character varying(100) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_gateinfo_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_gateinfo_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_gateinfo_dtl
    ADD CONSTRAINT raw_pcsit_gateinfo_dtl_pkey PRIMARY KEY (raw_id);