CREATE TABLE stg.stg_wms_pack_exec_thu_hdr (
    wms_pack_loc_code character varying(40) NOT NULL COLLATE public.nocase,
    wms_pack_exec_no character varying(72) NOT NULL COLLATE public.nocase,
    wms_pack_exec_ou integer NOT NULL,
    wms_pack_thu_id character varying(160) NOT NULL COLLATE public.nocase,
    wms_pack_thu_class character varying(160) COLLATE public.nocase,
    wms_pack_thu_sr_no character varying(112) NOT NULL COLLATE public.nocase,
    wms_pack_thu_account character varying(160) COLLATE public.nocase,
    wms_pack_thu_consumable character varying(160) COLLATE public.nocase,
    wms_pack_thu_qty numeric,
    wms_pack_thu_weight numeric,
    wms_pack_thu_weight_uom character varying(40) COLLATE public.nocase,
    wms_pack_thu_su character varying(40) COLLATE public.nocase,
    wms_pack_thu_su_chk integer,
    wms_pack_uid1_ser_no character varying(112) COLLATE public.nocase,
    wms_pack_thuspace numeric,
    wms_pack_length numeric,
    wms_pack_breadth numeric,
    wms_pack_height numeric,
    wms_pack_uom character varying(40) COLLATE public.nocase,
    wms_pack_volumeuom character varying(40) COLLATE public.nocase,
    wms_pack_volume numeric,
    wms_pack_itm_serno_pkplan character varying(72) COLLATE public.nocase,
    wms_pack_itemslno character varying(112) COLLATE public.nocase,
    wms_pack_thu_id2 character varying(160) COLLATE public.nocase,
    wms_pack_thu_sr_no2 character varying(112) COLLATE public.nocase,
    wms_packing_combination integer,
    wms_thu_max_pack_qty numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_pack_exec_thu_hdr
    ADD CONSTRAINT wms_pack_exec_thu_hdr_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_sr_no);

CREATE INDEX stg_wms_pack_exec_thu_hdr_idx_uom ON stg.stg_wms_pack_exec_thu_hdr USING btree (wms_pack_exec_ou, wms_pack_uom);

CREATE INDEX stg_wms_pack_exec_thu_hdr_key_idx2 ON stg.stg_wms_pack_exec_thu_hdr USING btree (wms_pack_exec_ou, wms_pack_loc_code, wms_pack_exec_no, wms_pack_thu_id, wms_pack_thu_sr_no);