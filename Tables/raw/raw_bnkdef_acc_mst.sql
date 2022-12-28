CREATE TABLE raw.raw_bnkdef_acc_mst (
    raw_id bigint NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    bank_ref_no character varying(80) NOT NULL COLLATE public.nocase,
    bank_acc_no character varying(80) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    btimestamp integer,
    flag character varying(4) COLLATE public.nocase,
    currency_code character varying(20) COLLATE public.nocase,
    credit_limit numeric,
    draw_limit numeric,
    status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    creation_ou integer,
    modification_ou integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    iban character varying(160) COLLATE public.nocase,
    bsrno character varying(80) COLLATE public.nocase,
    micrcode character varying(84) COLLATE public.nocase,
    acctrf character varying(12) DEFAULT '0'::character varying NOT NULL COLLATE public.nocase,
    neft character varying(12) DEFAULT '0'::character varying NOT NULL COLLATE public.nocase,
    rtgs character varying(12) DEFAULT '0'::character varying NOT NULL COLLATE public.nocase,
    restpostingaftrrecon character varying(48) COLLATE public.nocase,
    echeq character varying(12) DEFAULT '0'::character varying NOT NULL COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_bnkdef_acc_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_bnkdef_acc_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_bnkdef_acc_mst
    ADD CONSTRAINT raw_bnkdef_acc_mst_pkey PRIMARY KEY (raw_id);