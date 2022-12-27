CREATE TABLE dwh.f_pickempequipmapdetail (
    pick_emp_eqp_dtl_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_loc_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_emp_hdr_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_eqp_key bigint NOT NULL,
    pick_emp_eqp_dtl_key_zone_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_ou integer,
    pick_lineno integer,
    pick_shift_code character varying(80) COLLATE public.nocase,
    pick_emp_code character varying(40) COLLATE public.nocase,
    pick_euip_code character varying(60) COLLATE public.nocase,
    pick_area character varying(510) COLLATE public.nocase,
    pick_zone character varying(20) COLLATE public.nocase,
    pick_bin_level character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);