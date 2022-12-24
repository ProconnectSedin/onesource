CREATE TABLE raw.raw_wms_asn_add_dtl (
    raw_id bigint NOT NULL,
    wms_asn_pop_asn_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_asn_pop_loc character varying(40) NOT NULL COLLATE public.nocase,
    wms_asn_pop_ou integer NOT NULL,
    wms_asn_pop_line_no integer NOT NULL,
    wms_asn_pop_date_1 timestamp without time zone,
    wms_asn_pop_date_2 timestamp without time zone,
    wms_asn_pop_ud_1 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_2 character varying(1020) COLLATE public.nocase,
    wms_asn_pop_ud_3 character varying(1020) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);