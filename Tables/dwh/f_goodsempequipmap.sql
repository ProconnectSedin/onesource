CREATE TABLE dwh.f_goodsempequipmap (
    gr_good_emp_key bigint NOT NULL,
    gr_loc_key bigint NOT NULL,
    gr_loc_cod character varying(510) COLLATE public.nocase,
    gr_ou integer,
    gr_lineno integer,
    gr_shift_code character varying(510) COLLATE public.nocase,
    gr_emp_code character varying(20) COLLATE public.nocase,
    gr_area character varying(510) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);