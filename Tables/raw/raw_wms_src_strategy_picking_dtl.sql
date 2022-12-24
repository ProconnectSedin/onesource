CREATE TABLE raw.raw_wms_src_strategy_picking_dtl (
    raw_id bigint NOT NULL,
    wms_pic_ou integer NOT NULL,
    wms_pic_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pic_lineno integer NOT NULL,
    wms_pic_ord_prior character varying(32) COLLATE public.nocase,
    wms_pic_seqno integer,
    wms_pic_zone character varying(40) COLLATE public.nocase,
    wms_pic_su_seqno integer NOT NULL,
    wms_pic_su character varying(40) COLLATE public.nocase,
    wms_pic_created_by character varying(120) COLLATE public.nocase,
    wms_pic_created_date timestamp without time zone,
    wms_pic_modified_by character varying(120) COLLATE public.nocase,
    wms_pic_modified_date timestamp without time zone,
    wms_pic_timestamp integer,
    wms_pic_seqno_rev integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);