-- Table: stg.stg_sad_suppcustadj_hdr

-- DROP TABLE IF EXISTS stg.stg_sad_suppcustadj_hdr;

CREATE TABLE IF NOT EXISTS stg.stg_sad_suppcustadj_hdr
(
    ou_id integer NOT NULL,
    adjustment_no character varying(72) COLLATE public.nocase NOT NULL,
    trantype character varying(160) COLLATE public.nocase NOT NULL,
    adjustment_date timestamp without time zone,
    status character varying(100) COLLATE public.nocase,
    supp_code character varying(64) COLLATE public.nocase,
    supp_fbid character varying(80) COLLATE public.nocase,
    supp_currcode character varying(20) COLLATE public.nocase,
    scdn_drnote character varying(72) COLLATE public.nocase,
    supp_adj_no character varying(72) COLLATE public.nocase,
    supp_cradj_amt numeric,
    supp_cradj_disc character varying(64) COLLATE public.nocase,
    supp_cradj_totamt numeric,
    cust_code character varying(72) COLLATE public.nocase,
    cust_fbid character varying(80) COLLATE public.nocase,
    cust_currcode character varying(20) COLLATE public.nocase,
    cdcn_crnote character varying(72) COLLATE public.nocase,
    cust_adj_no character varying(72) COLLATE public.nocase,
    cust_dradj_amt numeric,
    cust_dradj_disc character varying(64) COLLATE public.nocase,
    cust_dradj_charge numeric,
    cust_dradj_rwoff numeric,
    cust_dradj_totamt numeric,
    "timestamp" integer,
    guid character varying(512) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    rev_remarks character varying(400) COLLATE public.nocase,
    reversaldate timestamp without time zone,
    revcustadjno character varying(72) COLLATE public.nocase,
    revcustnoteno character varying(72) COLLATE public.nocase,
    revsuppadjno character varying(72) COLLATE public.nocase,
    revsuppnoteno character varying(72) COLLATE public.nocase,
    suppproject_ou integer,
    suppproject_code character varying(280) COLLATE public.nocase,
    custproject_ou integer,
    custproject_code character varying(280) COLLATE public.nocase,
    batch_id character varying(512) COLLATE public.nocase,
    workflow_status character varying(80) COLLATE public.nocase,
    comments character varying(1024) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_sad_suppcustadj_hdr
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS stg_sad_suppcustadj_hdr_idx
    ON stg.stg_sad_suppcustadj_hdr USING btree
	(ou_id, adjustment_no, trantype);
CREATE INDEX IF NOT EXISTS stg_sad_suppcustadj_hdr_idx1
    ON stg.stg_sad_suppcustadj_hdr USING btree
	(supp_currcode);
CREATE INDEX IF NOT EXISTS stg_sad_suppcustadj_hdr_idx2
    ON stg.stg_sad_suppcustadj_hdr USING btree
	(supp_code, ou_id);
CREATE INDEX IF NOT EXISTS stg_sad_suppcustadj_hdr_idx3
    ON stg.stg_sad_suppcustadj_hdr USING btree
	(cust_code, ou_id);
