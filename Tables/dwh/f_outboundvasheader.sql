CREATE TABLE dwh.f_outboundvasheader (
    oub_vhr_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    oub_loc_key bigint NOT NULL,
    oub_loc_code character varying(20) COLLATE public.nocase,
    oub_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_lineno integer,
    oub_vas_id character varying(40) COLLATE public.nocase,
    oub_instructions character varying(510) COLLATE public.nocase,
    oub_sequence integer,
    oub_created_by character varying(60) COLLATE public.nocase,
    oub_modified_by character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);