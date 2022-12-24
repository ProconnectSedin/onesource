CREATE TABLE stg.stg_wms_financial_dimension_odo_dtl (
    wms_fin_dim_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_fin_dim_order_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_fin_dim_order_ou integer NOT NULL,
    wms_fin_dim_customer_id character varying(72) COLLATE public.nocase,
    wms_fin_dim_cust_bill_atribute character varying(1020) COLLATE public.nocase,
    wms_fin_dim_cust_ind_atribute character varying(1020) COLLATE public.nocase,
    wms_fin_dim_ord_service character varying(1020) COLLATE public.nocase,
    wms_fin_dim_sales_org_atribute character varying(1020) COLLATE public.nocase,
    wms_fin_dim_loc_atribute character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);