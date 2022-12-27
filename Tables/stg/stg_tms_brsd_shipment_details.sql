CREATE TABLE stg.stg_tms_brsd_shipment_details (
    brsd_ouinstance integer NOT NULL,
    brsd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    brsd_from_ship_point_id character varying(72) COLLATE public.nocase,
    brsd_from_ship_point_name character varying(1020) COLLATE public.nocase,
    brsd_from_contact_person character varying(180) COLLATE public.nocase,
    brsd_from_address_line1 character varying(600) COLLATE public.nocase,
    brsd_from_address_line2 character varying(600) COLLATE public.nocase,
    brsd_from_address_line3 character varying(600) COLLATE public.nocase,
    brsd_from_postal_code character varying(160) COLLATE public.nocase,
    brsd_from_subzone character varying(160) COLLATE public.nocase,
    brsd_from_city character varying(160) COLLATE public.nocase,
    brsd_from_zone character varying(160) COLLATE public.nocase,
    brsd_from_state character varying(160) COLLATE public.nocase,
    brsd_from_region character varying(160) COLLATE public.nocase,
    brsd_from_country character varying(160) COLLATE public.nocase,
    brsd_from_primary_phone character varying(160) COLLATE public.nocase,
    brsd_from_secondary_phone character varying(160) COLLATE public.nocase,
    brsd_from_pick_date timestamp without time zone,
    brsd_from_picktime_slot_from timestamp without time zone,
    brsd_from_picktime_slot_to timestamp without time zone,
    brsd_from_creation_date timestamp without time zone,
    brsd_from_created_by character varying(120) COLLATE public.nocase,
    brsd_from_last_modified_date timestamp without time zone,
    brsd_from_last_modified_by character varying(120) COLLATE public.nocase,
    brsd_to_ship_point_id character varying(72) COLLATE public.nocase,
    brsd_to_ship_point_name character varying(1020) COLLATE public.nocase,
    brsd_to_contact_person character varying(180) COLLATE public.nocase,
    brsd_to_address_line1 character varying(600) COLLATE public.nocase,
    brsd_to_address_line2 character varying(600) COLLATE public.nocase,
    brsd_to_address_line3 character varying(600) COLLATE public.nocase,
    brsd_to_postal_code character varying(160) COLLATE public.nocase,
    brsd_to_subzone character varying(160) COLLATE public.nocase,
    brsd_to_city character varying(160) COLLATE public.nocase,
    brsd_to_zone character varying(160) COLLATE public.nocase,
    brsd_to_state character varying(160) COLLATE public.nocase,
    brsd_to_region character varying(160) COLLATE public.nocase,
    brsd_to_country character varying(160) COLLATE public.nocase,
    brsd_to_primary_phone character varying(160) COLLATE public.nocase,
    brsd_to_secondary_phone character varying(160) COLLATE public.nocase,
    brsd_to_creation_date timestamp without time zone,
    brsd_to_created_by character varying(120) COLLATE public.nocase,
    brsd_to_last_modified_date timestamp without time zone,
    brsd_to_last_modified_by character varying(120) COLLATE public.nocase,
    brsd_unique_id character varying(512) COLLATE public.nocase,
    brsd_to_delivery_date timestamp without time zone,
    brsd_to_deliverytime_slot_from timestamp without time zone,
    brsd_to_deliverytime_slot_to timestamp without time zone,
    brsd_to_consignee_same_as_ship_to character(4) COLLATE public.nocase,
    brsd_from_suburb character varying(160) COLLATE public.nocase,
    brsd_to_suburb character varying(160) COLLATE public.nocase,
    brsd_alternate_to_ship_point_id character varying(72) COLLATE public.nocase,
    brsd_alternate_to_ship_point_name character varying(1020) COLLATE public.nocase,
    brsd_alternate_to_contact_person character varying(180) COLLATE public.nocase,
    brsd_alternate_to_address_line1 character varying(600) COLLATE public.nocase,
    brsd_alternate_to_address_line2 character varying(600) COLLATE public.nocase,
    brsd_alternate_to_address_line3 character varying(600) COLLATE public.nocase,
    brsd_alternate_to_postal_code character varying(160) COLLATE public.nocase,
    brsd_alternate_to_subzone character varying(160) COLLATE public.nocase,
    brsd_alternate_to_city character varying(160) COLLATE public.nocase,
    brsd_alternate_to_zone character varying(160) COLLATE public.nocase,
    brsd_alternate_to_state character varying(160) COLLATE public.nocase,
    brsd_alternate_to_region character varying(160) COLLATE public.nocase,
    brsd_alternate_to_country character varying(160) COLLATE public.nocase,
    brsd_alternate_to_primary_phone character varying(160) COLLATE public.nocase,
    brsd_alternate_to_secondary_phone character varying(160) COLLATE public.nocase,
    brsd_alternate_to_creation_date timestamp without time zone,
    brsd_alternate_to_created_by character varying(120) COLLATE public.nocase,
    brsd_alternate_to_last_modified_date timestamp without time zone,
    brsd_alternate_to_last_modified_by character varying(120) COLLATE public.nocase,
    brsd_alternate_to_consignee_same_as_ship_to character(4) COLLATE public.nocase,
    brsd_alternate_to_suburb character varying(160) COLLATE public.nocase,
    brsd_alternate_to_remarks character varying(16000) COLLATE public.nocase,
    brsd_from_email_id character varying(1020) COLLATE public.nocase,
    brsd_from_remarks character varying(16000) COLLATE public.nocase,
    brsd_to_email_id character varying(1020) COLLATE public.nocase,
    brsd_to_remarks character varying(16000) COLLATE public.nocase,
    brsd_timestamp integer,
    brsd_alternate_contact_remarks character varying(160) COLLATE public.nocase,
    brsd_alternate_email_id character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);