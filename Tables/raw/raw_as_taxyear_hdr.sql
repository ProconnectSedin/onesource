CREATE TABLE raw.raw_as_taxyear_hdr (
    raw_id bigint NOT NULL,
    taxyr_code character varying(40) NOT NULL COLLATE public.nocase,
    "timestamp" integer,
    taxyr_desc character varying(160) COLLATE public.nocase,
    taxyr_startdt timestamp without time zone,
    taxyr_enddt timestamp without time zone,
    frequency character varying(80) COLLATE public.nocase,
    taxyr_status character varying(8) COLLATE public.nocase,
    resou_id integer,
    rescomp_code character varying(40) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);