CREATE TABLE IF NOT EXISTS "raw".raw_sin_2wpo_gr_aplan_upd_info
(
    raw_id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    po_type character varying(20) COLLATE public.nocase,
    po_ou integer,
    po_no character varying(36) COLLATE public.nocase,
    po_amend_no integer,
    po_line_no integer,
    po_qty numeric(13,2),
    grinv_type character varying(20) COLLATE public.nocase,
    grinv_sequence_no integer,
    grinv_ou integer,
    grinv_no character varying(36) COLLATE public.nocase,
    grinv_line_no integer,
    grinv_qty numeric(13,2),
    grinv_aplan_upd_qty numeric(13,2),
    grinv_aplan_bal_upd_qty numeric(13,2),
    proposal_no character varying(36) COLLATE public.nocase,
    cwip_acc_no character varying(64) COLLATE public.nocase,
    inv_po_amount numeric(13,2),
    inv_tran_amount numeric(13,2),
    etlcreatedatetime timestamp(3) without time zone,
    CONSTRAINT raw_sin_2wpo_gr_aplan_upd_info_pkey PRIMARY KEY (raw_id)
)
