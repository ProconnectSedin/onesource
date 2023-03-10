CREATE TABLE stg.stg_wms_src_strat_bts_pway_dtl (
    wms_bts_ou integer NOT NULL,
    wms_bts_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_bts_lineno integer NOT NULL,
    wms_bts_zone character varying(40) COLLATE public.nocase,
    wms_bts_bin_seqno integer NOT NULL,
    wms_bts_bin character varying(80) COLLATE public.nocase,
    wms_bts_created_by character varying(120) COLLATE public.nocase,
    wms_bts_created_date timestamp without time zone,
    wms_bts_modified_by character varying(120) COLLATE public.nocase,
    wms_bts_modified_date timestamp without time zone,
    wms_bts_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_src_strat_bts_pway_dtl
    ADD CONSTRAINT wms_src_strat_bts_pway_dtl_pk PRIMARY KEY (wms_bts_ou, wms_bts_loc_code, wms_bts_lineno, wms_bts_bin_seqno);