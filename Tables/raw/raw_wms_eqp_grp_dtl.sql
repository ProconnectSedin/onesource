CREATE TABLE raw.raw_wms_eqp_grp_dtl (
    raw_id bigint NOT NULL,
    wms_egrp_ou integer NOT NULL,
    wms_egrp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_egrp_lineno integer NOT NULL,
    wms_egrp_eqp_id character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_eqp_grp_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_eqp_grp_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_eqp_grp_dtl
    ADD CONSTRAINT raw_wms_eqp_grp_dtl_pkey PRIMARY KEY (raw_id);