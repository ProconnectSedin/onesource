CREATE TABLE raw.raw_pcs_putaway_planlist (
    raw_id bigint NOT NULL,
    wms_putaway_emp_code character varying(80) COLLATE public.nocase,
    wms_emp_user character varying(120) COLLATE public.nocase,
    wms_plan_no character varying(72) COLLATE public.nocase,
    wms_putaway_euip_code character varying(120) COLLATE public.nocase,
    wms_putaway_loc_code character varying(40) COLLATE public.nocase,
    wms_created_date timestamp without time zone,
    wms_seq_no integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_pcs_putaway_planlist ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_pcs_putaway_planlist_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_pcs_putaway_planlist
    ADD CONSTRAINT raw_pcs_putaway_planlist_pkey PRIMARY KEY (raw_id);