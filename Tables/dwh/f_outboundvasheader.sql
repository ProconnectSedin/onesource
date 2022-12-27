CREATE TABLE dwh.f_outboundvasheader (
    oub_vhr_key bigint NOT NULL,
    obh_hr_key bigint NOT NULL,
    oub_loc_key bigint NOT NULL,
    oub_loc_code character varying(20) COLLATE public.nocase,
    oub_ou integer,
    oub_outbound_ord character varying(40) COLLATE public.nocase,
    oub_lineno integer,
    oub_vas_id character varying(40) COLLATE public.nocase,
    oub_instructions character varying(510) COLLATE public.nocase,
    oub_sequence integer,
    oub_created_by character varying(60) COLLATE public.nocase,
    oub_modified_by character varying(60) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_outboundvasheader ALTER COLUMN oub_vhr_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_outboundvasheader_oub_vhr_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_pkey PRIMARY KEY (oub_vhr_key);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_ukey UNIQUE (oub_loc_code, oub_ou, oub_outbound_ord, oub_lineno);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_outboundvasheader_key_idx ON dwh.f_outboundvasheader USING btree (oub_loc_key);

CREATE INDEX f_outboundvasheader_key_idx1 ON dwh.f_outboundvasheader USING btree (oub_ou, oub_loc_code, oub_outbound_ord, oub_lineno);