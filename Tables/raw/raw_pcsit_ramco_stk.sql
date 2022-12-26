CREATE TABLE raw.raw_pcsit_ramco_stk (
    raw_id bigint NOT NULL,
    wms_inb_loc_code character varying(800) COLLATE public.nocase,
    wms_inb_refdocno character varying(800) COLLATE public.nocase,
    wms_inb_orderdate timestamp without time zone,
    wms_inb_item_code character varying(800) COLLATE public.nocase,
    wms_inb_order_qty integer,
    wms_asn_no character varying(800) COLLATE public.nocase,
    wms_asn_date timestamp without time zone,
    wms_asn_status character varying(800) COLLATE public.nocase,
    wms_inb_cust_po_lineno character varying(800) COLLATE public.nocase,
    wms_asn_itm_code character varying(800) COLLATE public.nocase,
    wms_asn_qty integer,
    wms_asn_sup_asn_no character varying(800) COLLATE public.nocase,
    wms_gr_no character varying(800) COLLATE public.nocase,
    wms_gr_exec_status character varying(800) COLLATE public.nocase,
    wms_pway_pln_no character varying(800) COLLATE public.nocase,
    wms_pway_allocated_qty integer,
    ou integer,
    guid character varying(800) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);