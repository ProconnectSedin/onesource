CREATE TABLE click.d_vehiclereginfo (
    veh_rifo_key bigint NOT NULL,
    veh_ou integer,
    veh_id character varying(60) COLLATE public.nocase,
    veh_line_no integer,
    veh_address character varying(510) COLLATE public.nocase,
    veh_title_holder_name character varying(80) COLLATE public.nocase,
    veh_issuing_auth character varying(80) COLLATE public.nocase,
    veh_issuing_location character varying(20) COLLATE public.nocase,
    veh_issuing_date timestamp without time zone,
    veh_exp_date timestamp without time zone,
    veh_remarks character varying(2000) COLLATE public.nocase,
    veh_doc_type character varying(80) COLLATE public.nocase,
    veh_doc_no character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_pkey PRIMARY KEY (veh_rifo_key);

ALTER TABLE ONLY click.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_ukey UNIQUE (veh_ou, veh_id, veh_line_no);