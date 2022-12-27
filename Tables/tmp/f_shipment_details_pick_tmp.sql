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

CREATE INDEX f_shipment_details_pick_tmp_ndx1 ON tmp.f_shipment_details_pick_tmp USING btree (ouinstance, ((trip_plan_id)::text), ((br_request_id)::text));