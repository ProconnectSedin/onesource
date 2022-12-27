CREATE TABLE raw.raw_wms_asn_add_dtl (
    raw_id bigint NOT NULL,
    wms_asn_pop_asn_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_asn_pop_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_asn_pop_ou integer NOT NULL,
    wms_asn_pop_line_no integer NOT NULL,
    wms_asn_pop_date_1 timestamp without time zone,
    wms_asn_pop_date_2 timestamp without time zone,
    wms_asn_pop_ud_1 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_2 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_asn_add_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_asn_add_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_asn_add_dtl
    ADD CONSTRAINT raw_wms_asn_add_dtl_pkey PRIMARY KEY (raw_id);