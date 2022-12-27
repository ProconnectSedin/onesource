CREATE TABLE tmp.f_triplogthudetail_tmp (
    tltd_ouinstance integer,
    tltd_trip_plan_id character varying(40),
    tltd_trip_sequence integer,
    tltd_dispatch_doc_no character varying(40),
    tltd_trip_plan_line_id character varying(300),
    tltd_volume numeric(25,2),
    tltd_volume_uom character varying(40)
);

CREATE INDEX f_triplogthudetail_tmp_ndx ON tmp.f_triplogthudetail_tmp USING btree (tltd_ouinstance, tltd_trip_plan_id, tltd_trip_sequence, tltd_trip_plan_line_id);