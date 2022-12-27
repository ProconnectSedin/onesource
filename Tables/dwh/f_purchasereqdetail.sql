CREATE TABLE dwh.f_purchasereqdetail (
    preqm_dtl_key bigint NOT NULL,
    preqm_hr_key bigint NOT NULL,
    preqm_dtl_loc_key bigint NOT NULL,
    preqm_dtl_customer_key bigint NOT NULL,
    preqm_dtl_vendor_key bigint NOT NULL,
    preqm_dtl_wh_key bigint NOT NULL,
    preqm_dtl_uom_key bigint NOT NULL,
    prqit_prou integer,
    prqit_prno character varying(40) COLLATE public.nocase,
    prqit_lineno integer,
    prqit_itemcode character varying(80) COLLATE public.nocase,
    prqit_variant character varying(20) COLLATE public.nocase,
    prqit_itemdescription character varying(1500) COLLATE public.nocase,
    prqit_reqdqty numeric(20,2),
    prqit_puom character varying(20) COLLATE public.nocase,
    prqit_cost numeric(20,2),
    prqit_costper numeric(20,2),
    prqit_needdate timestamp without time zone,
    prqit_pr_del_type character varying(20) COLLATE public.nocase,
    prqit_warehousecode character varying(20) COLLATE public.nocase,
    prqit_prposalid character varying(40) COLLATE public.nocase,
    prqit_authqty numeric(20,2),
    prqit_customercode character varying(40) COLLATE public.nocase,
    prqit_balqty numeric(20,2),
    prqit_prlinestatus character varying(20) COLLATE public.nocase,
    prqit_supplier_code character varying(40) COLLATE public.nocase,
    prqit_pref_supplier_code character varying(40) COLLATE public.nocase,
    prqit_referencetype character varying(20) COLLATE public.nocase,
    prqit_ref_doc character varying(150) COLLATE public.nocase,
    prqit_refdoclineno integer,
    prqit_adhocitemclass character varying(50) COLLATE public.nocase,
    prqit_attrvalue character varying(20) COLLATE public.nocase,
    prqit_createdby character varying(60) COLLATE public.nocase,
    prqit_createddate timestamp without time zone,
    prqit_lastmodifiedby character varying(60) COLLATE public.nocase,
    prqit_lastmodifieddate timestamp without time zone,
    prqit_availableqty numeric(20,2),
    prqit_location character varying(60) COLLATE public.nocase,
    prqit_comments character varying(2000) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_purchasereqdetail ALTER COLUMN preqm_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_purchasereqdetail_preqm_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_pkey PRIMARY KEY (preqm_dtl_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_ukey UNIQUE (prqit_prou, prqit_prno, prqit_lineno);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_customer_key_fkey FOREIGN KEY (preqm_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_loc_key_fkey FOREIGN KEY (preqm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_uom_key_fkey FOREIGN KEY (preqm_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_vendor_key_fkey FOREIGN KEY (preqm_dtl_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_wh_key_fkey FOREIGN KEY (preqm_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_hr_key_fkey FOREIGN KEY (preqm_hr_key) REFERENCES dwh.f_purchasereqheader(preqm_hr_key);

CREATE INDEX f_purchasereqdetail_key_idx ON dwh.f_purchasereqdetail USING btree (preqm_hr_key, preqm_dtl_wh_key, preqm_dtl_uom_key, preqm_dtl_vendor_key, preqm_dtl_loc_key, preqm_dtl_customer_key);

CREATE INDEX f_purchasereqdetail_key_idx1 ON dwh.f_purchasereqdetail USING btree (prqit_prou, prqit_prno, prqit_lineno);