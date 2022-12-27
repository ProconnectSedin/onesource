CREATE TABLE public.table1 (
    id integer NOT NULL,
    name character varying
);

ALTER TABLE ONLY public.table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);