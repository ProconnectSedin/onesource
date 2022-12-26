CREATE TABLE dwh.f_outbounddocdetail (
    obd_dl_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    obd_loc_key bigint NOT NULL,
    oub_doc_loc_code character varying(80) COLLATE public.nocase,
    oub_outbound_ord character varying(510) COLLATE public.nocase,
    oub_doc_lineno integer,
    oub_doc_ou integer,
    oub_doc_type character varying(80) COLLATE public.nocase,
    oub_doc_attach character varying(510) COLLATE public.nocase,
    oub_doc_hdn_attach text COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);