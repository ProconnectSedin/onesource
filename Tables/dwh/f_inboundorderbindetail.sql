CREATE TABLE dwh.f_inboundorderbindetail (
    in_ord_bin_dtl_key bigint NOT NULL,
    in_ord_hdr_key bigint NOT NULL,
    inb_loc_key bigint NOT NULL,
    in_ord_location character varying(20) COLLATE public.nocase,
    in_ord_no character varying(40) COLLATE public.nocase,
    in_ord_lineno integer,
    in_ord_ou integer,
    in_ord_item character varying(40) COLLATE public.nocase,
    in_ord_bin_qty numeric(132,0),
    in_ord_source_bin character varying(20) COLLATE public.nocase,
    in_ord_target_bin character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);