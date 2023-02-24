-- Table: dwh.f_sadsuppcustadjhdr

-- DROP TABLE IF EXISTS dwh.f_sadsuppcustadjhdr;

CREATE TABLE IF NOT EXISTS dwh.f_sadsuppcustadjhdr
(
    sadsuppcustadjhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    curr_key bigint,
    vendor_key bigint,
    cust_key bigint,
    ou_id integer,
    adjustment_no character varying(40) COLLATE public.nocase,
    trantype character varying(80) COLLATE public.nocase,
    adjustment_date timestamp without time zone,
    status character varying(50) COLLATE public.nocase,
    supp_code character varying(40) COLLATE public.nocase,
    supp_fbid character varying(40) COLLATE public.nocase,
    supp_currcode character varying(10) COLLATE public.nocase,
    scdn_drnote character varying(40) COLLATE public.nocase,
    supp_adj_no character varying(40) COLLATE public.nocase,
    supp_cradj_amt numeric(25,2),
    supp_cradj_disc character varying(40) COLLATE public.nocase,
    supp_cradj_totamt numeric(25,2),
    cust_code character varying(40) COLLATE public.nocase,
    cust_fbid character varying(40) COLLATE public.nocase,
    cust_currcode character varying(10) COLLATE public.nocase,
    cdcn_crnote character varying(40) COLLATE public.nocase,
    cust_adj_no character varying(40) COLLATE public.nocase,
    cust_dradj_amt numeric(25,2),
    cust_dradj_disc character varying(40) COLLATE public.nocase,
    cust_dradj_charge numeric(25,2),
    cust_dradj_rwoff numeric(25,2),
    cust_dradj_totamt numeric(25,2),
    ctimestamp integer,
    guid character varying(260) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    rev_remarks character varying(200) COLLATE public.nocase,
    reversaldate timestamp without time zone,
    revcustadjno character varying(40) COLLATE public.nocase,
    revcustnoteno character varying(40) COLLATE public.nocase,
    revsuppadjno character varying(40) COLLATE public.nocase,
    revsuppnoteno character varying(40) COLLATE public.nocase,
    suppproject_ou integer,
    suppproject_code character varying(140) COLLATE public.nocase,
    custproject_ou integer,
    custproject_code character varying(140) COLLATE public.nocase,
    batch_id character varying(260) COLLATE public.nocase,
    workflow_status character varying(40) COLLATE public.nocase,
    comments character varying(512) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_sadsuppcustadjhdr_pkey PRIMARY KEY (sadsuppcustadjhdr_key),
    CONSTRAINT f_sadsuppcustadjhdr_ukey UNIQUE (ou_id, adjustment_no, trantype)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_sadsuppcustadjhdr
    OWNER to proconnect;
-- Index: f_sadsuppcustadjhdr_key_idx

-- DROP INDEX IF EXISTS dwh.f_sadsuppcustadjhdr_key_idx;

CREATE INDEX IF NOT EXISTS f_sadsuppcustadjhdr_key_idx
    ON dwh.f_sadsuppcustadjhdr USING btree
    (ou_id ASC NULLS LAST, adjustment_no COLLATE public.nocase ASC NULLS LAST, trantype COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;