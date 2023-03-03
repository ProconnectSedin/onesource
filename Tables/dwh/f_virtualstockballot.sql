-- Table: dwh.f_virtualstockballot

-- DROP TABLE IF EXISTS dwh.f_virtualstockballot;

CREATE TABLE IF NOT EXISTS dwh.f_virtualstockballot
(
    virtualstockbal_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    itm_hdr_key bigint,
    loc_key bigint,
    ref_doc_date_key bigint,
    sbl_wh_loc_code character varying(20) COLLATE pg_catalog."default",
    sbl_ouinstid integer,
    sbl_line_no integer,
    sbl_item_code character varying(80) COLLATE pg_catalog."default",
    sbl_lot_no character varying(60) COLLATE pg_catalog."default",
    sbl_zone character varying(20) COLLATE pg_catalog."default",
    sbl_bin character varying(20) COLLATE pg_catalog."default",
    sbl_stock_status character varying(20) COLLATE pg_catalog."default",
    sbl_from_zone character varying(20) COLLATE pg_catalog."default",
    sbl_from_bin character varying(20) COLLATE pg_catalog."default",
    sbl_ref_doc_no character varying(40) COLLATE pg_catalog."default",
    sbl_ref_doc_type character varying(20) COLLATE pg_catalog."default",
    sbl_ref_doc_date timestamp without time zone,
    sbl_ref_doc_line_no integer,
    sbl_disposal_doc_type character varying(20) COLLATE pg_catalog."default",
    sbl_disposal_doc_no character varying(40) COLLATE pg_catalog."default",
    sbl_disposal_doc_date timestamp without time zone,
    sbl_disposal_status character varying(20) COLLATE pg_catalog."default",
    sbl_quantity numeric(25,2),
    sbl_wh_bat_no character varying(60) COLLATE pg_catalog."default",
    sbl_supp_bat_no character varying(60) COLLATE pg_catalog."default",
    sbl_ido_no character varying(40) COLLATE pg_catalog."default",
    sbl_gr_no character varying(40) COLLATE pg_catalog."default",
    sbl_created_date timestamp without time zone,
    sbl_created_by character varying(60) COLLATE pg_catalog."default",
    sbl_modified_date timestamp without time zone,
    sbl_modified_by character varying(60) COLLATE pg_catalog."default",
    sbl_to_zone character varying(20) COLLATE pg_catalog."default",
    sbl_to_bin character varying(20) COLLATE pg_catalog."default",
    sbl_reason_code character varying(80) COLLATE pg_catalog."default",
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_virtualstockballot_pkey PRIMARY KEY (virtualstockbal_key),
    CONSTRAINT f_virtualstockballot_ukey UNIQUE (sbl_wh_loc_code, sbl_ouinstid, sbl_line_no)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_virtualstockballot
    OWNER to proconnect;

CREATE INDEX IF NOT EXISTS f_virtualstockballot_idx
    ON dwh.f_virtualstockballot USING btree
	(sbl_wh_loc_code, sbl_ouinstid, sbl_line_no);