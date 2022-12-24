CREATE TABLE tmp.f_shipment_details_pick_tmp (
    ouinstance integer NOT NULL,
    trip_plan_id character varying(18) NOT NULL COLLATE public.nocase,
    trip_plan_seq integer,
    br_request_id character varying(18) NOT NULL COLLATE public.nocase,
    actual_departed timestamp without time zone,
    agent_id character varying(40) COLLATE public.nocase,
    from_pincode character varying(40),
    to_pincode character varying(40)
);