CREATE TABLE stg.stg_pcs_track_registereddockets_tbl_onetime (
    id integer NOT NULL,
    orderid character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcs_track_registereddockets_tbl_onetime ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcs_track_registereddockets_tbl_onetime_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);