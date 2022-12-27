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

ALTER TABLE dwh.f_pcsputawayplanlist ALTER COLUMN pcs_pway_pln_lst_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pcsputawayplanlist_pcs_pway_pln_lst_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pcsputawayplanlist
    ADD CONSTRAINT f_pcsputawayplanlist_pkey PRIMARY KEY (pcs_pway_pln_lst_key);

ALTER TABLE ONLY dwh.f_pcsputawayplanlist
    ADD CONSTRAINT f_pcsputawayplanlist_ukey UNIQUE (plan_no, putaway_emp_code, putaway_loc_code, putaway_euip_code);