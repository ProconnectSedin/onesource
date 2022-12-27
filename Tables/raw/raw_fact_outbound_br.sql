CREATE TABLE raw.raw_fact_outbound_br (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    br_ou integer NOT NULL,
    br_loc_code character varying(200) COLLATE public.nocase,
    br_no character varying(200) COLLATE public.nocase,
    customer_id character varying(160) COLLATE public.nocase,
    status character varying(320) COLLATE public.nocase,
    type character varying(320) COLLATE public.nocase,
    customer_ref_no character varying(600) COLLATE public.nocase,
    sender_ref_no character varying(600) COLLATE public.nocase,
    service_type character varying(400) COLLATE public.nocase,
    sub_service_type character varying(400) COLLATE public.nocase,
    transport_mode character varying(200) COLLATE public.nocase,
    br_request_confirmation_date timestamp without time zone,
    validation_profile_id character varying(400) COLLATE public.nocase,
    route_id character varying(400) COLLATE public.nocase,
    payment_type character varying(320) COLLATE public.nocase,
    creation_date timestamp without time zone,
    created_by character varying(400) COLLATE public.nocase,
    last_modified_date timestamp without time zone,
    last_modified_by character varying(400) COLLATE public.nocase,
    order_type character varying(400) COLLATE public.nocase,
    shippers_inv_no character varying(400) COLLATE public.nocase,
    invoice_value numeric,
    currency character varying(120) COLLATE public.nocase,
    from_ship_point_id character varying(520) COLLATE public.nocase,
    from_postal_code character varying(120) COLLATE public.nocase,
    to_ship_point_name character varying(520) COLLATE public.nocase,
    to_postal_code character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_outbound_br ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_br_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_br
    ADD CONSTRAINT raw_fact_outbound_br_pkey PRIMARY KEY (raw_id);