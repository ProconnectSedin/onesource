CREATE TABLE click.d_itemsuppliermap (
    itm_supp_key bigint NOT NULL,
    itm_ou integer,
    itm_code character varying(80) COLLATE public.nocase,
    itm_lineno integer,
    itm_supp_code character varying(40) COLLATE public.nocase,
    item_source character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_pkey PRIMARY KEY (itm_supp_key);

ALTER TABLE ONLY click.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_ukey UNIQUE (itm_ou, itm_code, itm_lineno);