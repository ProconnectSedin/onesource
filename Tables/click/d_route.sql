CREATE TABLE click.d_route (
    rou_key bigint NOT NULL,
    rou_route_id character varying(40) COLLATE public.nocase,
    rou_ou integer,
    rou_description character varying(510) COLLATE public.nocase,
    rou_status character varying(20) COLLATE public.nocase,
    rou_rsn_code character varying(80) COLLATE public.nocase,
    rou_trans_mode character varying(80) COLLATE public.nocase,
    rou_serv_type character varying(510) COLLATE public.nocase,
    rou_sub_serv_type character varying(80) COLLATE public.nocase,
    rou_valid_frm timestamp without time zone,
    rou_valid_to timestamp without time zone,
    rou_created_by character varying(60) COLLATE public.nocase,
    rou_created_date timestamp without time zone,
    rou_modified_by character varying(60) COLLATE public.nocase,
    rou_modified_date timestamp without time zone,
    rou_timestamp integer,
    rou_route_type character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_route
    ADD CONSTRAINT d_route_pkey PRIMARY KEY (rou_key);

ALTER TABLE ONLY click.d_route
    ADD CONSTRAINT d_route_ukey UNIQUE (rou_route_id, rou_ou);