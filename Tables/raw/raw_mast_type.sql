CREATE TABLE raw.raw_mast_type (
    raw_id bigint NOT NULL,
    row_id integer NOT NULL,
    ordertype character varying(1000) COLLATE public.nocase,
    pri_ordertype character varying(1000) COLLATE public.nocase,
    description character varying(1000) COLLATE public.nocase,
    sec_ordertype character varying(1000) COLLATE public.nocase,
    pri_reqtype character varying(1000) COLLATE public.nocase,
    sec_reqtype character varying(1000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);