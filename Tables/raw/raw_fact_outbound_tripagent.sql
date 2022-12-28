CREATE TABLE raw.raw_fact_outbound_tripagent (
    raw_id bigint NOT NULL,
    surrogatekey character varying(400) NOT NULL COLLATE public.nocase,
    tran_type character varying(100) NOT NULL COLLATE public.nocase,
    refkey character varying(400) NOT NULL COLLATE public.nocase,
    agent_ou integer NOT NULL,
    agent_location character varying(200) COLLATE public.nocase,
    dispatch_doc_n0 character varying(400) COLLATE public.nocase,
    trip_plan_id character varying(400) COLLATE public.nocase,
    thu_line_no character varying(600) COLLATE public.nocase,
    thu_agent_qty numeric,
    thu_agent_weight numeric,
    thu_agent_volume numeric,
    ag_ref_doc_type character varying(400) COLLATE public.nocase,
    ag_ref_doc_no character varying(400) COLLATE public.nocase,
    ag_ref_doc_date timestamp without time zone,
    agent_remarks character varying(400) COLLATE public.nocase,
    thu_agent_qty_uom character varying(400) COLLATE public.nocase,
    thu_agent_weight_uom character varying(200) COLLATE public.nocase,
    thu_agent_volume_uom character varying(200) COLLATE public.nocase,
    created_by character varying(600) COLLATE public.nocase,
    creation_date timestamp without time zone,
    last_modified_by character varying(600) COLLATE public.nocase,
    last_modified_date timestamp without time zone,
    dispatch_doc_type character varying(200) COLLATE public.nocase,
    dispatch_doc_mode character varying(200) COLLATE public.nocase,
    dispatch_doc_num_type character varying(200) COLLATE public.nocase,
    dispatch_doc_status character varying(200) COLLATE public.nocase,
    dispatch_doc_date timestamp without time zone,
    transport_mode character varying(200) COLLATE public.nocase,
    reference_doc_type character varying(200) COLLATE public.nocase,
    reference_doc_no character varying(200) COLLATE public.nocase,
    customer_id character varying(200) COLLATE public.nocase,
    cust_ref_no character varying(200) COLLATE public.nocase,
    ship_from_id character varying(200) COLLATE public.nocase,
    ship_to_id character varying(200) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE raw.raw_fact_outbound_tripagent ALTER COLUMN raw_id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME raw.raw_fact_outbound_tripagent_raw_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY raw.raw_fact_outbound_tripagent
    ADD CONSTRAINT raw_fact_outbound_tripagent_pkey PRIMARY KEY (raw_id);