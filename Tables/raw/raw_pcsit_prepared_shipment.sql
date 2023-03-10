CREATE TABLE raw.raw_pcsit_prepared_shipment (
    raw_id bigint NOT NULL,
    ou integer NOT NULL,
    type character varying(20) NOT NULL COLLATE public.nocase,
    locationcode character varying(15) NOT NULL COLLATE public.nocase,
    doc_no character varying(50) NOT NULL COLLATE public.nocase,
    pick_location character varying(30) COLLATE public.nocase,
    thu_id character varying(50) NOT NULL COLLATE public.nocase,
    thu_qty numeric,
    lbh character varying(50) COLLATE public.nocase,
    target_location character varying(30) COLLATE public.nocase,
    status character varying(10) NOT NULL COLLATE public.nocase,
    created_by character varying(50) COLLATE public.nocase,
    created_date timestamp without time zone,
    pack_date date,
    pallettype character varying(50) COLLATE public.nocase,
    stockroom character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_prepared_shipment ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_prepared_shipment_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_prepared_shipment
    ADD CONSTRAINT raw_pcsit_prepared_shipment_pkey PRIMARY KEY (raw_id);