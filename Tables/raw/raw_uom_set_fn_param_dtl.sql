CREATE TABLE raw.raw_uom_set_fn_param_dtl (
    raw_id bigint NOT NULL,
    ufnd_lo character varying(80) NOT NULL COLLATE public.nocase,
    ufnd_ou integer NOT NULL,
    ufnd_lineno integer NOT NULL,
    ufnd_entity character varying(32) COLLATE public.nocase,
    ufnd_uomcls character varying(80) COLLATE public.nocase,
    ufnd_uomcode character varying(40) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);