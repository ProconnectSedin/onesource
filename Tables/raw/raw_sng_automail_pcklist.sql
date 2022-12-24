CREATE TABLE raw.raw_sng_automail_pcklist (
    raw_id bigint NOT NULL,
    execid integer NOT NULL,
    wms_pack_exec_no character varying(400) COLLATE public.nocase,
    wms_pack_obd_no character varying(200) COLLATE public.nocase,
    created_date timestamp without time zone DEFAULT now(),
    status character(40) DEFAULT 'NEW'::bpchar COLLATE public.nocase,
    wms_pack_exec_end_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);