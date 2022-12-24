CREATE TABLE raw.raw_tms_brccd_consgt_consignee_details (
    raw_id bigint NOT NULL,
    ccd_ouinstance integer NOT NULL,
    ccd_br_id character varying(72) NOT NULL COLLATE public.nocase,
    ccd_consignee_id character varying(72) COLLATE public.nocase,
    ccd_consignee_name character varying(600) COLLATE public.nocase,
    ccd_consignee_contact_person character varying(180) COLLATE public.nocase,
    ccd_consignee_address_line1 character varying(600) COLLATE public.nocase,
    ccd_consignee_address_line2 character varying(600) COLLATE public.nocase,
    ccd_consignee_address_line3 character varying(400) COLLATE public.nocase,
    ccd_consignee_postal_code character varying(160) COLLATE public.nocase,
    ccd_consignee_subzone character varying(160) COLLATE public.nocase,
    ccd_consignee_city character varying(160) COLLATE public.nocase,
    ccd_consignee_zone character varying(160) COLLATE public.nocase,
    ccd_consignee_state character varying(160) COLLATE public.nocase,
    ccd_consignee_region character varying(160) COLLATE public.nocase,
    ccd_consignee_country character varying(160) COLLATE public.nocase,
    ccd_np_sameas_consignee character(4) COLLATE public.nocase,
    ccd_notify_party_id character varying(72) COLLATE public.nocase,
    ccd_np_name character varying(160) COLLATE public.nocase,
    ccd_np_contact_person character varying(180) COLLATE public.nocase,
    ccd_np_address_line1 character varying(400) COLLATE public.nocase,
    ccd_np_address_line2 character varying(400) COLLATE public.nocase,
    ccd_np_address_line3 character varying(400) COLLATE public.nocase,
    ccd_np_postal_code character varying(160) COLLATE public.nocase,
    ccd_np_subzone character varying(160) COLLATE public.nocase,
    ccd_np_city character varying(160) COLLATE public.nocase,
    ccd_np_zone character varying(160) COLLATE public.nocase,
    ccd_np_state character varying(160) COLLATE public.nocase,
    ccd_np_region character varying(160) COLLATE public.nocase,
    ccd_np_country character varying(160) COLLATE public.nocase,
    ccd_np_primary_phone character varying(160) COLLATE public.nocase,
    ccd_np_secondary_phone character varying(160) COLLATE public.nocase,
    ccd_np_email_id character varying(160) COLLATE public.nocase,
    ccd_created_by character varying(120) COLLATE public.nocase,
    ccd_created_date timestamp without time zone,
    ccd_last_modified_date timestamp without time zone,
    ccd_last_modified_by character varying(120) COLLATE public.nocase,
    ccd_consignee_type_of_entry character varying(160) COLLATE public.nocase,
    ccd_timestamp integer,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);