CREATE TABLE stg.stg_pcsit_eshipz_courier_master (
    id integer NOT NULL,
    agentname character varying(400) COLLATE public.nocase,
    agentid character varying(40) COLLATE public.nocase,
    courier_name character varying(2000) COLLATE public.nocase,
    ramco_id character varying(600) COLLATE public.nocase,
    createdby character varying(200) COLLATE public.nocase,
    createddate date,
    location_code character varying(400) COLLATE public.nocase,
    location character varying(30) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE stg.stg_pcsit_eshipz_courier_master ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME stg.stg_pcsit_eshipz_courier_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);