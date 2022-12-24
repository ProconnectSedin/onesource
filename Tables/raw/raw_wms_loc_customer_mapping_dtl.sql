CREATE TABLE raw.raw_wms_loc_customer_mapping_dtl (
    raw_id bigint NOT NULL,
    wms_loc_ou integer NOT NULL,
    wms_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_loc_lineno integer NOT NULL,
    wms_loc_cust_code character varying(72) COLLATE public.nocase,
    wms_cost_centre character varying(40) COLLATE public.nocase,
    wms_contract_id character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);