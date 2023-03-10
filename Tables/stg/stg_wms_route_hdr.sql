CREATE TABLE stg.stg_wms_route_hdr (
    wms_rou_route_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_rou_ou integer NOT NULL,
    wms_rou_description character varying(1020) COLLATE public.nocase,
    wms_rou_status character varying(32) COLLATE public.nocase,
    wms_rou_rsn_code character varying(160) COLLATE public.nocase,
    wms_rou_trans_mode character varying(160) COLLATE public.nocase,
    wms_rou_serv_type character varying(1020) COLLATE public.nocase,
    wms_rou_sub_serv_type character varying(160) COLLATE public.nocase,
    wms_rou_valid_frm timestamp without time zone,
    wms_rou_valid_to timestamp without time zone,
    wms_rou_created_by character varying(120) COLLATE public.nocase,
    wms_rou_created_date timestamp without time zone,
    wms_rou_modified_by character varying(120) COLLATE public.nocase,
    wms_rou_modified_date timestamp without time zone,
    wms_rou_timestamp integer,
    wms_rou_userdefined1 character varying(1020) COLLATE public.nocase,
    wms_rou_userdefined2 character varying(1020) COLLATE public.nocase,
    wms_rou_userdefined3 character varying(1020) COLLATE public.nocase,
    wms_rou_route_type character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_route_hdr
    ADD CONSTRAINT wms_route_hdr_pk PRIMARY KEY (wms_rou_route_id, wms_rou_ou);