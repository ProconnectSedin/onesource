CREATE TABLE raw.raw_wms_putaway_profile_dtl (
    raw_id bigint NOT NULL,
    wms_pway_ou integer NOT NULL,
    wms_pway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pway_line_no integer NOT NULL,
    wms_pway_congrp_seq_no integer NOT NULL,
    wms_pway_profile_name character varying(1020) COLLATE public.nocase,
    wms_pway_destination_type character varying(1020) COLLATE public.nocase,
    wms_pway_destination_id character varying(1020) COLLATE public.nocase,
    wms_pway_con_grp character varying(1020) COLLATE public.nocase,
    wms_pway_con_grp_operator character varying(1020) COLLATE public.nocase,
    wms_pway_default integer,
    wms_pway_staging_id character varying(72) COLLATE public.nocase,
    wms_pway_thu_type character varying(1020) COLLATE public.nocase,
    wms_pway_cond_id character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_putaway_profile_dtl ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_putaway_profile_dtl_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_putaway_profile_dtl
    ADD CONSTRAINT raw_wms_putaway_profile_dtl_pkey PRIMARY KEY (raw_id);