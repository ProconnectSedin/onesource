CREATE TABLE dwh.f_pickrulesheader (
    pick_rule_key bigint NOT NULL,
    pick_loc_key bigint NOT NULL,
    pick_loc_code character varying(20) COLLATE public.nocase,
    pick_ou integer,
    pick_schedule character varying(510) COLLATE public.nocase,
    pick_outputlist character varying(510) COLLATE public.nocase,
    pick_eqp_assign character varying(20) COLLATE public.nocase,
    pick_emp_assign character varying(20) COLLATE public.nocase,
    pick_timestamp integer,
    pick_created_by character varying(60) COLLATE public.nocase,
    pick_created_date timestamp without time zone,
    pick_modified_by character varying(60) COLLATE public.nocase,
    pick_modified_date timestamp without time zone,
    pick_countback_func integer,
    pick_auto_deconsol character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_pickrulesheader ALTER COLUMN pick_rule_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_pickrulesheader_pick_rule_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_pkey PRIMARY KEY (pick_rule_key);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_ukey UNIQUE (pick_loc_code, pick_ou);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_pick_loc_key_fkey FOREIGN KEY (pick_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_pickrulesheader_key_idx ON dwh.f_pickrulesheader USING btree (pick_loc_key);

CREATE INDEX f_pickrulesheader_key_idx1 ON dwh.f_pickrulesheader USING btree (pick_loc_code, pick_ou);