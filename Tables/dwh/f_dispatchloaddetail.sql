CREATE TABLE dwh.f_dispatchloaddetail (
    disp_load_dtl_key bigint NOT NULL,
    disp_load_loc_key bigint NOT NULL,
    disp_load_customer_key bigint NOT NULL,
    disp_location character varying(20) COLLATE public.nocase,
    disp_ou integer,
    disp_lineno integer,
    disp_customer character varying(40) COLLATE public.nocase,
    disp_profile character varying(40) COLLATE public.nocase,
    disp_ship_mode character varying(510) COLLATE public.nocase,
    disp_urgent character varying(510) COLLATE public.nocase,
    disp_lsp character varying(40) COLLATE public.nocase,
    disp_integ_tms character varying(510) COLLATE public.nocase,
    disp_status character varying(510) COLLATE public.nocase,
    disp_tms_location character varying(20) COLLATE public.nocase,
    disp_dispatch_bay character varying(40) COLLATE public.nocase,
    disp_bkreq_status character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);