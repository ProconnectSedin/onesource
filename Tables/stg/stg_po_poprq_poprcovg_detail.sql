CREATE TABLE stg.stg_po_poprq_poprcovg_detail (
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

ALTER TABLE ONLY stg.stg_po_poprq_poprcovg_detail
    ADD CONSTRAINT pkpo_poprq_poprcovg_detail PRIMARY KEY (poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_posubscheduleno, poprq_prou, poprq_prno, poprq_prlineno, poprq_pr_shdno, poprq_pr_subsceduleno, poprq_poou);

CREATE INDEX stg_po_poprq_poprcovg_detail_key_idx1 ON stg.stg_po_poprq_poprcovg_detail USING btree (poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_posubscheduleno, poprq_prou, poprq_prno, poprq_prlineno, poprq_pr_shdno, poprq_pr_subsceduleno, poprq_poou);