-- Table: click.f_locationholiday

-- DROP TABLE IF EXISTS click.f_locationholiday;

CREATE TABLE IF NOT EXISTS click.f_locationholiday
(
    locationholiday_hdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    locationcode character varying(250) COLLATE public.nocase,
    holidaydate date,
    nextworkingdate date,
    nextworkingday character varying COLLATE pg_catalog."default",
    etlactiveind integer DEFAULT 1,
    loadeddatetime timestamp without time zone DEFAULT now(),
    CONSTRAINT d_locationholiday_pkey PRIMARY KEY (locationholiday_hdr_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_locationholiday
    OWNER to proconnect;