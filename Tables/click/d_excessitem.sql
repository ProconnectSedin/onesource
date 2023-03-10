CREATE TABLE click.d_excessitem (
    ex_itm_key bigint NOT NULL,
    ex_itm_ou integer,
    ex_itm_code character varying(80) COLLATE public.nocase,
    ex_itm_loc_code character varying(20) COLLATE public.nocase,
    ex_itm_desc character varying(300) COLLATE public.nocase,
    ex_itm_cap_profile character varying(20) COLLATE public.nocase,
    ex_itm_zone_profile character varying(20) COLLATE public.nocase,
    ex_itm_stage_profile character varying(40) COLLATE public.nocase,
    ex_itm_effective_frm timestamp without time zone,
    ex_itm_effective_to timestamp without time zone,
    ex_itm_pick_per_tol_pos numeric(13,2),
    ex_itm_pick_per_tol_neg numeric(13,2),
    ex_itm_pick_uom_tol_pos numeric(13,2),
    ex_itm_pick_uom_tol_neg numeric(13,2),
    ex_itm_mininum_qty numeric(13,2),
    ex_itm_maximum_qty numeric(13,2),
    ex_itm_replen_qty numeric(13,2),
    ex_itm_master_uom character varying(20),
    ex_itm_timestamp integer,
    ex_itm_created_by character varying(60) COLLATE public.nocase,
    ex_itm_created_dt timestamp without time zone,
    ex_itm_modified_by character varying(60) COLLATE public.nocase,
    ex_itm_modified_dt timestamp without time zone,
    ex_itm_packing_bay character varying(40) COLLATE public.nocase,
    ex_itm_low_stk_lvl numeric(13,2),
    ex_itm_std_strg_thu_id character varying(80) COLLATE public.nocase,
    ex_itm_wave_repln_req character varying(80) COLLATE public.nocase,
    etlactiveind integer,
    etljobname character varying(200) COLLATE public.nocase,
    envsourcecd character varying(50) COLLATE public.nocase,
    datasourcecd character varying(50) COLLATE public.nocase,
    etlcreatedatetime timestamp(3) without time zone,
    etlupdatedatetime timestamp(3) without time zone
);

ALTER TABLE ONLY click.d_excessitem
    ADD CONSTRAINT d_excessitem_pkey PRIMARY KEY (ex_itm_key);

ALTER TABLE ONLY click.d_excessitem
    ADD CONSTRAINT d_excessitem_ukey UNIQUE (ex_itm_code, ex_itm_loc_code, ex_itm_ou);

CREATE INDEX d_excessitem_idx ON click.d_excessitem USING btree (ex_itm_ou, ex_itm_code, ex_itm_loc_code);