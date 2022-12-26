CREATE TABLE dwh.f_bookingrequestreasonhistory (
    br_bkreq_key bigint NOT NULL,
    br_hdr_key bigint NOT NULL,
    br_ouinstance integer,
    br_request_id character varying(40) COLLATE public.nocase,
    amend_no integer,
    br_status character varying(80) COLLATE public.nocase,
    reason_code character varying(80) COLLATE public.nocase,
    reason_desc character varying(510) COLLATE public.nocase,
    created_date character varying(50) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);