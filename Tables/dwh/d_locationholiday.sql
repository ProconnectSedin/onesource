-- Table: dwh.d_locationholiday

-- DROP TABLE IF EXISTS dwh.d_locationholiday;

CREATE TABLE IF NOT EXISTS dwh.d_locationholiday
(
    locationholiday_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    locationcode character varying(250) COLLATE public.nocase,
    holidaydate timestamp(3) without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_locationholiday_pkey PRIMARY KEY (locationholiday_hdr_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_locationholiday
    OWNER to proconnect;