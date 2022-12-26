CREATE TABLE ods.dwh_data_count (
    sourcetable character varying(100) COLLATE public.nocase,
    dwhtablename character varying(100) COLLATE public.nocase,
    dimension character varying(100) COLLATE public.nocase,
    period character varying(100) COLLATE public.nocase,
    datacount bigint,
    createddatetime timestamp without time zone DEFAULT now() NOT NULL
);