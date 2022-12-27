CREATE TABLE raw.raw_emod_company_mst (
    raw_id bigint NOT NULL,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    serial_no integer NOT NULL,
    ctimestamp integer,
    company_name character varying(240) COLLATE public.nocase,
    address1 character varying(160) COLLATE public.nocase,
    address2 character varying(160) COLLATE public.nocase,
    address3 character varying(160) COLLATE public.nocase,
    city character varying(160) COLLATE public.nocase,
    country character varying(160) COLLATE public.nocase,
    zip_code character varying(80) COLLATE public.nocase,
    phone_no character varying(72) COLLATE public.nocase,
    state character varying(160) COLLATE public.nocase,
    company_url character varying(200) COLLATE public.nocase,
    mail_stop character varying(240) COLLATE public.nocase,
    telex character varying(80) COLLATE public.nocase,
    par_comp_code character varying(40) COLLATE public.nocase,
    fax_no character varying(160) COLLATE public.nocase,
    base_currency character varying(20) COLLATE public.nocase,
    parcur_cr_date timestamp without time zone,
    parcur_dl_date timestamp without time zone,
    status character varying(100) COLLATE public.nocase,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    para_base_flag character varying(4) COLLATE public.nocase,
    reg_date timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    company_id character varying(160) COLLATE public.nocase,
    latitude numeric,
    longitude numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_emod_company_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_emod_company_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_emod_company_mst
    ADD CONSTRAINT raw_emod_company_mst_pkey PRIMARY KEY (raw_id);