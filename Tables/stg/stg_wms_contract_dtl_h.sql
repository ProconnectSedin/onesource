CREATE TABLE stg.stg_wms_contract_dtl_h (
    wms_cont_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_cont_lineno integer NOT NULL,
    wms_cont_ou integer NOT NULL,
    wms_cont_amendno integer NOT NULL,
    wms_cont_tariff_id character varying(72) COLLATE public.nocase,
    wms_cont_tariff_ser_id character varying(72) COLLATE public.nocase,
    wms_cont_rate numeric,
    wms_cont_min_change numeric,
    wms_cont_min_change_added character varying(32) COLLATE public.nocase,
    wms_cont_cost numeric,
    wms_cont_margin_per numeric,
    wms_cont_max_charge numeric,
    wms_cont_rate_valid_from timestamp without time zone,
    wms_cont_rate_valid_to timestamp without time zone,
    wms_cont_basic_charge numeric,
    wms_cont_val_currency character(20) COLLATE public.nocase,
    wms_cont_bill_currency character(20) COLLATE public.nocase,
    wms_cont_exchange_rate_type character varying(40) COLLATE public.nocase,
    wms_cont_discount numeric,
    wms_cont_last_day character varying(32) COLLATE public.nocase,
    wms_cont_draft_bill_grp character varying(160) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_contract_dtl_h
    ADD CONSTRAINT wms_contract_dtl_h_pk PRIMARY KEY (wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_amendno);