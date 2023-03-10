CREATE TABLE stg.stg_wms_asn_add_dtl (
    wms_asn_pop_asn_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_asn_pop_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_asn_pop_ou integer NOT NULL,
    wms_asn_pop_line_no integer NOT NULL,
    wms_asn_pop_date_1 timestamp without time zone,
    wms_asn_pop_date_2 timestamp without time zone,
    wms_asn_pop_ud_1 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_2 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_asn_add_dtl
    ADD CONSTRAINT wms_asn_add_dtl_pk PRIMARY KEY (wms_asn_pop_asn_no, wms_asn_pop_loc, wms_asn_pop_ou, wms_asn_pop_line_no);

CREATE INDEX stg_wms_asn_add_dtl_key_idx2 ON stg.stg_wms_asn_add_dtl USING btree (wms_asn_pop_asn_no, wms_asn_pop_loc, wms_asn_pop_ou, wms_asn_pop_line_no);