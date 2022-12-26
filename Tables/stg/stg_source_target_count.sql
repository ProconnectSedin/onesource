CREATE TABLE stg.stg_source_target_count (
    sourcetable character varying(100) COLLATE public.nocase,
    dimension character varying(50) COLLATE public.nocase,
    sourceattributes character varying(50) COLLATE public.nocase,
    period bigint,
    sourcedatacount bigint,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);