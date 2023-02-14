CREATE TABLE IF NOT EXISTS stg.stg_sin_2wpo_gr_aplan_upd_info
(
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
    etlcreatedatetime timestamp(3) without time zone
)