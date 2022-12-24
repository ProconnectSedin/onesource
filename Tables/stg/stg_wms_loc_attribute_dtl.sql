CREATE TABLE stg.stg_wms_loc_attribute_dtl (
    wms_loc_attr_loc_code character varying(100) NOT NULL,
    wms_loc_attr_lineno integer NOT NULL,
    wms_loc_attr_ou integer NOT NULL,
    wms_loc_attr_typ character varying(100),
    wms_loc_attr_apl character varying(100),
    wms_loc_attr_value character varying(100),
    etlcreateddate timestamp without time zone
);