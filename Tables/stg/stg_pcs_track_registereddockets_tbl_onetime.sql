CREATE TABLE stg.stg_pcs_track_registereddockets_tbl_onetime (
    id integer NOT NULL,
    orderid character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);