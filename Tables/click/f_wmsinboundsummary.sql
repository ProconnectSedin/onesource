-- Table: click.f_wmsinboundsummary

DROP TABLE IF EXISTS click.f_wmsinboundsummary;

CREATE TABLE IF NOT EXISTS click.f_wmsinboundsummary
(
    wms_ib_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    customer_key bigint,
    datekey bigint,
    loc_key bigint,
    ou_id integer,
    customer_id character varying(40) COLLATE public.nocase,
    asn_key bigint,
    asn_no character varying(40) COLLATE pg_catalog."default",
    asn_prefdoc_no character varying(40) COLLATE pg_catalog."default",
    asn_date date,
    item_group character varying(80) COLLATE public.nocase,
    item_class character varying(80) COLLATE public.nocase,
    loc_code character varying(20) COLLATE public.nocase,
    asn_type character varying(20) COLLATE public.nocase,
    inb_type character varying(20) COLLATE public.nocase,
    grn_status character varying(20) COLLATE public.nocase,
    pway_status character varying(20) COLLATE public.nocase,
    receivedlinecount integer,
    receivedunit numeric(20,2),
    cumvolume numeric(20,2),
    cucmvolume numeric(20,2),
    grn_hht_ind numeric(20,2),
    pway_hht_ind numeric(20,2),
    loadeddatetime timestamp without time zone DEFAULT now(),
    activeindicator integer,
    CONSTRAINT f_wmsinboundsummary_pkey PRIMARY KEY (wms_ib_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_wmsinboundsummary
    OWNER to proconnect;
-- Index: f_wmsinboundsummary_key_idx1

-- DROP INDEX IF EXISTS click.f_wmsinboundsummary_key_idx1;

CREATE INDEX IF NOT EXISTS f_wmsinboundsummary_key_idx1
    ON click.f_wmsinboundsummary USING btree
    (customer_key ASC NULLS LAST, datekey ASC NULLS LAST, loc_key ASC NULLS LAST, ou_id ASC NULLS LAST, item_group COLLATE public.nocase ASC NULLS LAST, item_class COLLATE public.nocase ASC NULLS LAST, asn_type COLLATE public.nocase ASC NULLS LAST, inb_type COLLATE public.nocase ASC NULLS LAST, grn_status COLLATE public.nocase ASC NULLS LAST, pway_status COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;