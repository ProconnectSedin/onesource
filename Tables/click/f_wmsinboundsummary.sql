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

ALTER TABLE click.f_wmsinboundsummary ALTER COLUMN wms_ib_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_wmsinboundsummary_wms_ib_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_wmsinboundsummary
    ADD CONSTRAINT f_wmsinboundsummary_pkey PRIMARY KEY (wms_ib_key);

CREATE INDEX f_wmsinboundsummary_key_idx1 ON click.f_wmsinboundsummary USING btree (customer_key, datekey, loc_key, ou_id, item_group, item_class, asn_type, inb_type, grn_status, pway_status);