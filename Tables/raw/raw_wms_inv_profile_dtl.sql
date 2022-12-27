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

ALTER TABLE raw.raw_wms_inv_profile_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_inv_profile_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_inv_profile_dtl
    ADD CONSTRAINT raw_wms_inv_profile_dtl_pkey PRIMARY KEY (raw_id);