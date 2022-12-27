-- Table: ods.source_target_count

DROP TABLE IF EXISTS ods.source_target_count;

CREATE TABLE IF NOT EXISTS ods.source_target_count
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    sourcetable character varying(100) COLLATE public.nocase,
    targettable character varying(100) COLLATE public.nocase,
    dimension character varying(50) COLLATE public.nocase,
    sourceattributes character varying(50) COLLATE public.nocase,
    targetattributes character varying(50) COLLATE public.nocase,
    period character varying COLLATE pg_catalog."default",
    sourcedatacount bigint,
    targetdatacount bigint,
    createddatetime timestamp(3) without time zone DEFAULT now(),
    diffcount bigint
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS ods.source_target_count
    OWNER to proconnect;

