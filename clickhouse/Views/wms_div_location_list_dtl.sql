CREATE VIEW default.wms_div_location_list_dtl
(
    `wms_div_ou` Nullable(Int32),
    `wms_div_code` Nullable(String),
    `wms_div_lineno` Nullable(Int32),
    `wms_div_loc_code` Nullable(String),
    `etlactiveind` Nullable(Int32),
    `etljobname` Nullable(String),
    `envsourcecd` Nullable(String),
    `datasourcecd` Nullable(String),
    `etlcreatedatetime` Nullable(DateTime64(6)),
    `etlupdatedatetime` Nullable(DateTime64(6))
) AS
SELECT
    div_ou AS wms_div_ou,
    div_code AS wms_div_code,
    div_lineno AS wms_div_lineno,
    div_loc_code AS wms_div_loc_code,
    etlactiveind,
    etljobname,
    envsourcecd,
    datasourcecd,
    etlcreatedatetime,
    etlupdatedatetime
FROM onesource.d_divloclist