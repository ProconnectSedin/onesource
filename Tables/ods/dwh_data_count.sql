-- Table: ods.dwh_data_count

-- DROP TABLE IF EXISTS ods.dwh_data_count;

CREATE TABLE IF NOT EXISTS ods.dwh_data_count
(
    sourcetable character varying(100) COLLATE public.nocase,
    dwhtablename character varying(100) COLLATE public.nocase,
    dimension character varying(100) COLLATE public.nocase,
    period character varying(100) COLLATE public.nocase,
    datacount bigint,
    createddatetime timestamp without time zone NOT NULL DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.dwh_data_count
    OWNER to proconnect;