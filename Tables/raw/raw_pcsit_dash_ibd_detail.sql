CREATE TABLE raw.raw_pcsit_dash_ibd_detail (
    raw_id bigint NOT NULL,
    created_date timestamp without time zone,
    client_name character varying(50) COLLATE public.nocase,
    service_type character varying(50) COLLATE public.nocase,
    key_search2 character varying(50) COLLATE public.nocase,
    key_search3 character varying(50) COLLATE public.nocase,
    asn character varying(16000) COLLATE public.nocase,
    taskstatus character varying(50) COLLATE public.nocase,
    status character varying(10) NOT NULL COLLATE public.nocase,
    grnstatus character varying(120) COLLATE public.nocase,
    schservice character varying(120) COLLATE public.nocase,
    pono character varying(120) COLLATE public.nocase,
    cust_id integer NOT NULL,
    wms_asn_type character varying(120) COLLATE public.nocase,
    wms_asn_no character varying(120) COLLATE public.nocase,
    wipasnno character varying(120) COLLATE public.nocase,
    ramcolocation character varying(120) COLLATE public.nocase,
    padate timestamp without time zone,
    cutoffflag character varying(80) COLLATE public.nocase,
    cutoffdate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_dash_ibd_detail ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_dash_ibd_detail_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_dash_ibd_detail
    ADD CONSTRAINT raw_pcsit_dash_ibd_detail_pkey PRIMARY KEY (raw_id);