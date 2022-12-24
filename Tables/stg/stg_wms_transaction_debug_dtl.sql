CREATE TABLE stg.stg_wms_transaction_debug_dtl (
    sessionid integer,
    guid character varying(512) COLLATE public.nocase,
    tran_no character varying(72) COLLATE public.nocase,
    ou integer,
    location character varying(40) COLLATE public.nocase,
    tran_type character varying(100) COLLATE public.nocase,
    line_no integer,
    remarks character varying COLLATE public.nocase,
    loginuser character varying(120) COLLATE public.nocase,
    insertdatetime timestamp without time zone,
    servicename character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);