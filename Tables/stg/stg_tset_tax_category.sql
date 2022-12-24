CREATE TABLE stg.stg_tset_tax_category (
    tax_community character varying(100) NOT NULL COLLATE public.nocase,
    tax_type character varying(100) NOT NULL COLLATE public.nocase,
    company_code character varying(40) NOT NULL COLLATE public.nocase,
    tax_category character varying(160) NOT NULL COLLATE public.nocase,
    tax_category_desc character varying(400) NOT NULL COLLATE public.nocase,
    calc_tax character varying(32) COLLATE public.nocase,
    trade_type character varying(32) NOT NULL COLLATE public.nocase,
    status character(8) COLLATE public.nocase,
    predefined_type character varying(32) NOT NULL COLLATE public.nocase,
    created_at integer NOT NULL,
    created_by character varying(120) NOT NULL COLLATE public.nocase,
    created_date timestamp without time zone NOT NULL,
    modified_by character varying(120) COLLATE public.nocase,
    modified_date timestamp without time zone,
    tax_category_type character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);