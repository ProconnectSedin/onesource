CREATE TABLE stg.stg_emod_addr_mst (
    address_id character varying(160) NOT NULL COLLATE public.nocase,
    atimestamp integer,
    address1 character varying(160) COLLATE public.nocase,
    address2 character varying(160) COLLATE public.nocase,
    address3 character varying(160) COLLATE public.nocase,
    address_desc character varying(400) COLLATE public.nocase,
    city character varying(160) COLLATE public.nocase,
    state character varying(160) COLLATE public.nocase,
    country character varying(160) COLLATE public.nocase,
    phone_no character varying(72) COLLATE public.nocase,
    fax character varying(160) COLLATE public.nocase,
    telex character varying(80) COLLATE public.nocase,
    url character varying(200) COLLATE public.nocase,
    mail_stop character varying(240) COLLATE public.nocase,
    zip_code character varying(80) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    state_code integer,
    email_id character varying(240) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_emod_addr_mst
    ADD CONSTRAINT emod_addr_mst_pkey PRIMARY KEY (address_id);