CREATE TABLE stg.stg_pcsit_ext_item_master (
    item_code character varying(250) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);