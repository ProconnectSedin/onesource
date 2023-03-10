CREATE TABLE click.f_pnd_oub_activity (
    pnd_oub_key bigint NOT NULL,
    ou integer,
    oub_date timestamp without time zone,
    oub_loc character varying(20),
    customer character varying(40),
    order_no character varying(40),
    order_status character varying(20),
    invoice_type character varying(510),
    invoice_no character varying(40),
    service_type character varying(510),
    line_no integer,
    item_code character varying(80),
    item_qty numeric(20,2),
    wave_status character varying(20),
    pick_status character varying(20),
    pack_status character varying(20),
    createdate timestamp without time zone,
    etlcreatedatetime timestamp without time zone,
    etlupdatedatetime timestamp without time zone,
    wave_pln_end_date timestamp without time zone,
    pick_exec_ml_end_date timestamp without time zone,
    obh_loc_key bigint,
    obh_cust_key bigint,
    obd_itm_key bigint
);

ALTER TABLE click.f_pnd_oub_activity ALTER COLUMN pnd_oub_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_pnd_oub_activity_pnd_oub_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_pnd_oub_activity
    ADD CONSTRAINT f_pnd_oub_pkey PRIMARY KEY (pnd_oub_key);