CREATE TABLE raw.raw_wms_putaway_rule_hdr (
    raw_id bigint NOT NULL,
    wms_putaway_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_putaway_ou integer NOT NULL,
    wms_putaway_sch_rule character varying(32) COLLATE public.nocase,
    wms_putaway_output_pln character varying(32) COLLATE public.nocase,
    wms_putaway_eqp_assign_plan character varying(32) COLLATE public.nocase,
    wms_putaway_emp_assign_plan character varying(32) COLLATE public.nocase,
    wms_putaway_gr_flag integer,
    wms_putaway_lines_per integer,
    wms_putaway_seq character varying(32) COLLATE public.nocase,
    wms_putaway_by character varying(32) COLLATE public.nocase,
    wms_putaway_created_by character varying(120) COLLATE public.nocase,
    wms_putaway_created_date timestamp without time zone,
    wms_putaway_modified_by character varying(120) COLLATE public.nocase,
    wms_putaway_modified_date timestamp without time zone,
    wms_putaway_timestamp integer,
    wms_putaway_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_putaway_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_putaway_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_putaway_oub_crdck character varying(32) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_wms_putaway_rule_hdr ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_wms_putaway_rule_hdr_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_wms_putaway_rule_hdr
    ADD CONSTRAINT raw_wms_putaway_rule_hdr_pkey PRIMARY KEY (raw_id);