CREATE TABLE click.d_equipment (
    eqp_key bigint NOT NULL,
    eqp_ou integer,
    eqp_equipment_id character varying(60) COLLATE public.nocase,
    eqp_description character varying(510) COLLATE public.nocase,
    eqp_status character varying(20) COLLATE public.nocase,
    eqp_type character varying(80) COLLATE public.nocase,
    eqp_hazardous_goods integer,
    eqp_owner_type character varying(20) COLLATE public.nocase,
    eqp_default_location character varying(20) COLLATE public.nocase,
    eqp_current_location character varying(40) COLLATE public.nocase,
    eqp_timestamp integer,
    eqp_created_date timestamp without time zone,
    eqp_created_by character varying(60) COLLATE public.nocase,
    eqp_modified_date timestamp without time zone,
    eqp_modified_by character varying(60) COLLATE public.nocase,
    eqp_intransit integer,
    eqp_refrigerated integer,
    veh_current_geo_type character varying(510) COLLATE public.nocase,
    eqp_raise_int_drfbill integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_equipment
    ADD CONSTRAINT d_equipment_pkey PRIMARY KEY (eqp_key);

ALTER TABLE ONLY click.d_equipment
    ADD CONSTRAINT d_equipment_ukey UNIQUE (eqp_equipment_id, eqp_ou);