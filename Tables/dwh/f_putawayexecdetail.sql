CREATE TABLE dwh.f_putawayexecdetail (
    pway_exe_dtl_key bigint NOT NULL,
    pway_pln_dtl_key bigint,
    pway_exe_dtl_loc_key bigint NOT NULL,
    pway_exe_dtl_eqp_key bigint NOT NULL,
    pway_exe_dtl_stg_mas_key bigint NOT NULL,
    pway_exe_dtl_emp_hdr_key bigint NOT NULL,
    pway_loc_code character varying(20) COLLATE public.nocase,
    pway_exec_no character varying(40) COLLATE public.nocase,
    pway_exec_ou integer,
    pway_pln_no character varying(40) COLLATE public.nocase,
    pway_pln_ou integer,
    pway_exec_status character varying(20) COLLATE public.nocase,
    pway_stag_id character varying(40) COLLATE public.nocase,
    pway_mhe_id character varying(60) COLLATE public.nocase,
    pway_employee_id character varying(40) COLLATE public.nocase,
    pway_exec_start_date timestamp without time zone,
    pway_exec_end_date timestamp without time zone,
    pway_completed integer,
    pway_created_by character varying(60) COLLATE public.nocase,
    pway_created_date timestamp without time zone,
    pway_modified_by character varying(60) COLLATE public.nocase,
    pway_modified_date timestamp without time zone,
    pway_timestamp integer,
    pway_type character varying(20) COLLATE public.nocase,
    pway_by_flag character varying(20) COLLATE public.nocase,
    pway_gen_from character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);