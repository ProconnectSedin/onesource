CREATE TABLE raw.raw_wms_inv_profile_dtl (
    raw_id bigint NOT NULL,
    wms_inv_prof_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_inv_prof_ou integer NOT NULL,
    wms_inv_prof_lineno integer NOT NULL,
    wms_inv_prof_cust_no character varying(72) COLLATE public.nocase,
    wms_inv_prof_doc_typ character varying(160) COLLATE public.nocase,
    wms_inv_prof_gi_trigger integer,
    wms_inv_created_by character varying(120) COLLATE public.nocase,
    wms_inv_created_dt timestamp without time zone,
    wms_inv_modified_by character varying(120) COLLATE public.nocase,
    wms_inv_modified_dt timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);