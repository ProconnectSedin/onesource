CREATE TABLE stg.stg_wms_eqp_grp_dtl (
    wms_egrp_ou integer NOT NULL,
    wms_egrp_id character varying(72) NOT NULL COLLATE public.nocase,
    wms_egrp_lineno integer NOT NULL,
    wms_egrp_eqp_id character varying(120) COLLATE public.nocase,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);

ALTER TABLE ONLY stg.stg_wms_eqp_grp_dtl
    ADD CONSTRAINT wms_eqp_grp_dtl_pk PRIMARY KEY (wms_egrp_ou, wms_egrp_id, wms_egrp_lineno);