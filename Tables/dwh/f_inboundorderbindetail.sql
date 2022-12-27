CREATE TABLE dwh.f_inboundorderbindetail (
    in_ord_bin_dtl_key bigint NOT NULL,
    in_ord_hdr_key bigint NOT NULL,
    inb_loc_key bigint NOT NULL,
    in_ord_location character varying(20) COLLATE public.nocase,
    in_ord_no character varying(40) COLLATE public.nocase,
    in_ord_lineno integer,
    in_ord_ou integer,
    in_ord_item character varying(40) COLLATE public.nocase,
    in_ord_bin_qty numeric(132,0),
    in_ord_source_bin character varying(20) COLLATE public.nocase,
    in_ord_target_bin character varying(20) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE dwh.f_inboundorderbindetail ALTER COLUMN in_ord_bin_dtl_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME dwh.f_inboundorderbindetail_in_ord_bin_dtl_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_pkey PRIMARY KEY (in_ord_bin_dtl_key);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_ukey UNIQUE (in_ord_location, in_ord_no, in_ord_lineno, in_ord_ou);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_in_ord_hdr_key_fkey FOREIGN KEY (in_ord_hdr_key) REFERENCES dwh.f_internalorderheader(in_ord_hdr_key);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

CREATE INDEX f_inboundorderbindetail_key_idx ON dwh.f_inboundorderbindetail USING btree (inb_loc_key);

CREATE INDEX f_inboundorderbindetail_key_idx1 ON dwh.f_inboundorderbindetail USING btree (in_ord_location, in_ord_no, in_ord_lineno, in_ord_ou);