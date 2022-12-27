CREATE TABLE raw.raw_pcs_track_registereddockets_tbl_onetime (
    raw_id bigint NOT NULL,
    orderid character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcs_track_registereddockets_tbl_onetime ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcs_track_registereddockets_tbl_onetime_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcs_track_registereddockets_tbl_onetime
    ADD CONSTRAINT raw_pcs_track_registereddockets_tbl_onetime_pkey PRIMARY KEY (raw_id);