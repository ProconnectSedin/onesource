CREATE TABLE stg.stg_wms_inbound_pln_track_dtl (
    wms_pln_lineno integer NOT NULL,
    wms_pln_ou integer NOT NULL,
    wms_pln_stage character varying(32) COLLATE public.nocase,
    wms_pln_pln_no character varying(72) COLLATE public.nocase,
    wms_pln_exe_no character varying(72) COLLATE public.nocase,
    wms_pln_exe_status character varying(32) COLLATE public.nocase,
    wms_pln_user character varying(120) COLLATE public.nocase,
    wms_pln_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_inbound_pln_track_dtl
    ADD CONSTRAINT wms_inbound_pln_track_dtl_pk PRIMARY KEY (wms_pln_lineno, wms_pln_ou);

CREATE INDEX stg_wms_inbound_pln_track_dtl_key_idx2 ON stg.stg_wms_inbound_pln_track_dtl USING btree (wms_pln_lineno, wms_pln_ou);