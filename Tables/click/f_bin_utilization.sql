CREATE TABLE click.f_bin_utilization (
    bin_util_key bigint NOT NULL,
    ou integer NOT NULL,
    location character varying(20) COLLATE public.nocase,
    customer_code character varying(40) COLLATE public.nocase,
    zone character varying(20) COLLATE public.nocase,
    bin_id character varying(20) COLLATE public.nocase,
    bin_type character varying(510) COLLATE public.nocase,
    bin_volume numeric(20,2),
    bin_volume_uom character varying(20) COLLATE public.nocase,
    bin_area numeric(20,2),
    stock_date timestamp without time zone,
    item_code character varying(80) COLLATE public.nocase,
    bin_on_hand_qty numeric(25,2),
    item_volume numeric(25,2),
    item_volume_uom character varying(20) COLLATE public.nocase,
    item_area numeric(25,2),
    utilized_volume_pct numeric(25,2),
    utilized_area_pct numeric(25,2)
);

ALTER TABLE click.f_bin_utilization ALTER COLUMN bin_util_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_bin_utilization_bin_util_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_bin_utilization
    ADD CONSTRAINT f_bin_utilization_pkey PRIMARY KEY (bin_util_key);