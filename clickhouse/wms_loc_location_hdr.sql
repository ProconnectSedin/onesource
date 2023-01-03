CREATE VIEW default.wms_loc_location_hdr
(
    `wms_loc_ou` Nullable(Int32),
    `wms_loc_code` Nullable(String),
    `wms_loc_desc` Nullable(String),
    `wms_loc_status` Nullable(String),
    `wms_loc_type` Nullable(String),
    `wms_reason_code` Nullable(String),
    `wms_finance_book` Nullable(String),
    `wms_costcenter` Nullable(String),
    `wms_address1` Nullable(String),
    `wms_address2` Nullable(String),
    `wms_country` Nullable(String),
    `wms_state` Nullable(String),
    `wms_city` Nullable(String),
    `wms_zip_code` Nullable(String),
    `wms_contperson` Nullable(String),
    `wms_contact_no` Nullable(String),
    `wms_time_zone_id` Nullable(String),
    `wms_loc_lat` Nullable(Decimal(18, 2)),
    `wms_loc_long` Nullable(Decimal(18, 2)),
    `wms_timestamp` Nullable(Int32),
    `wms_created_by` Nullable(String),
    `wms_created_dt` Nullable(DateTime64(6)),
    `wms_modified_by` Nullable(String),
    `wms_modified_dt` Nullable(DateTime64(6)),
    `wms_def_plan_mode` Nullable(String),
    `wms_loc_shp_point` Nullable(String),
    `wms_loc_cubing` Nullable(Int32),
    `wms_blanket_count_sa` Nullable(Int32),
    `wms_enable_uid_prof` Nullable(Int32),
    `wms_loc_linked_hub` Nullable(String),
    `wms_loc_enable_bin_chkbit` Nullable(Int32),
    `etlactiveind` Nullable(Int32),
    `etljobname` Nullable(String),
    `envsourcecd` Nullable(String),
    `datasourcecd` Nullable(String),
    `etlcreatedatetime` Nullable(DateTime64(6)),
    `etlupdatedatetime` Nullable(DateTime64(6))
) AS
SELECT
    loc_ou AS wms_loc_ou,
    loc_code AS wms_loc_code,
    loc_desc AS wms_loc_desc,
    loc_status AS wms_loc_status,
    loc_type AS wms_loc_type,
    reason_code AS wms_reason_code,
    finance_book AS wms_finance_book,
    costcenter AS wms_costcenter,
    address1 AS wms_address1,
    address2 AS wms_address2,
    country AS wms_country,
    state AS wms_state,
    city AS wms_city,
    zip_code AS wms_zip_code,
    contperson AS wms_contperson,
    contact_no AS wms_contact_no,
    time_zone_id AS wms_time_zone_id,
    loc_lat AS wms_loc_lat,
    loc_long AS wms_loc_long,
    ltimestamp AS wms_timestamp,
    created_by AS wms_created_by,
    created_dt AS wms_created_dt,
    modified_by AS wms_modified_by,
    modified_dt AS wms_modified_dt,
    def_plan_mode AS wms_def_plan_mode,
    loc_shp_point AS wms_loc_shp_point,
    loc_cubing AS wms_loc_cubing,
    blanket_count_sa AS wms_blanket_count_sa,
    enable_uid_prof AS wms_enable_uid_prof,
    loc_linked_hub AS wms_loc_linked_hub,
    loc_enable_bin_chkbit AS wms_loc_enable_bin_chkbit,
    etlactiveind,
    etljobname,
    envsourcecd,
    datasourcecd,
    etlcreatedatetime,
    etlupdatedatetime
FROM onesource.d_location