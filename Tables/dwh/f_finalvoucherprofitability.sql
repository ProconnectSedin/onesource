-- Table: dwh.f_finalvoucherprofitability

-- DROP TABLE IF EXISTS dwh.f_finalvoucherprofitability;

CREATE TABLE IF NOT EXISTS dwh.f_finalvoucherprofitability
(
    finalvoucherprofitability_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    company_key bigint,
    loc_key bigint,
    customer_key bigint,
    opcoa_key bigint,
    sno integer,
    companycode character varying(150) COLLATE public.nocase,
    companyname character varying(150) COLLATE public.nocase,
    tranou integer,
    tranouname character varying(150) COLLATE public.nocase,
    financialyear character varying(150) COLLATE public.nocase,
    financialperiod character varying(150) COLLATE public.nocase,
    locationcustomercode character varying(150) COLLATE public.nocase,
    locationcode character varying(150) COLLATE public.nocase,
    locationname character varying(150) COLLATE public.nocase,
    customercode character varying(150) COLLATE public.nocase,
    customername character varying(150) COLLATE public.nocase,
    customertype character varying(150) COLLATE public.nocase,
    customernamegroup character varying(150) COLLATE public.nocase,
    customerbusinesstype character varying(150) COLLATE public.nocase,
    pcsbusinesstype character varying(150) COLLATE public.nocase,
    operationregionname character varying(150) COLLATE public.nocase,
    salesregionname character varying(150) COLLATE public.nocase,
    spacesqft numeric(23,2),
    warehouseclass character varying(150) COLLATE public.nocase,
    locationcity character varying(150) COLLATE public.nocase,
    locationstate character varying(150) COLLATE public.nocase,
    citytype character varying(150) COLLATE public.nocase,
    level1 character varying(150) COLLATE public.nocase,
    level2 character varying(150) COLLATE public.nocase,
    level3 character varying(150) COLLATE public.nocase,
    erpcostcentercode character varying(150) COLLATE public.nocase,
    erpcostcenterdesc character varying(150) COLLATE public.nocase,
    billingtype character varying(150) COLLATE public.nocase,
    transtype character varying(150) COLLATE public.nocase,
    revenuenormal numeric(23,2),
    revenueecom numeric(23,2),
    revenuecorporate numeric(23,2),
    revenuemanagement numeric(23,2),
    directexpensesnormal numeric(23,2),
    directexpensesecom numeric(23,2),
    expenses9999 numeric(23,2),
    expenses8888 numeric(23,2),
    oprnexpensesnorthidn numeric(23,2),
    oprnexpenseseastidn numeric(23,2),
    oprnexpenseswestidn numeric(23,2),
    oprnexpensessouthidn numeric(23,2),
    oprnexpensesnorthide numeric(23,2),
    oprnexpenseseastide numeric(23,2),
    oprnexpenseswestide numeric(23,2),
    oprnexpensessouthide numeric(23,2),
    rdexpenses numeric(23,2),
    bdexpensesnorth numeric(23,2),
    bdexpenseseast numeric(23,2),
    bdexpenseswest numeric(23,2),
    bdexpensessouth numeric(23,2),
    corporateexpenses numeric(23,2),
    transexpenses numeric(23,2),
    managementexpenses numeric(23,2),
    unallocatedexpenses numeric(23,2),
    is_published integer,
    locationcode_v character varying(200) COLLATE public.nocase,
    customercode_v character varying(200) COLLATE public.nocase,
    financialperiod_v character varying(10) COLLATE public.nocase,
    transtype_v character varying(8) COLLATE public.nocase,
    tranou_v character varying(12) COLLATE public.nocase,
    level_1_v character varying(150) COLLATE public.nocase,
    level_2_v character varying(150) COLLATE public.nocase,
    level_3_v character varying(150) COLLATE public.nocase,
    costcenter_v character varying(50) COLLATE public.nocase,
    documentno character varying(50) COLLATE public.nocase,
    documentdate date,
    accountcode integer,
    accountdesc character varying(150) COLLATE public.nocase,
    baseamount numeric(23,2),
    allocatedamount numeric(23,2),
    row_num bigint,
    row_num_1 bigint,
    row_num_2 bigint,
    row_num_3 bigint,
    row_num_4 bigint,
    row_num_5 bigint,
    row_num_6 bigint,
    row_num_7 bigint,
    row_num_8 bigint,
    row_num_9 bigint,
    row_num_10 bigint,
    row_num_11 bigint,
    row_num_12 bigint,
    row_num_13 bigint,
    row_num_14 bigint,
    row_num_15 bigint,
    row_num_16 bigint,
    row_num_17 bigint,
    row_num_18 bigint,
    row_num_19 bigint,
    row_num_20 bigint,
    row_num_21 bigint,
    row_num_22 bigint,
    row_num_23 bigint,
    row_num_24 bigint,
    row_num_25 bigint,
    service_type character varying(100) COLLATE public.nocase,
    billingtype_updated character varying(500) COLLATE public.nocase,
    customer_creation_month character varying(30) COLLATE public.nocase,
    customer_creation_year character varying(50) COLLATE public.nocase,
    customer_name_group character varying(50) COLLATE public.nocase,
    salesregion character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT final_voucher_profitability_pkey PRIMARY KEY (finalvoucherprofitability_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_finalvoucherprofitability
    OWNER to proconnect;
-- Index: f_finalvoucherprofitability_idx

-- DROP INDEX IF EXISTS dwh.f_finalvoucherprofitability_idx;

CREATE INDEX IF NOT EXISTS f_finalvoucherprofitability_idx
    ON dwh.f_finalvoucherprofitability USING btree
    ("right"(financialperiod::text, 2) COLLATE public.nocase ASC NULLS LAST)
    TABLESPACE pg_default;