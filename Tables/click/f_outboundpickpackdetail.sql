CREATE TABLE click.f_outboundpickpackdetail (
    pickpack_key bigint NOT NULL,
    pickpack_ordkey bigint NOT NULL,
    pickpack_lockey bigint NOT NULL,
    pickpack_ou integer,
    pickpack_sono character varying(20) COLLATE public.nocase,
    pickexecstatus character varying(20) COLLATE public.nocase,
    picklineno integer,
    pickqty numeric(21,8),
    pickemployee bigint,
    pickmechine bigint,
    pickhttflag integer,
    pickthuwgt numeric(21,8),
    packexecstatus character varying(20) COLLATE public.nocase,
    packlineno integer,
    packqty numeric(21,8),
    packtolqty numeric(21,8),
    packemployee bigint,
    pickpack_loadeddatetime timestamp without time zone DEFAULT CURRENT_DATE
);

ALTER TABLE click.f_outboundpickpackdetail ALTER COLUMN pickpack_key ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME click.f_outboundpickpackdetail_pickpack_key_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE ONLY click.f_outboundpickpackdetail
    ADD CONSTRAINT f_outboundpickpackdetail_pk PRIMARY KEY (pickpack_key);

CREATE INDEX f_outboundpickpackdetail_ndx ON click.f_outboundpickpackdetail USING btree (pickpack_ordkey);

CREATE INDEX f_outboundpickpackdetail_ndx1 ON click.f_outboundpickpackdetail USING btree (pickpack_ou, pickpack_lockey, pickpack_sono);