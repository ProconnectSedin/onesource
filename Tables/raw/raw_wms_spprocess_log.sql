CREATE TABLE raw.raw_wms_spprocess_log (
    raw_id bigint NOT NULL,
    wms_sp_guid character varying(512) NOT NULL COLLATE public.nocase,
    wms_spctxt_user character varying(120) NOT NULL COLLATE public.nocase,
    wms_process character varying(1020) COLLATE public.nocase,
    wms_bn_startdate timestamp without time zone,
    wms_bn_enddate timestamp without time zone,
    wms_grpln_no character varying(72) COLLATE public.nocase,
    wms_grexec_no character varying(72) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);