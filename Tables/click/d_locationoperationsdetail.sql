CREATE TABLE click.d_locationoperationsdetail (
    loc_opr_dtl_key bigint NOT NULL,
    loc_opr_loc_code character varying(20) COLLATE public.nocase,
    loc_opr_ou integer,
    loc_opr_shift_code character varying(80) COLLATE public.nocase,
    loc_opr_lineno integer,
    loc_opr_sun_day integer,
    loc_opr_mon_day integer,
    loc_opr_tue_day integer,
    loc_opr_wed_day integer,
    loc_opr_thu_day integer,
    loc_opr_fri_day integer,
    loc_opr_sat_day integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_pkey PRIMARY KEY (loc_opr_dtl_key);

ALTER TABLE ONLY click.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_ukey UNIQUE (loc_opr_loc_code, loc_opr_lineno, loc_opr_ou);