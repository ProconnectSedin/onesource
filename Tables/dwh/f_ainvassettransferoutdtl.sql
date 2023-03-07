-- Table: dwh.f_ainvassettransferoutdtl

-- DROP TABLE IF EXISTS dwh.f_ainvassettransferoutdtl;

CREATE TABLE IF NOT EXISTS dwh.f_ainvassettransferoutdtl
(
    ainvassettransferoutdtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ainvassettransferouthdr_key bigint NOT NULL,
    tran_type character varying(20) COLLATE public.nocase,
    tran_ou integer,
    tran_no character varying(40) COLLATE public.nocase,
    fb character varying(40) COLLATE public.nocase,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    recv_loc_code character varying(40) COLLATE public.nocase,
    recv_cost_center character varying(20) COLLATE public.nocase,
    asset_loc_code character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    confirm_date character varying(50) COLLATE public.nocase,
    confirm_status character varying(50) COLLATE public.nocase,
    dest_ouid integer,
    book_value numeric(13,2),
    exchange_rate numeric(13,2),
    tran_currency character varying(10) COLLATE public.nocase,
    remarks character varying(510) COLLATE public.nocase,
    line_no integer,
    transfer_in_no character varying(40) COLLATE public.nocase,
    transfer_in_ou integer,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_ainvassettransferoutdtl_pkey PRIMARY KEY (ainvassettransferoutdtl_key),
    CONSTRAINT f_ainvassettransferoutdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, fb, asset_number, tag_number, line_no),
    CONSTRAINT f_ainvassettransferoutdtl_ainvassettransferouthdr_key_fkey FOREIGN KEY (ainvassettransferouthdr_key)
        REFERENCES dwh.f_ainvassettransferouthdr (ainvassettransferouthdr_key) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_ainvassettransferoutdtl
    OWNER to proconnect;
-- Index: f_ainvassettransferoutdtl_key_idx1

-- DROP INDEX IF EXISTS dwh.f_ainvassettransferoutdtl_key_idx1;

CREATE INDEX IF NOT EXISTS f_ainvassettransferoutdtl_key_idx1
    ON dwh.f_ainvassettransferoutdtl USING btree
    (tran_type COLLATE public.nocase ASC NULLS LAST, tran_ou ASC NULLS LAST, tran_no COLLATE public.nocase ASC NULLS LAST, fb COLLATE public.nocase ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST, line_no ASC NULLS LAST)
    TABLESPACE pg_default;