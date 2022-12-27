CREATE TABLE click.f_wmsinboundsummary (
    wms_ib_key bigint NOT NULL,
    customer_key bigint,
    datekey bigint,
    loc_key bigint,
    ou_id integer,
    customer_id character varying(40) COLLATE public.nocase,
    asn_date date,
    item_group character varying(80) COLLATE public.nocase,
    item_class character varying(80) COLLATE public.nocase,
    loc_code character varying(20) COLLATE public.nocase,
    asn_type character varying(20) COLLATE public.nocase,
    inb_type character varying(20) COLLATE public.nocase,
    grn_status character varying(20) COLLATE public.nocase,
    grn_status_desc character varying(20) COLLATE public.nocase,
    pway_status character varying(20) COLLATE public.nocase,
    pway_status_desc character varying(20) COLLATE public.nocase,
    totalinbound integer,
    receivedlinecount integer,
    receivedunit numeric(20,2),
    cumvolume numeric(20,2),
    cucmvolume numeric(20,2),
    grn_hht_ind numeric(20,2),
    pway_hht_ind numeric(20,2)
);