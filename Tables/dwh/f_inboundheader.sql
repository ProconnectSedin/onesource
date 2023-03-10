CREATE TABLE dwh.f_inboundheader (
    inb_hdr_key bigint NOT NULL,
    inb_loc_key bigint NOT NULL,
    inb_loc_code character varying(80) COLLATE public.nocase,
    inb_orderno character varying(510) COLLATE public.nocase,
    inb_ou integer,
    inb_amendno integer,
    inb_refdoctype character varying(510) COLLATE public.nocase,
    inb_refdocno character varying(40) COLLATE public.nocase,
    inb_refdocdate timestamp without time zone,
    inb_orderdate timestamp without time zone,
    inb_status character varying(20) COLLATE public.nocase,
    inb_custcode character varying(40) COLLATE public.nocase,
    inb_vendorcode character varying(40) COLLATE public.nocase,
    inb_address1 character varying(200) COLLATE public.nocase,
    inb_address2 character varying(200) COLLATE public.nocase,
    inb_address3 character varying(200) COLLATE public.nocase,
    inb_postcode character varying(80) COLLATE public.nocase,
    inb_country character varying(80) COLLATE public.nocase,
    inb_state character varying(80) COLLATE public.nocase,
    inb_city character varying(80) COLLATE public.nocase,
    inb_phoneno character varying(40) COLLATE public.nocase,
    inb_secrefdoctype1 character varying(510) COLLATE public.nocase,
    inb_secrefdoctype2 character varying(510) COLLATE public.nocase,
    inb_secrefdocno1 character varying(40) COLLATE public.nocase,
    inb_secrefdocno2 character varying(40) COLLATE public.nocase,
    inb_secrefdocdate1 timestamp without time zone,
    inb_secrefdocdate2 timestamp without time zone,
    inb_shipmode character varying(80) COLLATE public.nocase,
    inb_shiptype character varying(510) COLLATE public.nocase,
    inb_instructions character varying(510) COLLATE public.nocase,
    inb_created_by character varying(60) COLLATE public.nocase,
    inb_created_date timestamp without time zone,
    inb_modified_by character varying(60) COLLATE public.nocase,
    inb_modified_date timestamp without time zone,
    inb_timestamp integer,
    inb_operation_status character varying(20) COLLATE public.nocase,
    inb_contract_id character varying(40) COLLATE public.nocase,
    inb_contract_amend_no integer,
    inb_gen_from character varying(20) COLLATE public.nocase,
    inb_custcode_h character varying(40) COLLATE public.nocase,
    inb_type character varying(20) COLLATE public.nocase,
    inb_addr_loc_code character varying(20) COLLATE public.nocase,
    inb_consignor_code character varying(40) COLLATE public.nocase,
    inb_reason_code character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_inboundheader ALTER COLUMN inb_hdr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_inboundheader_inb_hdr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_pkey PRIMARY KEY (inb_hdr_key);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_ukey UNIQUE (inb_loc_code, inb_orderno, inb_ou);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_inboundheader_key_idx ON dwh.f_inboundheader USING btree (inb_loc_key);

CREATE INDEX f_inboundheader_key_idx1 ON dwh.f_inboundheader USING btree (inb_loc_code, inb_orderno, inb_ou);