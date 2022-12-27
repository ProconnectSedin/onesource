CREATE TABLE stg.stg_wms_outbound_doc_detail (
    wms_oub_doc_loc_code character varying(160) NOT NULL COLLATE public.nocase,
    wms_oub_outbound_ord character varying(1020) NOT NULL COLLATE public.nocase,
    wms_oub_doc_lineno integer NOT NULL,
    wms_oub_doc_ou integer NOT NULL,
    wms_oub_doc_type character varying(160) COLLATE public.nocase,
    wms_oub_doc_attach character varying(1020) COLLATE public.nocase,
    wms_oub_doc_hdn_attach character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_outbound_doc_detail
    ADD CONSTRAINT wms_oubound_doc_detail_pk PRIMARY KEY (wms_oub_doc_loc_code, wms_oub_outbound_ord, wms_oub_doc_lineno, wms_oub_doc_ou);

CREATE INDEX stg_wms_outbound_doc_detail_key_idx ON stg.stg_wms_outbound_doc_detail USING btree (wms_oub_doc_ou, wms_oub_doc_loc_code, wms_oub_outbound_ord);

CREATE INDEX stg_wms_outbound_doc_detail_key_idx1 ON stg.stg_wms_outbound_doc_detail USING btree (wms_oub_doc_loc_code, wms_oub_doc_ou);

CREATE INDEX stg_wms_outbound_doc_detail_key_idx2 ON stg.stg_wms_outbound_doc_detail USING btree (wms_oub_doc_loc_code, wms_oub_outbound_ord, wms_oub_doc_lineno, wms_oub_doc_ou);