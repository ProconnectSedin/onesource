CREATE TABLE dwh.d_equipment (
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

ALTER TABLE dwh.d_equipment ALTER COLUMN eqp_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_equipment_eqp_key_seq
    START WITH -1
    INCREMENT BY 1
    MINVALUE -1
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_equipment
    ADD CONSTRAINT d_equipment_pkey PRIMARY KEY (eqp_key);

ALTER TABLE ONLY dwh.d_equipment
    ADD CONSTRAINT d_equipment_ukey UNIQUE (eqp_equipment_id, eqp_ou);