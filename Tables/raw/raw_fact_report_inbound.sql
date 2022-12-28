CREATE TABLE raw.raw_fact_report_inbound (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) COLLATE public.nocase,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    region character varying(100) COLLATE public.nocase,
    customercode character varying(100) COLLATE public.nocase,
    ordernumber character varying(100) COLLATE public.nocase,
    orderdate timestamp without time zone,
    asnnumber character varying(100) COLLATE public.nocase,
    asndate timestamp without time zone,
    asn_created_date timestamp without time zone,
    asn_modified_date timestamp without time zone,
    ordertype character varying(30) COLLATE public.nocase,
    asntype character varying(30) COLLATE public.nocase,
    invoiceno character varying(100) COLLATE public.nocase,
    invoicedate timestamp without time zone,
    asn_status character varying(10) COLLATE public.nocase,
    asnlinenumber integer,
    itemcode character varying(100) COLLATE public.nocase,
    asnquantity integer,
    asn_linestatus character varying(100) COLLATE public.nocase,
    grndatetime timestamp without time zone,
    gr_ok_qty integer,
    gr_ko_qty integer,
    gr_status character varying(100) COLLATE public.nocase,
    pa_datetime timestamp without time zone,
    pa_qty integer,
    pa_status character varying(100) COLLATE public.nocase,
    expclosuredatetime timestamp without time zone,
    ontime integer,
    offtime integer,
    cutofftime time without time zone,
    processtat integer,
    openingtime time without time zone,
    closingtime time without time zone,
    type character varying(20) COLLATE public.nocase,
    locationdesc character varying(50) COLLATE public.nocase,
    samedayputaway integer,
    gr_shortqty integer,
    grtat integer,
    grexpectedclosuretime timestamp without time zone,
    patat integer,
    paexpectedclosuretime timestamp without time zone,
    grontime integer,
    grofftime integer,
    arrivedibddate timestamp without time zone,
    asn_reason_code character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_report_inbound ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_report_inbound_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_report_inbound
    ADD CONSTRAINT raw_fact_report_inbound_pkey PRIMARY KEY (raw_id);