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

ALTER TABLE ods.source_target_count ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME ods.source_target_count_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);