CREATE TABLE raw.raw_pcsit_ext_item_master (
    raw_id bigint NOT NULL,
    item_code character varying(250) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);