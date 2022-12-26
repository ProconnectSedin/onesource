CREATE TABLE stg.stg_pcsit_lbh_weight_validation_tbl (
    tranou integer,
    locationcode character varying(100) COLLATE public.nocase,
    lvalue numeric,
    hvalue numeric,
    bvalue numeric,
    netwt numeric,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);