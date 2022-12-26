CREATE TABLE stg.stg_pcsit_serviceprovider_rcs (
    serviceprov_id character(40) COLLATE public.nocase,
    serviceprov_name character varying COLLATE public.nocase,
    serviceprov_url character varying COLLATE public.nocase,
    created_by character varying(200) COLLATE public.nocase,
    created_date date DEFAULT now(),
    status character(40) DEFAULT 'Y'::bpchar COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);