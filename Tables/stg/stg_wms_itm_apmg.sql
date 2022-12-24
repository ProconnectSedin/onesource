CREATE TABLE stg.stg_wms_itm_apmg (
    itemcode character varying(100) COLLATE public.nocase,
    sbugroup character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);