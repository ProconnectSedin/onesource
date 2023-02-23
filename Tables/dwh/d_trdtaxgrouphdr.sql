-- Table: dwh.d_trdtaxgrouphdr

-- DROP TABLE IF EXISTS dwh.d_trdtaxgrouphdr;

CREATE TABLE IF NOT EXISTS dwh.d_trdtaxgrouphdr
(
    trdtaxgrouphdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_code character varying(20) COLLATE public.nocase,
    tax_group_code character varying(20) COLLATE public.nocase,
    tax_group_desc character varying(200) COLLATE public.nocase,
    tax_type character varying(50) COLLATE public.nocase,
    protest_flag integer,
    created_at integer,
    created_by character varying(60) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(60) COLLATE public.nocase,
    modified_date timestamp without time zone,
    "timestamp" integer,
    tax_community character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_trdtaxgrouphdr_pkey PRIMARY KEY (trdtaxgrouphdr_key),
    CONSTRAINT d_trdtaxgrouphdr_ukey UNIQUE (company_code, tax_group_code)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_trdtaxgrouphdr
    OWNER to proconnect;