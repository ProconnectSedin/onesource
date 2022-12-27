CREATE TABLE click.d_hhtmaster (
    hht_master_key bigint NOT NULL,
    hht_loc_key integer,
    id integer,
    locationcode character varying(30) COLLATE public.nocase,
    locationdesc character varying(50) COLLATE public.nocase,
    brand character varying(50) COLLATE public.nocase,
    count integer,
    oldcount040220 integer,
    oldcount300920 integer,
    oldcount030321 integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE click.d_hhtmaster ALTER COLUMN hht_master_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.d_hhtmaster_hht_master_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.d_hhtmaster
    ADD CONSTRAINT d_hht_master_pkey PRIMARY KEY (hht_master_key);