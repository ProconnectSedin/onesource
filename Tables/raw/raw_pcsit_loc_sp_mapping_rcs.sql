CREATE TABLE raw.raw_pcsit_loc_sp_mapping_rcs (
    raw_id bigint NOT NULL,
    rowid integer NOT NULL,
    sp_id character(40) COLLATE public.nocase,
    loc_id character(40) COLLATE public.nocase,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);