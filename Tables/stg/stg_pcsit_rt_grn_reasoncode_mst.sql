CREATE TABLE stg.stg_pcsit_rt_grn_reasoncode_mst (
    id integer NOT NULL,
    sapreasons character varying COLLATE public.nocase,
    userreasons character varying COLLATE public.nocase,
    status character varying(30) COLLATE public.nocase,
    createddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);