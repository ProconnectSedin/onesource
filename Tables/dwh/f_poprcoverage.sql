CREATE TABLE dwh.f_poprcoverage (
    poprq_covg_dtl_key bigint NOT NULL,
    poprq_poou integer,
    poprq_pono character varying(40) COLLATE public.nocase,
    poprq_poamendmentno integer,
    poprq_polineno integer,
    poprq_scheduleno integer,
    poprq_prno character varying(40) COLLATE public.nocase,
    poprq_posubscheduleno integer,
    poprq_prlineno integer,
    poprq_prou integer,
    poprq_pr_shdno integer,
    poprq_pocovqty numeric(20,2),
    poprq_createdby character varying(60) COLLATE public.nocase,
    poprq_pr_subsceduleno integer,
    poprq_createddate timestamp without time zone,
    poprq_lastmodifiedby character varying(60) COLLATE public.nocase,
    poprq_grrecvdqty numeric(20,2),
    poprq_lastmodifieddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_poprcoverage ALTER COLUMN poprq_covg_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_poprcoverage_poprq_covg_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_poprcoverage
    ADD CONSTRAINT f_poprcoverage_pkey PRIMARY KEY (poprq_covg_dtl_key);

ALTER TABLE ONLY dwh.f_poprcoverage
    ADD CONSTRAINT f_poprcoverage_ukey UNIQUE (poprq_poou, poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_prno, poprq_posubscheduleno, poprq_prlineno, poprq_prou, poprq_pr_shdno, poprq_pr_subsceduleno);

CREATE INDEX f_poprcoverage_key_idx1 ON dwh.f_poprcoverage USING btree (poprq_poou, poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_prno, poprq_posubscheduleno, poprq_prlineno, poprq_prou, poprq_pr_shdno, poprq_pr_subsceduleno);