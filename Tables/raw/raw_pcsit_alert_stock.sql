CREATE TABLE raw.raw_pcsit_alert_stock (
    raw_id bigint NOT NULL,
    locationcode character varying(50) COLLATE public.nocase,
    locationdesc character varying(150) COLLATE public.nocase,
    emailid character varying COLLATE public.nocase,
    zonal_emailid character varying COLLATE public.nocase,
    manager_emailid character varying COLLATE public.nocase,
    zone character varying(50) COLLATE public.nocase,
    region character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_alert_stock ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_alert_stock_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_alert_stock
    ADD CONSTRAINT raw_pcsit_alert_stock_pkey PRIMARY KEY (raw_id);