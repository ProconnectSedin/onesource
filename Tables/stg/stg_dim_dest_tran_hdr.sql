CREATE TABLE stg.stg_dim_dest_tran_hdr (
    tran_no character varying(72) NOT NULL COLLATE public.nocase,
    tran_ou integer NOT NULL,
    tran_type character varying(160) NOT NULL COLLATE public.nocase,
    line_no integer NOT NULL,
    ref_doc_ou integer,
    ref_doc_no character varying(72) COLLATE public.nocase,
    ref_doc_type character varying(160) COLLATE public.nocase,
    createdby character varying(120) COLLATE public.nocase,
    createddate timestamp without time zone,
    modifiedby character varying(120) COLLATE public.nocase,
    modifieddate timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);