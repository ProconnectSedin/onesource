CREATE TABLE raw.raw_pcsit_gate_invoice (
    raw_id bigint NOT NULL,
    gate_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    gate_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    gate_ou integer NOT NULL,
    consignee character varying(200) COLLATE public.nocase,
    invoice_number character varying(200) NOT NULL COLLATE public.nocase,
    invoice_value numeric,
    docket_no character varying(200) COLLATE public.nocase,
    ewaybill_number character varying(200) COLLATE public.nocase,
    box_count integer,
    created_date timestamp without time zone DEFAULT now(),
    created_by character varying(50) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);