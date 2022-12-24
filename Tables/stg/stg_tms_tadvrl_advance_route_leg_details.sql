CREATE TABLE stg.stg_tms_tadvrl_advance_route_leg_details (
    tadvrl_ouinstance integer,
    tadvrl_br_id character varying(72) COLLATE public.nocase,
    tadvrl_br_route_id character varying(72) COLLATE public.nocase,
    tadvrl_br_leg_id character varying(72) COLLATE public.nocase,
    tadvrl_leg_behaviour character varying(160) COLLATE public.nocase,
    tadvrl_leg_seq integer,
    tadvrl_guid character varying(512) COLLATE public.nocase,
    tadvrl_timestamp integer,
    tadvrl_created_by character varying(120) COLLATE public.nocase,
    tadvrl_created_date timestamp without time zone,
    tadvrl_last_modified_by character varying(120) COLLATE public.nocase,
    tadvrl_last_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);