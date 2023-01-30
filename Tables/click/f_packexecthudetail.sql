-- Table: click.f_packexecthudetail

-- DROP TABLE IF EXISTS click.f_packexecthudetail;

CREATE TABLE IF NOT EXISTS click.f_packexecthudetail
(
    pack_exec_thu_dtl_key bigint NOT NULL,
    pack_exec_hdr_key bigint NOT NULL,
    pack_exec_thu_hdr_key bigint,
    pack_exec_itm_hdr_key bigint,
    pack_exec_loc_key bigint NOT NULL,
    pack_exec_thu_key bigint NOT NULL,
    pack_loc_code character varying(20) COLLATE public.nocase,
    pack_exec_no character varying(40) COLLATE public.nocase,
    pack_exec_ou integer,
    pack_thu_id character varying(80) COLLATE public.nocase,
    pack_thu_lineno integer,
    pack_thu_ser_no character varying(60) COLLATE public.nocase,
    pack_picklist_no character varying(40) COLLATE public.nocase,
    pack_so_no character varying(40) COLLATE public.nocase,
    pack_so_line_no integer,
    pack_so_sch_lineno integer,
    pack_thu_item_code character varying(80) COLLATE public.nocase,
    pack_thu_item_qty numeric(25,2),
    pack_thu_pack_qty numeric(25,2),
    pack_thu_item_batch_no character varying(60) COLLATE public.nocase,
    pack_thu_item_sr_no character varying(60) COLLATE public.nocase,
    pack_lot_no character varying(60) COLLATE public.nocase,
    pack_uid1_ser_no character varying(60) COLLATE public.nocase,
    pack_uid_ser_no character varying(60) COLLATE public.nocase,
    pack_allocated_qty numeric(25,2),
    pack_planned_qty numeric(25,2),
    pack_tolerance_qty numeric(25,2),
    pack_packed_from_uid_serno character varying(60) COLLATE public.nocase,
    pack_factory_pack character varying(40) COLLATE public.nocase,
    pack_source_thu_ser_no character varying(80) COLLATE public.nocase,
    pack_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    createddate timestamp(3) without time zone,
    updatedatetime timestamp(3) without time zone,
    CONSTRAINT f_packexecthudetail_pkey PRIMARY KEY (pack_exec_thu_dtl_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_packexecthudetail
    OWNER to proconnect;