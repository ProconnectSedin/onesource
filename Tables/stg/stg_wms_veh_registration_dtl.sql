CREATE TABLE stg.stg_wms_veh_registration_dtl (
    wms_veh_ou integer NOT NULL,
    wms_veh_id character varying(120) NOT NULL COLLATE public.nocase,
    wms_veh_line_no integer NOT NULL,
    wms_veh_reg_no character varying(160) COLLATE public.nocase,
    wms_veh_address character varying(1020) COLLATE public.nocase,
    wms_veh_title_holder_name character varying(160) COLLATE public.nocase,
    wms_veh_issuing_auth character varying(160) COLLATE public.nocase,
    wms_veh_issuing_location character varying(40) COLLATE public.nocase,
    wms_veh_issuing_date timestamp without time zone,
    wms_veh_exp_date timestamp without time zone,
    wms_veh_remarks character varying(4000) COLLATE public.nocase,
    wms_veh_doc_type character varying(160) COLLATE public.nocase,
    wms_veh_doc_no character varying(160) COLLATE public.nocase,
    wms_veh_attachment character varying(1020) COLLATE public.nocase,
    wms_veh_attachment_hdn character varying COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);