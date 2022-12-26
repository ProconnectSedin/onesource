CREATE TABLE stg.stg_tms_tltrh_trip_log_thu_remarks_hdr (
    tltrh_ouinstance integer,
    tltrh_trip_plan_id character varying(72) NOT NULL COLLATE public.nocase,
    tltrh_br_id character varying(72) COLLATE public.nocase,
    tltrh_disp_doc character varying(72) COLLATE public.nocase,
    tltrh_leg_seq_no integer,
    tltrh_remarks character varying(160) COLLATE public.nocase,
    tltrh_created_date character varying(100) COLLATE public.nocase,
    tltrh_created_by character varying(120) COLLATE public.nocase,
    tltrh_modified_date character varying(100) COLLATE public.nocase,
    tltrh_modified_by character varying(120) COLLATE public.nocase,
    tltrh_pick_cmplt_chk character(4) COLLATE public.nocase,
    tltrh_id_type character varying(160) COLLATE public.nocase,
    tltrh_id_no character varying(160) COLLATE public.nocase,
    tltrh_desig_relation character varying(160) COLLATE public.nocase,
    tltrh_name character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);