CREATE TABLE click.d_opscomponentlookup (
    comp_lkp_key bigint NOT NULL,
    componentname character varying(60) COLLATE public.nocase,
    paramcategory character varying(20) COLLATE public.nocase,
    paramtype character varying(60) COLLATE public.nocase,
    paramcode character varying(20) COLLATE public.nocase,
    optionvalue character varying(20) COLLATE public.nocase,
    sequenceno integer,
    paramdesc character varying(500) COLLATE public.nocase,
    paramdesc_shd character varying(500) COLLATE public.nocase,
    langid integer,
    cml_len integer,
    cml_translate character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_opscomponentlookup
    ADD CONSTRAINT d_opscomponentlookup_pkey PRIMARY KEY (comp_lkp_key);