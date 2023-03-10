CREATE TABLE raw.raw_emod_bank_ref_mst (
    raw_id bigint NOT NULL,
    bank_ref_no character varying(80) NOT NULL COLLATE public.nocase,
    bank_status character varying(8) NOT NULL COLLATE public.nocase,
    btimestamp integer,
    bank_ptt_flag character varying(4) COLLATE public.nocase,
    bank_type character varying(100) COLLATE public.nocase,
    bank_name character varying(160) COLLATE public.nocase,
    address1 character varying(160) COLLATE public.nocase,
    address2 character varying(160) COLLATE public.nocase,
    address3 character varying(160) COLLATE public.nocase,
    city character varying(160) COLLATE public.nocase,
    state character varying(160) COLLATE public.nocase,
    country character varying(160) COLLATE public.nocase,
    clearing_no character varying(80) COLLATE public.nocase,
    swift_no character varying(80) COLLATE public.nocase,
    phone_no character varying(80) COLLATE public.nocase,
    telex character varying(80) COLLATE public.nocase,
    mail_stop character varying(240) COLLATE public.nocase,
    zip_code character varying(160) COLLATE public.nocase,
    fax character varying(160) COLLATE public.nocase,
    email_id character varying(240) COLLATE public.nocase,
    creation_ou integer,
    modification_ou integer,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    bsrno character varying(80) COLLATE public.nocase,
    createdin character varying(120) COLLATE public.nocase,
    escrowaccount character(20) COLLATE public.nocase,
    ifsccode character varying(80) COLLATE public.nocase,
    long_description character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_emod_bank_ref_mst ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_emod_bank_ref_mst_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_emod_bank_ref_mst
    ADD CONSTRAINT raw_emod_bank_ref_mst_pkey PRIMARY KEY (raw_id);