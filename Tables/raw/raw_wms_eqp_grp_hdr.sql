CREATE TABLE raw.raw_wms_eqp_grp_hdr (
    raw_id bigint NOT NULL,
    wms_egrp_ou integer NOT NULL,
    wms_egrp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_egrp_desc character varying(1020) COLLATE public.nocase,
    wms_egrp_status character varying(1020) COLLATE public.nocase,
    wms_egrp_reason_code character varying(160) COLLATE public.nocase,
    wms_egrp_created_by character varying(120) COLLATE public.nocase,
    wms_egrp_created_date timestamp without time zone,
    wms_egrp_modified_by character varying(120) COLLATE public.nocase,
    wms_egrp_modified_date timestamp without time zone,
    wms_egrp_timestamp integer,
    wms_egrp_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_egrp_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_egrp_userdefined3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_eqp_grp_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_eqp_grp_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_eqp_grp_hdr
    ADD CONSTRAINT raw_wms_eqp_grp_hdr_pkey PRIMARY KEY (raw_id);