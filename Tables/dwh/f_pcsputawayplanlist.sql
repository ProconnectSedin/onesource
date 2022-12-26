CREATE TABLE dwh.f_pcsputawayplanlist (
    pcs_pway_pln_lst_key bigint NOT NULL,
    putaway_emp_code character varying(40) COLLATE public.nocase,
    emp_user character varying(60) COLLATE public.nocase,
    plan_no character varying(40) COLLATE public.nocase,
    putaway_euip_code character varying(60) COLLATE public.nocase,
    putaway_loc_code character varying(20) COLLATE public.nocase,
    created_date timestamp without time zone,
    seq_no integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);