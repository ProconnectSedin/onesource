CREATE TABLE dwh.d_daily_stock_balance (
    row_id integer NOT NULL,
    wms_stock_date timestamp without time zone,
    wms_stock_location character varying(50),
    wms_stock_zone character varying(50),
    wms_stock_bin_type character varying(50),
    wms_stock_bin character varying(50),
    wms_stock_in_qty integer,
    wms_stock_out_qty integer,
    stk_balance integer,
    created_date timestamp without time zone,
    aging_in_days integer
);