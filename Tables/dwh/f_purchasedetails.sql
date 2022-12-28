CREATE TABLE dwh.f_purchasedetails (
    po_dtl_key bigint NOT NULL,
    po_hr_key bigint NOT NULL,
    po_dtl_uom_key bigint NOT NULL,
    po_dtl_wh_key bigint NOT NULL,
    po_dtl_cust_key bigint NOT NULL,
    po_dtl_loc_key bigint NOT NULL,
    poou integer,
    pono character varying(40) COLLATE public.nocase,
    poamendmentno integer,
    polineno integer,
    itemcode character varying(80) COLLATE public.nocase,
    variant character varying(20) COLLATE public.nocase,
    order_quantity numeric(20,2),
    pobalancequantity numeric(20,2),
    puom character varying(20) COLLATE public.nocase,
    po_cost numeric(20,2),
    costper numeric(20,2),
    shiptoou integer,
    tcdtotalamount numeric(20,2),
    warehousecode character varying(20) COLLATE public.nocase,
    itemvalue numeric(20,2),
    polinestatus character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    lastmodifiedby character varying(60) COLLATE public.nocase,
    lastmodifieddate timestamp without time zone,
    itemdescription character varying(1500) COLLATE public.nocase,
    schedtype character varying(20) COLLATE public.nocase,
    needdate timestamp without time zone,
    accunit character varying(40) COLLATE public.nocase,
    adhocitemclass character varying(40) COLLATE public.nocase,
    refdocno character varying(40) COLLATE public.nocase,
    refdoclineno integer,
    comments character varying(2000) COLLATE public.nocase,
    customercode character varying(40) COLLATE public.nocase,
    proposalid character varying(40) COLLATE public.nocase,
    attrvalue character varying(20) COLLATE public.nocase,
    grrecdqty numeric(20,2),
    graccpdqty numeric(20,2),
    grmovdqty numeric(20,2),
    matched_qty numeric(20,2),
    matched_amt numeric(20,2),
    billed_qty numeric(20,2),
    billed_amt numeric(20,2),
    adhocplng character varying(20) COLLATE public.nocase,
    location character varying(40) COLLATE public.nocase,
    availableqty numeric(20,2),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_purchasedetails ALTER COLUMN po_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_purchasedetails_po_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_pkey PRIMARY KEY (po_dtl_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_ukey UNIQUE (poou, pono, poamendmentno, polineno);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_cust_key_fkey FOREIGN KEY (po_dtl_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_loc_key_fkey FOREIGN KEY (po_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_uom_key_fkey FOREIGN KEY (po_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_wh_key_fkey FOREIGN KEY (po_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_hr_key_fkey FOREIGN KEY (po_hr_key) REFERENCES dwh.f_purchaseheader(po_hr_key);

CREATE INDEX f_purchasedetails_key_idx ON dwh.f_purchasedetails USING btree (po_hr_key, po_dtl_cust_key, po_dtl_loc_key, po_dtl_wh_key, po_dtl_uom_key);

CREATE INDEX f_purchasedetails_key_idx1 ON dwh.f_purchasedetails USING btree (poou, pono, poamendmentno, polineno);