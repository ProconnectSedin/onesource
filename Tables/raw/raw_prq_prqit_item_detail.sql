CREATE TABLE raw.raw_prq_prqit_item_detail (
    raw_id bigint NOT NULL,
    prqit_prou integer NOT NULL,
    prqit_prno character varying(72) NOT NULL COLLATE public.nocase,
    prqit_lineno integer NOT NULL,
    prqit_itemcode character varying(128) COLLATE public.nocase,
    prqit_variant character varying(32) COLLATE public.nocase,
    prqit_itemdescription character varying(3000) COLLATE public.nocase,
    prqit_reqdqty numeric NOT NULL,
    prqit_puom character varying(40) NOT NULL COLLATE public.nocase,
    prqit_cost numeric,
    prqit_costper numeric NOT NULL,
    prqit_needdate timestamp without time zone,
    prqit_pr_del_type character varying(32) NOT NULL COLLATE public.nocase,
    prqit_warehousecode character varying(40) COLLATE public.nocase,
    prqit_budgetid character varying(24) COLLATE public.nocase,
    prqit_prposalid character varying(72) COLLATE public.nocase,
    prqit_dropshipid character varying(64) COLLATE public.nocase,
    prqit_authqty numeric,
    prqit_customercode character varying(64) COLLATE public.nocase,
    prqit_balqty numeric,
    prqit_prlinestatus character varying(32) NOT NULL COLLATE public.nocase,
    prqit_supplier_code character varying(64) COLLATE public.nocase,
    prqit_pref_supplier_code character varying(64) COLLATE public.nocase,
    prqit_drg_revision_no character(12) COLLATE public.nocase,
    prqit_referencetype character varying(32) COLLATE public.nocase,
    prqit_ref_doc character varying(280) COLLATE public.nocase,
    prqit_refdoclineno integer,
    prqit_adhocitemclass character varying(100) COLLATE public.nocase,
    prqit_remarks character varying(1020) COLLATE public.nocase,
    prqit_attrvalue character varying(32) COLLATE public.nocase,
    prqit_createdby character varying(120) NOT NULL COLLATE public.nocase,
    prqit_createddate timestamp without time zone NOT NULL,
    prqit_lastmodifiedby character varying(120) NOT NULL COLLATE public.nocase,
    prqit_lastmodifieddate timestamp without time zone NOT NULL,
    prqit_drgno character varying(80) COLLATE public.nocase,
    prqit_wbs character varying(280) COLLATE public.nocase,
    prqit_availableqty numeric,
    prqit_location character varying(120) COLLATE public.nocase,
    prqit_comments character varying(4000) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_prq_prqit_item_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_prq_prqit_item_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_prq_prqit_item_detail
    ADD CONSTRAINT raw_prq_prqit_item_detail_pkey PRIMARY KEY (raw_id);