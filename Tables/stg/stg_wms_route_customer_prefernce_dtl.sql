CREATE TABLE stg.stg_wms_route_customer_prefernce_dtl (
    wms_rou_route_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_rou_custprf_ou integer NOT NULL,
    wms_rou_custprf_lineno integer NOT NULL,
    wms_rou_custprf_customer_id character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_route_customer_prefernce_dtl
    ADD CONSTRAINT wms_route_customer_prefernce_dtl_pk PRIMARY KEY (wms_rou_route_id, wms_rou_custprf_ou, wms_rou_custprf_lineno);