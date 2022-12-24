CREATE TABLE dwh.d_hht_master (
    d_hht_master_key bigint NOT NULL,
    hht_loc_key bigint NOT NULL,
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