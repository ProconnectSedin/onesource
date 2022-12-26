CREATE TABLE ods.source_target_count (
    id bigint NOT NULL,
    sourcetable character varying(100) COLLATE public.nocase,
    targettable character varying(100) COLLATE public.nocase,
    dimension character varying(50) COLLATE public.nocase,
    sourceattributes character varying(50) COLLATE public.nocase,
    targetattributes character varying(50) COLLATE public.nocase,
    period character varying,
    sourcedatacount bigint,
    targetdatacount bigint,
    createddatetime timestamp(3) without time zone DEFAULT now(),
    diffcount bigint
);