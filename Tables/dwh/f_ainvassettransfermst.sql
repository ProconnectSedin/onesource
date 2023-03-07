-- Table: dwh.f_ainvassettransfermst

-- DROP TABLE IF EXISTS dwh.f_ainvassettransfermst;

CREATE TABLE IF NOT EXISTS dwh.f_ainvassettransfermst
(
    ainvassettransfermst_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    "timestamp" integer,
    ou_id integer,
    transfer_date timestamp without time zone,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    recv_loc_code character varying(40) COLLATE public.nocase,
    recv_cost_center character varying(20) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    asset_loc_code character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_class_code character varying(40) COLLATE public.nocase,
    asset_group_code character varying(50) COLLATE public.nocase,
    asset_desc character varying(80) COLLATE public.nocase,
    tag_desc character varying(80) COLLATE public.nocase,
    confirm_reqd character varying(30) COLLATE public.nocase,
    confirm_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    dest_ouid integer,
    line_no integer,
    tran_out_no character varying(40) COLLATE public.nocase,
    tran_in_no character varying(40) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainvassettransfermst_pkey PRIMARY KEY (ainvassettransfermst_key),
    CONSTRAINT f_ainvassettransfermst_ukey UNIQUE (ou_id, transfer_date, asset_number, tag_number, line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainvassettransfermst
    OWNER to proconnect;
-- Index: f_ainvassettransfermst_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ainvassettransfermst_key_idx1;

CREATE INDEX IF NOT EXISTS f_ainvassettransfermst_key_idx1
    ON dwh.f_ainvassettransfermst USING btree
    (ou_id ASC NULLS LAST, transfer_date ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;