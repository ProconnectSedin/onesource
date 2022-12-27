CREATE TABLE dwh.d_tmsdeliverytat (
    tms_dly_tat_key bigint NOT NULL,
    agent_code character varying(50) COLLATE public.nocase,
    shipfrom_place character varying(100) COLLATE public.nocase,
    shipfrom_pincode character varying(40),
    shipto_place character varying(100) COLLATE public.nocase,
    shipto_pincode character varying(40),
    ship_mode character varying(40),
    tat integer,
    tat_uom character varying(40),
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.d_tmsdeliverytat ALTER COLUMN tms_dly_tat_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.d_tmsdeliverytat_tms_dly_tat_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.d_tmsdeliverytat
    ADD CONSTRAINT d_tmsdeliverytat_pkey PRIMARY KEY (tms_dly_tat_key);

CREATE INDEX d_tmsdeliverytat_key_idx ON dwh.d_tmsdeliverytat USING btree (agent_code, shipfrom_pincode, shipto_pincode);