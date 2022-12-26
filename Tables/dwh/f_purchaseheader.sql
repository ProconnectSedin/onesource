CREATE TABLE dwh.f_purchaseheader (
    po_hr_key bigint NOT NULL,
    po_loc_key bigint NOT NULL,
    po_date_key bigint NOT NULL,
    po_cur_key bigint NOT NULL,
    po_supp_key bigint NOT NULL,
    poou integer,
    pono character varying(40) COLLATE public.nocase,
    poamendmentno integer,
    podate timestamp without time zone,
    poauthdate timestamp without time zone,
    podocstatus character varying(20) COLLATE public.nocase,
    potype character varying(20) COLLATE public.nocase,
    loitoorder integer,
    loi integer,
    hold integer,
    orgsource character varying(20) COLLATE public.nocase,
    suppliercode character varying(40) COLLATE public.nocase,
    contactperson character varying(90) COLLATE public.nocase,
    pocurrency character varying(20) COLLATE public.nocase,
    exchangerate numeric(17,2),
    pobasicvalue numeric(17,2),
    tcdtotalrate numeric(17,2),
    poaddlncharge numeric(17,2),
    folder character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    holdreason character varying(20) COLLATE public.nocase,
    createddate timestamp without time zone,
    lastmodifiedby character varying(60) COLLATE public.nocase,
    lastmodifieddate timestamp without time zone,
    ptimestamp integer,
    avgvatrate numeric(17,2),
    vatinclusive character varying(20) COLLATE public.nocase,
    filename character varying(510) COLLATE public.nocase,
    tax_status character varying(20) COLLATE public.nocase,
    tcal_total_amount numeric(17,2),
    tcal_excl_amount numeric(17,2),
    qpoflag integer,
    wfstatus character varying(20) COLLATE public.nocase,
    imports character varying(20) COLLATE public.nocase,
    shipfrm character varying(40) COLLATE public.nocase,
    numseries character varying(20) COLLATE public.nocase,
    amd_srccomp character varying(20) COLLATE public.nocase,
    poamendmentdate timestamp without time zone,
    gen_from character varying(40) COLLATE public.nocase,
    location character varying(60) COLLATE public.nocase,
    poitm_location character varying(40) COLLATE public.nocase,
    contract character varying(20) COLLATE public.nocase,
    party_tax_region character varying(20) COLLATE public.nocase,
    party_regd_no character varying(80) COLLATE public.nocase,
    own_tax_region character varying(20) COLLATE public.nocase,
    mail_sent character varying(20) COLLATE public.nocase,
    auth_remarks character varying(510) COLLATE public.nocase,
    reason_return character varying(300) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);