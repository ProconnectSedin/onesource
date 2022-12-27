CREATE TABLE raw.raw_po_poitm_item_detail (
    raw_id bigint NOT NULL,
    poitm_poou integer NOT NULL,
    poitm_pono character varying(72) NOT NULL COLLATE public.nocase,
    poitm_poamendmentno integer NOT NULL,
    poitm_polineno integer NOT NULL,
    poitm_itemcode character varying(128) COLLATE public.nocase,
    poitm_variant character varying(32) COLLATE public.nocase,
    poitm_order_quantity numeric,
    poitm_pobalancequantity numeric,
    poitm_puom character varying(40) COLLATE public.nocase,
    poitm_po_cost numeric,
    poitm_costper numeric,
    poitm_shiptoou integer,
    poitm_tcdtotalamount numeric,
    poitm_warehousecode character varying(40) COLLATE public.nocase,
    poitm_itemvalue numeric,
    poitm_polinestatus character varying(32) NOT NULL COLLATE public.nocase,
    poitm_createdby character varying(120) NOT NULL COLLATE public.nocase,
    poitm_createddate timestamp without time zone NOT NULL,
    poitm_lastmodifiedby character varying(120) NOT NULL COLLATE public.nocase,
    poitm_lastmodifieddate timestamp without time zone NOT NULL,
    poitm_itemdescription character varying(3000) COLLATE public.nocase,
    poitm_schedtype character varying(32) NOT NULL COLLATE public.nocase,
    poitm_needdate timestamp without time zone,
    poitm_accunit character varying(80) COLLATE public.nocase,
    poitm_drawingrevno character varying(40) COLLATE public.nocase,
    poitm_adhocitemclass character varying(80) COLLATE public.nocase,
    poitm_refdocno character varying(72) COLLATE public.nocase,
    poitm_refdoclineno integer,
    poitm_comments character varying(4000) COLLATE public.nocase,
    poitm_bugetid character varying(24) COLLATE public.nocase,
    poitm_customercode character varying(64) COLLATE public.nocase,
    poitm_proposalid character varying(72) COLLATE public.nocase,
    poitm_dropshipid character varying(24) COLLATE public.nocase,
    poitm_attrvalue character varying(32) COLLATE public.nocase,
    poitm_contactperson character varying(180) COLLATE public.nocase,
    poitm_grrecdqty numeric,
    poitm_graccpdqty numeric,
    poitm_grreturnedqty numeric,
    poitm_grrejdqty numeric,
    poitm_grmovdqty numeric,
    poitm_qtnlineno integer,
    poitm_despatchqty numeric,
    poitm_matched_qty numeric,
    poitm_matched_amt numeric,
    poitm_billed_qty numeric,
    poitm_billed_amt numeric,
    poitm_drgno character varying(80) COLLATE public.nocase,
    poitm_project character varying(280) COLLATE public.nocase,
    poitm_project_ou integer,
    poitm_ms_app_flag character varying(32) COLLATE public.nocase,
    poitm_retained_amt numeric,
    poitm_retention_amt numeric,
    poitm_ret_remarks character varying COLLATE public.nocase,
    poitm_wbs_id character varying(280) COLLATE public.nocase,
    poitm_solineno integer,
    poitm_adhocplng character varying(32) DEFAULT 'NA'::character varying COLLATE public.nocase,
    poitm_location character varying(64) COLLATE public.nocase,
    poitm_availableqty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_po_poitm_item_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_po_poitm_item_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_po_poitm_item_detail
    ADD CONSTRAINT raw_po_poitm_item_detail_pkey PRIMARY KEY (raw_id);