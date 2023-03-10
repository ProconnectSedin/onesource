CREATE TABLE stg.stg_dim_maintain_dtls (
    managed_at character varying(480) COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    dim_name character varying(480) NOT NULL COLLATE public.nocase,
    dim_long_desc character varying(1020) COLLATE public.nocase,
    dim_type character varying(100) COLLATE public.nocase,
    dim_link_sys_entity character varying(480) COLLATE public.nocase,
    user_input character varying(48) COLLATE public.nocase,
    dim_seq integer NOT NULL,
    dim_val_at character varying(100) COLLATE public.nocase,
    dim_attribute_flag character varying(48) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    effective_from timestamp without time zone,
    effective_to timestamp without time zone,
    dim_status character varying(100) COLLATE public.nocase,
    org_type character varying(100) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_dim_maintain_dtls
    ADD CONSTRAINT pk__dim_main__8dedaafb7dd35e4a PRIMARY KEY (company_code, dim_name);