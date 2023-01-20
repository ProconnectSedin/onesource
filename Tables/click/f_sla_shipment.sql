-- Table: click.f_sla_shipment

DROP TABLE IF EXISTS click.f_sla_shipment;

CREATE TABLE IF NOT EXISTS click.f_sla_shipment
(
    sla_shipment_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    shipment_dtl_key bigint,
    customer_key bigint,
    br_key bigint,
    loc_key bigint,
    vendor_key bigint,
    sla_ou integer NOT NULL,
    sla_customer_id character varying(18) COLLATE public.nocase,
    sla_br_id character varying(18) COLLATE public.nocase NOT NULL,
    sla_cust_ref_no character varying(255) COLLATE public.nocase,
    sla_service_type character varying(40) COLLATE public.nocase,
    sla_sub_service_type character varying(40) COLLATE public.nocase,
    sla_location character varying(40) COLLATE public.nocase,
    agent_id character varying(40) COLLATE public.nocase,
    agent_name character varying(120) COLLATE public.nocase,
    sla_category character varying(20) COLLATE public.nocase,
    opening_time time without time zone,
    cutofftime time without time zone,
    order_confirmed_date_time timestamp without time zone,
    actual_dispatched_date_time timestamp without time zone,
    actual_delivered_date_time timestamp without time zone,
    dispatch_exptd_date_time timestamp without time zone,
    delivery_exptd_date_time timestamp without time zone,
    dispatch_ontime_flag integer,
    deliver_ontime_flag integer,
    createddate timestamp(3) without time zone,
    dispatch_tat character varying(30) COLLATE public.nocase,
    trip_plan_createddate timestamp without time zone,
    activeindicator integer,
    tracking_status character varying(50) COLLATE public.nocase,
    CONSTRAINT f_sla_shipment_pkey PRIMARY KEY (sla_shipment_key)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS click.f_sla_shipment
    OWNER to proconnect;