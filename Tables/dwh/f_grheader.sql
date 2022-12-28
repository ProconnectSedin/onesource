CREATE TABLE dwh.f_grheader (
    gr_hdr_key bigint NOT NULL,
    gr_date_key bigint NOT NULL,
    gr_emp_hdr_key bigint NOT NULL,
    gr_vendor_key bigint NOT NULL,
    gr_curr_key bigint NOT NULL,
    ouinstid integer,
    grno character varying(40) COLLATE public.nocase,
    grdate timestamp without time zone,
    grstatus character varying(10) COLLATE public.nocase,
    numseries character varying(20) COLLATE public.nocase,
    grfolder character varying(20) COLLATE public.nocase,
    grtype character varying(20) COLLATE public.nocase,
    gatepassno character varying(40) COLLATE public.nocase,
    gatepassdate timestamp without time zone,
    noofitems integer,
    delynoteno character varying(40) COLLATE public.nocase,
    delynotedate timestamp without time zone,
    empcode character varying(40) COLLATE public.nocase,
    orderdoc character varying(20) COLLATE public.nocase,
    orderou integer,
    orderno character varying(40) COLLATE public.nocase,
    orderamendno integer,
    orderdate timestamp without time zone,
    orderapprdate timestamp without time zone,
    orderfolder character varying(20) COLLATE public.nocase,
    contperson character varying(120) COLLATE public.nocase,
    refdoclineno integer,
    suppcode character varying(40) COLLATE public.nocase,
    shipfromid character varying(20) COLLATE public.nocase,
    autoinvoice character varying(20) COLLATE public.nocase,
    invoiceat integer,
    pay2sypplier character varying(40) COLLATE public.nocase,
    invbeforegr character varying(20) COLLATE public.nocase,
    docvalue numeric(20,2),
    addlcharges numeric(20,2),
    tcdtotalvalue numeric(20,2),
    totalvalue numeric(20,2),
    exchrate numeric(20,2),
    currency character varying(20) COLLATE public.nocase,
    frdate timestamp without time zone,
    fadate timestamp without time zone,
    fmdate timestamp without time zone,
    vatincl character varying(20) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createdate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    grtimestamp integer,
    remarks character varying(200) COLLATE public.nocase,
    tcal_status character varying(40) COLLATE public.nocase,
    total_tcal_amount numeric(20,2),
    tot_excludingtcal_amount numeric(20,2),
    lr_no character varying(150) COLLATE public.nocase,
    lr_date timestamp without time zone,
    revdate timestamp without time zone,
    revremrks character varying(510) COLLATE public.nocase,
    revres_cd character varying(20) COLLATE public.nocase,
    revres_dsc character varying(510) COLLATE public.nocase,
    suppinvno character varying(200) COLLATE public.nocase,
    suppinvdate timestamp without time zone,
    party_tax_region character varying(20) COLLATE public.nocase,
    party_regd_no character varying(80) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_grheader ALTER COLUMN gr_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_grheader_gr_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_pkey PRIMARY KEY (gr_hdr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_ukey UNIQUE (ouinstid, grno);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_cur_key_fkey FOREIGN KEY (gr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_emp_hdr_key_fkey FOREIGN KEY (gr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_vendor_key_fkey FOREIGN KEY (gr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

CREATE INDEX f_grheader_key_idx ON dwh.f_grheader USING btree (gr_date_key, gr_emp_hdr_key, gr_vendor_key, gr_curr_key);