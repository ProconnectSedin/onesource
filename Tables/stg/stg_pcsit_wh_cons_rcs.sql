CREATE TABLE stg.stg_pcsit_wh_cons_rcs (
    wh_cong_id integer NOT NULL,
    wh_id integer,
    cong_id integer,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);