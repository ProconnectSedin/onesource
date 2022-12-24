CREATE TABLE stg.stg_pcsit_obd_sadsap_dtl (
    location character varying(200) COLLATE public.nocase,
    itemcode character varying(200) COLLATE public.nocase,
    qty character varying(200) COLLATE public.nocase,
    flag character(2) COLLATE public.nocase,
    guid character varying(255) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);