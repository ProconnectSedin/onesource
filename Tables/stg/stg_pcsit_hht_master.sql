CREATE TABLE stg.stg_pcsit_hht_master (
    id integer,
    locationcode character varying(30) COLLATE public.nocase,
    locationdesc character varying(50) COLLATE public.nocase,
    brand character varying(50) COLLATE public.nocase,
    count integer,
    oldcount040220 integer,
    oldcount300920 integer,
    oldcount030321 integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);