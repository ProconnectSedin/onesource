CREATE TABLE raw.raw_pcsit_outbound_location_shift_dtl (
    raw_id bigint NOT NULL,
    ou integer,
    locationcode character varying(50) COLLATE public.nocase,
    days integer NOT NULL,
    openingtime time without time zone,
    closingtime time without time zone,
    cutofftime time without time zone,
    weeks character varying(9) NOT NULL COLLATE public.nocase,
    ordertype character varying(20) COLLATE public.nocase,
    servicetype character varying(30) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcsit_outbound_location_shift_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcsit_outbound_location_shift_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcsit_outbound_location_shift_dtl
    ADD CONSTRAINT raw_pcsit_outbound_location_shift_dtl_pkey PRIMARY KEY (raw_id);