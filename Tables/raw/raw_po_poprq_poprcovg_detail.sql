CREATE TABLE raw.raw_po_poprq_poprcovg_detail (
    raw_id bigint NOT NULL,
    poprq_poou integer NOT NULL,
    poprq_pono character varying(72) NOT NULL COLLATE public.nocase,
    poprq_poamendmentno integer NOT NULL,
    poprq_polineno integer NOT NULL,
    poprq_scheduleno integer NOT NULL,
    poprq_prno character varying(72) NOT NULL COLLATE public.nocase,
    poprq_posubscheduleno integer NOT NULL,
    poprq_prlineno integer NOT NULL,
    poprq_prou integer NOT NULL,
    poprq_pr_shdno integer NOT NULL,
    poprq_pocovqty numeric NOT NULL,
    poprq_createdby character varying(120) NOT NULL COLLATE public.nocase,
    poprq_pr_subsceduleno integer NOT NULL,
    poprq_createddate timestamp without time zone NOT NULL,
    poprq_lastmodifiedby character varying(120) NOT NULL COLLATE public.nocase,
    poprq_grrecvdqty numeric,
    poprq_lastmodifieddate timestamp without time zone NOT NULL,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_po_poprq_poprcovg_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_po_poprq_poprcovg_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_po_poprq_poprcovg_detail
    ADD CONSTRAINT raw_po_poprq_poprcovg_detail_pkey PRIMARY KEY (raw_id);