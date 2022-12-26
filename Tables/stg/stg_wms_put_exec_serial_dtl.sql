CREATE TABLE stg.stg_wms_put_exec_serial_dtl (
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pway_exec_ou integer NOT NULL,
    wms_pway_lineno integer NOT NULL,
    wms_pway_itm_lineno integer,
    wms_pway_zone character varying(40) COLLATE public.nocase,
    wms_pway_bin character varying(40) COLLATE public.nocase,
    wms_pway_serialno character varying(112) COLLATE public.nocase,
    wms_pway_lotno character varying(112) COLLATE public.nocase,
    wms_pway_staging character varying(72) COLLATE public.nocase,
    wms_pway_cust_sno character varying(112) COLLATE public.nocase,
    wms_pway_3pl_sno character varying(112) COLLATE public.nocase,
    wms_pway_warranty_sno character varying(112) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);