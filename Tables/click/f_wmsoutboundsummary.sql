CREATE TABLE click.f_wmsoutboundsummary (
    wms_ob_key bigint NOT NULL,
    oub_ou integer,
    oub_customerkey bigint,
    oub_datekey bigint,
    oub_locationkey bigint,
    oub_loccode character varying(20) COLLATE public.nocase,
    oub_custcode character varying(20) COLLATE public.nocase,
    oub_primrfdctyp character varying(510) COLLATE public.nocase,
    oub_ordertype character varying(80) COLLATE public.nocase,
    oub_obstatus character varying(20) COLLATE public.nocase,
    oub_shipmentmode character varying(80) COLLATE public.nocase,
    oub_orderdate date,
    oub_shipmenttype character varying(510) COLLATE public.nocase,
    oub_subservicetype character varying(510) COLLATE public.nocase,
    oub_state character varying(80) COLLATE public.nocase,
    oub_city character varying(80) COLLATE public.nocase,
    oub_postcode character varying(80) COLLATE public.nocase,
    oub_totoutboundord bigint,
    oub_totoutboundline bigint,
    oub_totordqty numeric(21,8),
    oub_totbalqty numeric(21,8),
    oub_totisuqty numeric(21,8),
    oub_totprosqty numeric(21,8),
    oub_totoutboundvol numeric(21,8),
    oub_totoutboundwgt numeric(21,8),
    oub_wavestatus character varying(20) COLLATE public.nocase,
    oub_waveallocrule character varying(20) COLLATE public.nocase,
    oub_pickexecstatus character varying(20) COLLATE public.nocase,
    oub_packexecstatus character varying(20) COLLATE public.nocase,
    oub_waveqty numeric(21,8),
    oub_totpickline bigint,
    oub_totpickqty numeric(21,8),
    oub_totpickhht bigint,
    oub_totpickemp bigint,
    oub_totpickmechines bigint,
    oub_totpickthuwgt numeric(21,8),
    oub_totpackline bigint,
    oub_totpackqty numeric(21,8),
    oub_totpacktolqty numeric(21,8),
    oub_totpackemp bigint
);

ALTER TABLE click.f_wmsoutboundsummary ALTER COLUMN wms_ob_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_wmsoutboundsummary_wms_ob_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_wmsoutboundsummary
    ADD CONSTRAINT f_wmsoutboundsummary_pkey PRIMARY KEY (wms_ob_key);