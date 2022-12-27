CREATE TABLE raw.raw_pcs_integrationtask_log (
    raw_id bigint NOT NULL,
    cust_id integer NOT NULL,
    client_name character varying(50) COLLATE public.nocase,
    service_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    clientstatus character varying(50) COLLATE public.nocase,
    key_search1 character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    key_search4 character varying(50) COLLATE public.nocase,
    clientdate timestamp without time zone,
    scheduler_id integer,
    last_schstatus character varying(100) COLLATE public.nocase,
    last_schdate timestamp without time zone,
    repuhsed_date timestamp without time zone,
    repuhsed_schid integer,
    ob_id integer,
    obd_date timestamp without time zone,
    obd_response_message character varying COLLATE public.nocase,
    obd_status character varying(30) COLLATE public.nocase,
    repush_obid integer,
    repush_obddate timestamp without time zone,
    repush_obd_responsemessage character varying COLLATE public.nocase,
    repush_obdstatus character varying(30) COLLATE public.nocase,
    customercode character varying(20) COLLATE public.nocase,
    locationcode character varying(20) COLLATE public.nocase,
    sourcedate timestamp without time zone,
    type character varying(50) COLLATE public.nocase,
    refno character varying(100) COLLATE public.nocase,
    shortmessage character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcs_integrationtask_log ALTER COLUMN cust_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcs_integrationtask_log_cust_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE raw.raw_pcs_integrationtask_log ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcs_integrationtask_log_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcs_integrationtask_log
    ADD CONSTRAINT raw_pcs_integrationtask_log_pkey PRIMARY KEY (raw_id);