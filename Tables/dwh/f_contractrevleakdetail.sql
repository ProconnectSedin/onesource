CREATE TABLE dwh.f_contractrevleakdetail (
    cont_rev_key bigint NOT NULL,
    cont_rev_lkge_contid character varying(40) COLLATE public.nocase,
    cont_rev_lkge_ou integer,
    cont_rev_lkge_line_no integer,
    cont_rev_lkge_doc_type character varying(510) COLLATE public.nocase,
    cont_rev_lkge_doc_no character varying(40) COLLATE public.nocase,
    cont_rev_lkge_cust_id character varying(40) COLLATE public.nocase,
    cont_rev_lkge_revenue numeric(13,0),
    cont_rev_lkge_created_by character varying(60) COLLATE public.nocase,
    cont_rev_lkge_created_date timestamp without time zone,
    cont_rev_lkge_modified_by character varying(60) COLLATE public.nocase,
    cont_rev_lkge_modified_date timestamp without time zone,
    cont_rev_lkge_timestamp integer,
    cont_rev_lkge_flag character varying(30) COLLATE public.nocase,
    cont_rev_lkge_triggering_no character varying(40) COLLATE public.nocase,
    cont_rev_lkge_triggering_type character varying(20) COLLATE public.nocase,
    cont_rev_lkge_tariffid character varying(40) COLLATE public.nocase,
    cont_rev_lkge_triggering_date timestamp without time zone,
    cont_rev_lkge_doc_date timestamp without time zone,
    cont_rev_lkge_location character varying(20) COLLATE public.nocase,
    cont_rev_lkge_supplier character varying(40) COLLATE public.nocase,
    cont_rev_lkge_remarks character varying(510) COLLATE public.nocase,
    cont_rev_lkge_revenue_leakage timestamp without time zone,
    cont_rev_lkge_tariff_type character varying(80) COLLATE public.nocase,
    cont_rev_lkge_booking_location character varying(20) COLLATE public.nocase,
    cont_rev_lkge_reason character varying(8000) COLLATE public.nocase,
    cont_rev_lkge_total_amount numeric(13,2),
    cont_rev_lkge_group_flag character varying(20) COLLATE public.nocase,
    cont_rev_lkge_resource_type character varying(510) COLLATE public.nocase,
    cont_rev_lkge_billable character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_contractrevleakdetail ALTER COLUMN cont_rev_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_contractrevleakdetail_cont_rev_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_contractrevleakdetail
    ADD CONSTRAINT f_contractrevleakdetail_pkey PRIMARY KEY (cont_rev_key);

ALTER TABLE ONLY dwh.f_contractrevleakdetail
    ADD CONSTRAINT f_contractrevleakdetail_ukey UNIQUE (cont_rev_lkge_ou, cont_rev_lkge_line_no);

CREATE INDEX f_contractrevleakdetail_key_idx ON dwh.f_contractrevleakdetail USING btree (cont_rev_lkge_ou, cont_rev_lkge_line_no);