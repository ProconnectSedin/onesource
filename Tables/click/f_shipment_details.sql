CREATE TABLE click.f_shipment_details (
    shipment_dtl_key bigint NOT NULL,
    trip_plan_datekey integer NOT NULL,
    trip_exec_datekey integer NOT NULL,
    ouinstance integer NOT NULL,
    br_request_id character varying(18) NOT NULL COLLATE public.nocase,
    br_customer_id character varying(18) COLLATE public.nocase,
    br_customer_ref_no character varying(255) COLLATE public.nocase,
    br_status character varying(40) COLLATE public.nocase,
    service_type character varying(40) COLLATE public.nocase,
    sub_service_type character varying(40) COLLATE public.nocase,
    trip_plan_id character varying(18) NOT NULL COLLATE public.nocase,
    trip_plan_status character varying(40) COLLATE public.nocase,
    vehicle_type character varying(40) COLLATE public.nocase,
    vehicle_id character varying(40) COLLATE public.nocase,
    agent_id character varying(40) COLLATE public.nocase,
    agent_resource character varying(40) COLLATE public.nocase,
    loc character varying(40) COLLATE public.nocase,
    from_city character varying(40) COLLATE public.nocase,
    from_state character varying(40) COLLATE public.nocase,
    to_city character varying(40) COLLATE public.nocase,
    to_state character varying(40) COLLATE public.nocase,
    leg_behaviour character varying(40) NOT NULL COLLATE public.nocase,
    trip_plan_date timestamp without time zone,
    trip_plan_end_date timestamp without time zone,
    trip_plan_seq integer,
    dispatch_doc_no character varying(18) NOT NULL COLLATE public.nocase,
    dispatch_doc_type character varying(40) COLLATE public.nocase,
    veh_in_dim_uom character varying(10) COLLATE public.nocase,
    veh_volume numeric(38,6),
    planned_tripstart timestamp without time zone,
    planned_arrived timestamp without time zone,
    planned_takenover_handedover timestamp without time zone,
    planned_departed timestamp without time zone,
    planned_tripend timestamp without time zone,
    actual_tripstart timestamp without time zone,
    actual_arrived timestamp without time zone,
    actual_takenover_handedover timestamp without time zone,
    actual_departed timestamp without time zone,
    actual_tripend timestamp without time zone,
    ontime_pickup_delivery integer NOT NULL,
    shipmentdays integer,
    draft_bill_total_value numeric(28,8),
    draft_bill_approved_date timestamp without time zone,
    trip_volume numeric(38,6),
    trip_volume_uom character varying(10) COLLATE public.nocase,
    createddatetime timestamp without time zone NOT NULL,
    draft_bill_no character varying(40) COLLATE public.nocase,
    draft_bill_volume numeric(28,8),
    draft_bill_contract character varying(40) COLLATE public.nocase,
    draft_bill_line_status character varying(40) COLLATE public.nocase,
    podflag integer,
    br_invoice_value numeric(28,8),
    trip_plan_createddate timestamp without time zone,
    from_pincode character varying(40),
    to_pincode character varying(40),
    expected_datetodeliver timestamp without time zone,
    ontimedelvry_count integer,
    br_key bigint,
    ship_customer_key bigint,
    ship_loc_key bigint,
    tatdays integer
);

ALTER TABLE click.f_shipment_details ALTER COLUMN shipment_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_shipment_details_shipment_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_shipment_details
    ADD CONSTRAINT f_shipment_details_pkey PRIMARY KEY (shipment_dtl_key);

CREATE INDEX f_shipment_details_idx1 ON click.f_shipment_details USING btree (ouinstance, trip_plan_id, br_request_id);

CREATE INDEX f_shipment_details_idx2 ON click.f_shipment_details USING btree (ouinstance, trip_plan_id, dispatch_doc_no);

CREATE INDEX f_shipment_details_idx3 ON click.f_shipment_details USING btree (((trip_plan_createddate)::date));

CREATE INDEX f_shipment_details_idx4 ON click.f_shipment_details USING btree (leg_behaviour);