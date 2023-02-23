-- Table: stg.stg_pt_payterm_details

-- DROP TABLE IF EXISTS stg.stg_pt_payterm_details;

CREATE TABLE IF NOT EXISTS stg.stg_pt_payterm_details
(
    pt_ouinstance integer NOT NULL,
    pt_paytermcode character varying(72) COLLATE public.nocase NOT NULL,
    pt_version_no integer NOT NULL,
    pt_serialno integer NOT NULL,
    pt_duedays integer,
    pt_duepercentage numeric,
    pt_discountdays integer,
    pt_discountpercentage numeric,
    pt_penalty numeric,
    pt_per numeric,
    pt_timeunit character varying(32) COLLATE public.nocase,
    pt_created_by character varying(120) COLLATE public.nocase,
    pt_created_date timestamp without time zone,
    pt_modified_by character varying(120) COLLATE public.nocase,
    pt_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now(),
    CONSTRAINT pk_paytermdrl PRIMARY KEY (pt_ouinstance, pt_paytermcode, pt_version_no, pt_serialno)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS stg.stg_pt_payterm_details
    OWNER to proconnect;