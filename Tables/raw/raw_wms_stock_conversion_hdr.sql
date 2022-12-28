CREATE TABLE raw.raw_wms_stock_conversion_hdr (
    raw_id bigint NOT NULL,
    wms_stk_con_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_stk_con_proposal_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_stk_con_proposal_ou integer NOT NULL,
    wms_stk_con_proposal_date timestamp without time zone,
    wms_stk_con_proposal_status character varying(32) COLLATE public.nocase,
    wms_stk_con_proposal_type character varying(32) COLLATE public.nocase,
    wms_stk_con_ref_doc_no character varying(72) COLLATE public.nocase,
    wms_stk_con_approver character varying(100) COLLATE public.nocase,
    wms_stk_con_remarks character varying(1020) COLLATE public.nocase,
    wms_stk_con_created_by character varying(120) COLLATE public.nocase,
    wms_stk_con_created_date timestamp without time zone,
    wms_stk_con_modified_by character varying(120) COLLATE public.nocase,
    wms_stk_con_modified_date timestamp without time zone,
    wms_stk_con_timestamp integer,
    wms_stk_con_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_stk_con_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_stk_con_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_stk_recasfee_last_bil_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_stock_conversion_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_stock_conversion_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_stock_conversion_hdr
    ADD CONSTRAINT raw_wms_stock_conversion_hdr_pkey PRIMARY KEY (raw_id);