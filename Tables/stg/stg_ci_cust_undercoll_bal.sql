-- Table: stg.stg_ci_cust_undercoll_bal

-- DROP TABLE IF EXISTS stg.stg_ci_cust_undercoll_bal;

CREATE TABLE IF NOT EXISTS stg.stg_ci_cust_undercoll_bal
(
    lo_id character varying(80) COLLATE public.nocase,
    bu_id character varying(80) COLLATE public.nocase,
    ou_id integer,
    fb_id character varying(80) COLLATE public.nocase,
    company_code character varying(40) COLLATE public.nocase,
    cust_code character varying(72) COLLATE public.nocase,
    base_currency_code character varying(20) COLLATE public.nocase,
    balance_type character varying(20) COLLATE public.nocase,
    par_currency_code character varying(20) COLLATE public.nocase,
    "timestamp" integer,
    deposit_amount numeric,
    realized_amount numeric,
    undercoll_amount numeric,
    par_deposit_amount numeric,
    par_undercoll_amount numeric,
    par_realized_amount numeric,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_ci_cust_undercoll_bal
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS stg_ci_cust_undercoll_bal_idx
    ON stg.stg_ci_cust_undercoll_bal USING btree
	(lo_id, bu_id, ou_id, fb_id, company_code, cust_code);
	
CREATE INDEX IF NOT EXISTS stg_ci_cust_undercoll_bal_idx1
    ON stg.stg_ci_cust_undercoll_bal USING btree
	(cust_code, ou_id);
	
CREATE INDEX IF NOT EXISTS stg_ci_cust_undercoll_bal_idx2
    ON stg.stg_ci_cust_undercoll_bal USING btree 
	(company_code);
	
CREATE INDEX IF NOT EXISTS stg_ci_cust_undercoll_bal_idx3
    ON stg.stg_ci_cust_undercoll_bal USING btree 
	(base_currency_code);


