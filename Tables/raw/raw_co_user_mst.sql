CREATE TABLE raw.raw_co_user_mst (
    raw_id bigint NOT NULL,
    tranou integer,
    username character varying(50) COLLATE public.nocase,
    userpassword character varying(200) COLLATE public.nocase,
    isactive integer,
    createdby character varying(50) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(50) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    adminflag character varying(2) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);