CREATE VIEW default.wms_geo_state_dtl
(
    `wms_geo_country_code` String,
    `wms_geo_state_code` Nullable(String),
    `wms_geo_state_ou` Nullable(Int32),
    `wms_geo_state_lineno` Nullable(Int32),
    `wms_geo_state_desc` Nullable(String),
    `wms_geo_state_timezn` Nullable(String),
    `wms_geo_state_status` Nullable(String),
    `wms_geo_state_rsn` Nullable(String),
    `ge_holidays` Nullable(String),
    `wms_ge_holidays` Nullable(Int32),
    `etljobname` Nullable(String),
    `envsourcecd` Nullable(String),
    `datasourcecd` Nullable(String),
    `etlcreatedatetime` Nullable(DateTime64(6)),
    `etlupdatedatetime` Nullable(DateTime64(6))
) AS
SELECT
    geo_country_code AS wms_geo_country_code,
    geo_state_code AS wms_geo_state_code,
    geo_state_ou AS wms_geo_state_ou,
    geo_state_lineno AS wms_geo_state_lineno,
    geo_state_desc AS wms_geo_state_desc,
    geo_state_timezn AS wms_geo_state_timezn,
    geo_state_status AS wms_geo_state_status,
    geo_state_rsn AS wms_geo_state_rsn,
    ge_holidays AS ge_holidays,
    etlactiveind AS wms_ge_holidays,
    etljobname,
    envsourcecd,
    datasourcecd,
    etlcreatedatetime,
    etlupdatedatetime
FROM onesource.d_geostatedetail