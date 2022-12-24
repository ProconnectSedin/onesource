CREATE TABLE tmp.f_testing (
    tled_ouinstance integer,
    tled_trip_plan_id character varying,
    tled_trip_plan_line_no character varying,
    tled_bkr_id character varying,
    tled_leg_no integer,
    actualtripstart timestamp without time zone,
    actualarrived timestamp without time zone,
    actualhandedover timestamp without time zone,
    actualtakenover timestamp without time zone,
    actualpickdepart timestamp without time zone,
    actualdeliverydepart timestamp without time zone,
    actualtripend timestamp without time zone,
    actualdatekey bigint
);