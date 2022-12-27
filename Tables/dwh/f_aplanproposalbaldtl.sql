CREATE TABLE dwh.f_aplanproposalbaldtl (
    pln_pro_dtl_key bigint NOT NULL,
    "timestamp" integer,
    ou_id integer,
    proposal_number character varying(40) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    proposal_amount numeric(13,2),
    balance_amount numeric(13,2),
    committed_amount numeric(13,2),
    liability_amount numeric(13,2),
    utilized_amount numeric(13,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    rpt_flag character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);