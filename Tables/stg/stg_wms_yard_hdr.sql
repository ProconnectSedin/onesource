CREATE TABLE stg.stg_wms_yard_hdr (
    wms_yard_id character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_yard_ou integer NOT NULL,
    wms_yard_desc character varying(600) COLLATE public.nocase,
    wms_yard_type character varying(160) COLLATE public.nocase,
    wms_yard_status character varying(32) COLLATE public.nocase,
    wms_yard_reason character varying(160) COLLATE public.nocase,
    wms_yard_timestamp integer,
    wms_yard_created_by character varying(120) COLLATE public.nocase,
    wms_yard_created_dt timestamp without time zone,
    wms_yard_modified_by character varying(120) COLLATE public.nocase,
    wms_yard_modified_dt timestamp without time zone,
    wms_yard_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_yard_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_yard_userdefined3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_yard_hdr
    ADD CONSTRAINT wms_yard_hdr_pk PRIMARY KEY (wms_yard_id, wms_yard_loc_code, wms_yard_ou);