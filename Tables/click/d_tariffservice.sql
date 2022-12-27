CREATE TABLE click.d_tariffservice (
    tf_key bigint NOT NULL,
    tf_ser_id character varying(40) COLLATE public.nocase,
    tf_ser_ou integer,
    tf_ser_desc character varying(510) COLLATE public.nocase,
    tf_ser_status character varying(20) COLLATE public.nocase,
    tf_ser_valid_from timestamp without time zone,
    tf_ser_valid_to timestamp without time zone,
    tf_ser_service_period numeric(13,0),
    tf_ser_uom character varying(20) COLLATE public.nocase,
    tf_ser_service_level_per numeric(13,0),
    tf_ser_reason_code character varying(80) COLLATE public.nocase,
    tf_ser_timestamp integer,
    tf_ser_created_by character varying(60) COLLATE public.nocase,
    tf_ser_created_dt timestamp without time zone,
    tf_ser_modified_by character varying(60) COLLATE public.nocase,
    tf_ser_modified_dt timestamp without time zone,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_tariffservice
    ADD CONSTRAINT d_tariffservice_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY click.d_tariffservice
    ADD CONSTRAINT d_tariffservice_ukey UNIQUE (tf_ser_id, tf_ser_ou);