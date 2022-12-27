CREATE TABLE stg.stg_pcsit_prepared_shipment (
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

ALTER TABLE ONLY stg.stg_pcsit_prepared_shipment
    ADD CONSTRAINT pk_pcsit_prepared_shipment PRIMARY KEY (ou, type, locationcode, doc_no, thu_id, status);