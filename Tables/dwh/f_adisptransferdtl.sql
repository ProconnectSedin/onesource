-- Table: dwh.f_adisptransferdtl

-- DROP TABLE IF EXISTS dwh.f_adisptransferdtl;

CREATE TABLE IF NOT EXISTS dwh.f_adisptransferdtl
(
    adisp_transfer_dtl_key bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    transfer_number character varying(40) COLLATE public.nocase,
    ou_id integer,
    asset_number character varying(40) COLLATE public.nocase,
    tag_number integer,
    "timestamp" integer,
    asset_grp character varying(50) COLLATE public.nocase,
    asset_class character varying(40) COLLATE public.nocase,
    asset_location character varying(40) COLLATE public.nocase,
    cost_center character varying(20) COLLATE public.nocase,
    asset_cost numeric(25,2),
    cum_depr_amount numeric(25,2),
    asset_book_value numeric(25,2),
    remarks character varying(200) COLLATE public.nocase,
    receiving_location character varying(40) COLLATE public.nocase,
    receiving_cost_center character varying(20) COLLATE public.nocase,
    receipt_remarks character varying(200) COLLATE public.nocase,
    transfer_status character varying(50) COLLATE public.nocase,
    createdby character varying(60) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(60) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    line_no integer,
    transfer_in_no character varying(40) COLLATE public.nocase,
    exchange_rate numeric(25,2),
    tran_currency character varying(10) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone,
    CONSTRAINT f_adisptransferdtl_pkey PRIMARY KEY (adisp_transfer_dtl_key),
    CONSTRAINT f_adisptransferdtl_ukey UNIQUE (transfer_number, ou_id, asset_number, tag_number)
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS dwh.f_adisptransferdtl
    OWNER to proconnect;
-- Index: f_adisptransferdtl_key_idx

-- DROP INDEX IF EXISTS dwh.f_adisptransferdtl_key_idx;

CREATE INDEX IF NOT EXISTS f_adisptransferdtl_key_idx
    ON dwh.f_adisptransferdtl USING btree
    (transfer_number COLLATE public.nocase ASC NULLS LAST, ou_id ASC NULLS LAST, asset_number COLLATE public.nocase ASC NULLS LAST, tag_number ASC NULLS LAST)
    TABLESPACE pg_default;