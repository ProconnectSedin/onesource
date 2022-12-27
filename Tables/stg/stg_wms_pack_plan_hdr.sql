CREATE TABLE stg.stg_wms_pack_plan_hdr (
    wms_pack_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pack_pln_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pack_pln_ou integer NOT NULL,
    wms_pack_pln_date timestamp without time zone,
    wms_pack_pln_status character varying(32) COLLATE public.nocase,
    wms_pack_packed_as character varying(32) COLLATE public.nocase,
    wms_pack_employee character varying(80) COLLATE public.nocase,
    wms_pack_packing_bay character varying(72) COLLATE public.nocase,
    wms_pack_source_stage character varying(1020) COLLATE public.nocase,
    wms_pack_source_docno character varying(72) COLLATE public.nocase,
    wms_pack_created_by character varying(120) COLLATE public.nocase,
    wms_pack_created_date timestamp without time zone,
    wms_pack_modified_by character varying(120) COLLATE public.nocase,
    wms_pack_modified_date timestamp without time zone,
    wms_pack_timestamp integer,
    wms_pack_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_pack_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_pack_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_pack_pln_urgent integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pack_plan_hdr
    ADD CONSTRAINT wms_pack_plan_hdr_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_pln_no, wms_pack_pln_ou);

CREATE INDEX stg_wms_pack_plan_hdr_idx ON stg.stg_wms_pack_plan_hdr USING btree (wms_pack_loc_code, wms_pack_pln_no, wms_pack_pln_ou);