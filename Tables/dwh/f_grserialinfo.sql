CREATE TABLE dwh.f_grserialinfo (
    gr_gsi_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_loc_code character varying(20) COLLATE public.nocase,
    gr_exec_no character varying(40) COLLATE public.nocase,
    gr_exec_ou integer,
    gr_lineno integer,
    gr_po_no character varying(40) COLLATE public.nocase,
    gr_po_sno character varying(60) COLLATE public.nocase,
    gr_item character varying(510) COLLATE public.nocase,
    gr_serial_no character varying(60) COLLATE public.nocase,
    gr_status character varying(20) COLLATE public.nocase,
    gr_cust_sno character varying(60) COLLATE public.nocase,
    gr_3pl_sno character varying(60) COLLATE public.nocase,
    gr_lot_no character varying(60) COLLATE public.nocase,
    gr_item_lineno integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);