CREATE TABLE tmp.f_triplogeventdetail_pln (
    tled_ouinstance integer,
    tled_trip_plan_id character varying,
    tled_trip_plan_line_no character varying,
    tled_bkr_id character varying,
    tled_leg_no integer,
    plannedtripstart timestamp without time zone,
    plannedarrived timestamp without time zone,
    plannedhandedover timestamp without time zone,
    plannedtakenover timestamp without time zone,
    plannedpickdepart timestamp without time zone,
    planneddeliverydepart timestamp without time zone,
    plannedtripend timestamp without time zone
);