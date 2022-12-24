CREATE TABLE dwh.d_equipmentgroup (
    egrp_key bigint NOT NULL,
    egrp_ou integer,
    egrp_id character varying(40) COLLATE public.nocase,
    egrp_desc character varying(510) COLLATE public.nocase,
    egrp_status character varying(510) COLLATE public.nocase,
    egrp_created_by character varying(60) COLLATE public.nocase,
    egrp_created_date timestamp without time zone,
    egrp_modified_by character varying(60) COLLATE public.nocase,
    egrp_modified_date timestamp without time zone,
    egrp_timestamp integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);