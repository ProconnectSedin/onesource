CREATE TABLE raw.raw_wms_eqp_grp_dtl (
    raw_id bigint NOT NULL,
    wms_egrp_ou integer NOT NULL,
    wms_egrp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_egrp_lineno integer NOT NULL,
    wms_egrp_eqp_id character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);