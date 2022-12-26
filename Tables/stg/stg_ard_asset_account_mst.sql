CREATE TABLE stg.stg_ard_asset_account_mst (
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    fb_id character varying(80) NOT NULL COLLATE public.nocase,
    asset_class character varying(80) NOT NULL COLLATE public.nocase,
    asset_usage character varying(80) NOT NULL COLLATE public.nocase,
    effective_from timestamp without time zone NOT NULL,
    sequence_no integer NOT NULL,
    "timestamp" integer NOT NULL,
    account_code character varying(128) COLLATE public.nocase,
    effective_to timestamp without time zone,
    resou_id integer,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);