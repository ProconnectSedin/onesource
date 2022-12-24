CREATE TABLE raw.raw_pcsit_tms_delivery_tat (
    agent_code character varying(100) COLLATE public.nocase,
    shipfrom_place character varying(200) COLLATE public.nocase,
    shipfrom_pincode integer,
    shipto_place character varying(200) COLLATE public.nocase,
    shipto_pincode integer,
    ship_mode character(40) COLLATE public.nocase,
    tat integer,
    tat_uom character(40) COLLATE public.nocase,
    tat_id character varying(256) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);