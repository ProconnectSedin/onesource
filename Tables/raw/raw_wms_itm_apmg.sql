CREATE TABLE raw.raw_wms_itm_apmg (
    raw_id bigint NOT NULL,
    itemcode character varying(100) COLLATE public.nocase,
    sbugroup character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);