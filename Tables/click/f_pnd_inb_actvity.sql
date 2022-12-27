CREATE TABLE click.f_pnd_inb_actvity (
    pnd_inb_key bigint NOT NULL,
    ou integer,
    location_code character varying(20) NOT NULL,
    location_name character varying(510),
    customer_code character varying(40),
    order_no character varying(510),
    order_date timestamp without time zone,
    asn_no character varying(40),
    asn_date timestamp without time zone,
    order_type character varying(510),
    asn_type character varying(20),
    invoice_no character varying(40),
    invoice_date timestamp without time zone,
    asn_status character varying(510),
    grn_status character varying(20),
    gr_exec_end_date timestamp without time zone,
    putaway_status character varying(20),
    created_date timestamp without time zone,
    modified_date timestamp without time zone
);

ALTER TABLE click.f_pnd_inb_actvity ALTER COLUMN pnd_inb_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_pnd_inb_actvity_pnd_inb_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_pnd_inb_actvity
    ADD CONSTRAINT f_pnd_inb_key PRIMARY KEY (pnd_inb_key);