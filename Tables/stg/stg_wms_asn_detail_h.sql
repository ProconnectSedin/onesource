CREATE TABLE stg.stg_wms_asn_detail_h (
    wms_asn_ou integer NOT NULL,
    wms_asn_location character varying(40) NOT NULL COLLATE public.nocase,
    wms_asn_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_asn_amendno integer NOT NULL,
    wms_asn_lineno integer NOT NULL,
    wms_asn_line_status character varying(100) COLLATE public.nocase,
    wms_asn_itm_code character varying(128) COLLATE public.nocase,
    wms_asn_qty numeric,
    wms_asn_batch_no character varying(112) COLLATE public.nocase,
    wms_asn_srl_no character varying(112) COLLATE public.nocase,
    wms_asn_manfct_date timestamp without time zone,
    wms_asn_exp_date timestamp without time zone,
    wms_asn_thu_id character varying(160) COLLATE public.nocase,
    wms_asn_thu_desc character varying(1020) COLLATE public.nocase,
    wms_asn_thu_qty numeric,
    wms_po_lineno integer,
    wms_gr_flag character(8) COLLATE public.nocase,
    wms_asn_rec_qty numeric,
    wms_asn_acc_qty numeric,
    wms_asn_rej_qty numeric,
    wms_asn_thu_srl_no character varying(112) COLLATE public.nocase,
    wms_asn_uid character varying(160) COLLATE public.nocase,
    wms_asn_rem character varying(1020) COLLATE public.nocase,
    wms_asn_itm_height numeric,
    wms_asn_itm_volume numeric,
    wms_asn_itm_weight numeric,
    wms_asn_outboundorder_no character varying(72) COLLATE public.nocase,
    wms_asn_outboundorder_qty numeric,
    wms_asn_consignee character varying(72) COLLATE public.nocase,
    wms_asn_outboundorder_lineno integer,
    wms_asn_bestbeforedate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_asn_detail_h
    ADD CONSTRAINT wms_asn_detail_h_pk PRIMARY KEY (wms_asn_ou, wms_asn_location, wms_asn_no, wms_asn_amendno, wms_asn_lineno);

CREATE INDEX stg_wms_asn_detail_h_idx ON stg.stg_wms_asn_detail_h USING btree (wms_asn_ou, wms_asn_location, wms_asn_no, wms_asn_amendno, wms_asn_lineno);