-- Table: dwh.d_itmibuitemvarhdr

-- DROP TABLE IF EXISTS dwh.d_itmibuitemvarhdr;

CREATE TABLE IF NOT EXISTS dwh.d_itmibuitemvarhdr
(
    itmibuitemvarhdr_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ibu_itemcode character varying(64) COLLATE public.nocase,
    ibu_variantcode character varying(16) COLLATE public.nocase,
    ibu_bu character varying(40) COLLATE public.nocase,
    ibu_lo character varying(40) COLLATE public.nocase,
    ibu_category character varying(30) COLLATE public.nocase,
    ibu_itemtype character varying(16) COLLATE public.nocase,
    ibu_grsweight numeric(20,3),
    ibu_grsuom character varying(20) COLLATE public.nocase,
    ibu_grsvolume numeric(20,3),
    ibu_voluom character varying(20) COLLATE public.nocase,
    ibu_length numeric(20,3),
    ibu_breadth numeric(20,3),
    ibu_height numeric(20,3),
    ibu_dimenuom character varying(20) COLLATE public.nocase,
    ibu_costingmtd character varying(16) COLLATE public.nocase,
    ibu_lotnoctrl integer,
    ibu_shelflifeperiod integer,
    ibu_retestperiod integer,
    ibu_srnoctrl integer,
    ibu_planninglevel character varying(16) COLLATE public.nocase,
    ibu_created_ou integer,
    ibu_created_by character varying(60) COLLATE public.nocase,
    ibu_created_date timestamp without time zone,
    ibu_modified_by character varying(60) COLLATE public.nocase,
    ibu_modified_date timestamp without time zone,
    ibu_accountgroup character varying(40) COLLATE public.nocase,
    ibu_costingwght numeric(20,3),
    ibu_sublotctrl integer,
    ibu_defpam character varying(16) COLLATE public.nocase,
    ibu_itmmix integer,
    ibu_lotmix integer,
    ibu_mfrmix integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT d_itmibuitemvarhdr_pkey PRIMARY KEY (itmibuitemvarhdr_key),
    CONSTRAINT d_itmibuitemvarhdr_ukey UNIQUE (ibu_itemcode, ibu_variantcode, ibu_bu, ibu_lo)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.d_itmibuitemvarhdr
    OWNER to proconnect;