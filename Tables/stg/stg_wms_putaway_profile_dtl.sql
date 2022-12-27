CREATE TABLE stg.stg_wms_putaway_profile_dtl (
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

ALTER TABLE ONLY stg.stg_wms_putaway_profile_dtl
    ADD CONSTRAINT wms_putaway_profile_dtl_pk PRIMARY KEY (wms_pway_ou, wms_pway_loc_code, wms_pway_line_no, wms_pway_congrp_seq_no);