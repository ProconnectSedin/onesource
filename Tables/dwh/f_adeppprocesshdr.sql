CREATE TABLE dwh.f_adeppprocesshdr (
    f_adeppprocesshdr_key bigint NOT NULL,
    ou_id integer,
    depr_proc_runno character varying(40) COLLATE public.nocase,
    depr_book character varying(40) COLLATE public.nocase,
    a_timestamp integer,
    process_status character varying(50) COLLATE public.nocase,
    process_date timestamp without time zone,
    fb_id character varying(40) COLLATE public.nocase,
    num_type character varying(20) COLLATE public.nocase,
    incl_rev character varying(80) COLLATE public.nocase,
    currency character varying(10) COLLATE public.nocase,
    pcost_center character varying(20) COLLATE public.nocase,
    fin_year character varying(20) COLLATE public.nocase,
    fp_upto character varying(20) COLLATE public.nocase,
    fp_start_date timestamp without time zone,
    fp_end_date timestamp without time zone,
    depr_basis character varying(80) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    depr_category character varying(80) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    assets_selected character varying(40) COLLATE public.nocase,
    tag_selected character varying(40) COLLATE public.nocase,
    rec_selected character varying(40) COLLATE public.nocase,
    susp_total numeric(25,2),
    depr_total numeric(25,2),
    rev_depr_total numeric(25,2),
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    fystartdate timestamp without time zone,
    fyenddate timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_adeppprocesshdr ALTER COLUMN f_adeppprocesshdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_adeppprocesshdr_f_adeppprocesshdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_adeppprocesshdr
    ADD CONSTRAINT f_adeppprocesshdr_pkey PRIMARY KEY (f_adeppprocesshdr_key);

ALTER TABLE ONLY dwh.f_adeppprocesshdr
    ADD CONSTRAINT f_adeppprocesshdr_ukey UNIQUE (ou_id, depr_proc_runno, depr_book);

CREATE INDEX f_adeppprocesshdr_key_idx ON dwh.f_adeppprocesshdr USING btree (ou_id, depr_proc_runno, depr_book);