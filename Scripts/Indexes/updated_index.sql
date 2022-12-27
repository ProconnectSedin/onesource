DROP INDEX IF EXISTS dwh.f_contractdetail_key_idx1;

CREATE INDEX IF NOT EXISTS f_contractdetail_key_idx1
    ON dwh.f_contractdetail USING btree
    (cont_dtl_key ASC NULLS LAST,cont_hdr_key ASC NULLS LAST )
    TABLESPACE pg_default;



DROP INDEX IF EXISTS dwh.f_contractdetail_key_idx2;
	
CREATE INDEX IF NOT EXISTS f_contractdetail_key_idx2
    ON dwh.f_contractdetail USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ))
    TABLESPACE pg_default;



DROP INDEX IF EXISTS dwh.f_asndetailhistory_key_idx;

CREATE INDEX IF NOT EXISTS f_asndetailhistory_key_idx
    ON dwh.f_asndetailhistory USING btree
    (asn_dtl_hst_key  ASC NULLS LAST,asn_hdr_hst_key ASC NULLS LAST, asn_dtl_hst_loc_key ASC NULLS LAST, asn_dtl_hst_itm_hdr_key ASC NULLS LAST, asn_dtl_hst_thu_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_asndetailhistory_key_idx3;	
	
CREATE INDEX IF NOT EXISTS f_asndetailhistory_key_idx3
    ON dwh.f_asndetailhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ))
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_contractheaderhistory_key_idx1;

CREATE INDEX IF NOT EXISTS f_contractheaderhistory_key_idx1
    ON dwh.f_contractheaderhistory USING btree
    (cont_hdr_hst_key ASC NULLS LAST, cont_hdr_hst_customer_key ASC NULLS LAST, cont_hdr_hst_datekey ASC NULLS LAST, cont_hdr_hst_loc_key ASC NULLS LAST, cont_hdr_hst_vendor_key ASC NULLS LAST, cont_hdr_hst_curr_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_contractheaderhistory_key_idx2;	
	
CREATE INDEX IF NOT EXISTS f_contractheaderhistory_key_idx2
    ON dwh.f_contractheaderhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_contractdetailhistory_key_idx1;

CREATE INDEX IF NOT EXISTS f_contractdetailhistory_key_idx1
    ON dwh.f_contractdetailhistory USING btree
    (cont_dtl_hst_key ASC NULLS LAST,cont_hdr_hst_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_contractdetailhistory_key_idx3;

CREATE INDEX IF NOT EXISTS f_contractdetailhistory_key_idx3
    ON dwh.f_contractdetailhistory USING btree
    ((coalesce(etlupdatedatetime, etlcreatedatetime)::date));
	
	
	
DROP INDEX IF EXISTS dwh.f_asnheaderhistory_key_idx;

CREATE INDEX IF NOT EXISTS f_asnheaderhistory_key_idx
    ON dwh.f_asnheaderhistory USING btree
    (asn_hdr_hst_key ASC NULLS LAST, asn_hdr_hst_loc_key ASC NULLS LAST, asn_hdr_hst_datekey ASC NULLS LAST, asn_hdr_hst_customer_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_asnheaderhistory_key_idx2;
	
CREATE INDEX IF NOT EXISTS f_asnheaderhistory_key_idx2
    ON dwh.f_asnheaderhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundschdetail_key_idx;

CREATE INDEX IF NOT EXISTS f_outboundschdetail_key_idx
    ON dwh.f_outboundschdetail USING btree
    (obd_sdl_key  ASC NULLS LAST, oub_loc_key ASC NULLS LAST, oub_itm_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundschdetail_key_idx3;	
	
CREATE INDEX IF NOT EXISTS f_outboundschdetail_key_idx3
    ON dwh.f_outboundschdetail USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_asnheader_key_idx;

CREATE INDEX IF NOT EXISTS f_asnheader_key_idx
    ON dwh.f_asnheader USING btree
    (asn_hr_key ASC NULLS LAST, asn_loc_key ASC NULLS LAST, asn_date_key ASC NULLS LAST, asn_cust_key ASC NULLS LAST, asn_supp_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_asnheader_key_idx3;
	
CREATE INDEX IF NOT EXISTS f_asnheader_key_idx3
    ON dwh.f_asnheader USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundlotsrldetail_key_idx;

CREATE INDEX IF NOT EXISTS f_outboundlotsrldetail_key_idx
    ON dwh.f_outboundlotsrldetail USING btree
    (oub_lotsl_loc_key ASC NULLS LAST,oub_loc_key ASC NULLS LAST, oub_itm_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundlotsrldetail_key_idx3;
	
CREATE INDEX IF NOT EXISTS f_outboundlotsrldetail_key_idx3
    ON dwh.f_outboundlotsrldetail USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outbounddocdetail_key_idx;
 
CREATE INDEX IF NOT EXISTS f_outbounddocdetail_key_idx
    ON dwh.f_outbounddocdetail USING btree
    (obd_dl_key ASC NULLS LAST,obd_loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outbounddocdetail_key_idx3;
	
CREATE INDEX IF NOT EXISTS f_outbounddocdetail_key_idx3
    ON dwh.f_outbounddocdetail USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_asndetails_key_idx;

CREATE INDEX IF NOT EXISTS f_asndetails_key_idx
    ON dwh.f_asndetails USING btree
    (asn_dtl_key ASC NULLS LAST,asn_hr_key ASC NULLS LAST, asn_dtl_loc_key ASC NULLS LAST, asn_dtl_itm_hdr_key ASC NULLS LAST, asn_dtl_thu_key ASC NULLS LAST, asn_dtl_uom_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_asndetails_key_idx1;
	
CREATE INDEX IF NOT EXISTS f_asndetails_key_idx1
    ON dwh.f_asndetails USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_contractheader_key_idx1;
	
CREATE INDEX IF NOT EXISTS f_contractheader_key_idx1
    ON dwh.f_contractheader USING btree
    (cont_hdr_key  ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
DROP INDEX IF EXISTS dwh.f_contractheader_key_idx2;
	
CREATE INDEX IF NOT EXISTS f_contractheader_key_idx2
    ON dwh.f_contractheader USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundheader_key_idx;

CREATE INDEX IF NOT EXISTS f_outboundheader_key_idx
    ON dwh.f_outboundheader USING btree
    (obh_hr_key ASC NULLS LAST, obh_cust_key ASC NULLS LAST, obh_loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundheader_key_idx_8;
	
CREATE INDEX IF NOT EXISTS f_outboundheader_key_idx_8
    ON dwh.f_outboundheader USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundvasheader_key_idx;

CREATE INDEX IF NOT EXISTS f_outboundvasheader_key_idx
    ON dwh.f_outboundvasheader USING btree
    (oub_vhr_key ASC NULLS LAST,oub_loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
DROP INDEX IF EXISTS dwh.f_outboundvasheader_key_idx2;
	
CREATE INDEX IF NOT EXISTS f_outboundvasheader_key_idx2
    ON dwh.f_outboundvasheader USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outbounditemdetail_key_idx;

CREATE INDEX IF NOT EXISTS f_outbounditemdetail_key_idx
    ON dwh.f_outbounditemdetail USING btree
    (obd_idl_key ASC NULLS LAST,  obd_itm_key ASC NULLS LAST, obd_loc_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
DROP INDEX IF EXISTS dwh.f_outbounditemdetail_key_idx2;
	
CREATE INDEX IF NOT EXISTS f_outbounditemdetail_key_idx2
    ON dwh.f_outbounditemdetail USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	


DROP INDEX IF EXISTS dwh.f_packexecthudetailhistory_key_idx;

CREATE INDEX IF NOT EXISTS f_packexecthudetailhistory_key_idx
    ON dwh.f_packexecthudetailhistory USING btree
    (pack_exec_thu_dtl_hst_key ASC NULLS LAST)
    TABLESPACE pg_default;

	
DROP INDEX IF EXISTS dwh.f_packexecthudetailhistory_key_idx1;

CREATE INDEX IF NOT EXISTS f_packexecthudetailhistory_key_idx1
    ON dwh.f_packexecthudetailhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ))
    TABLESPACE pg_default;
	


DROP INDEX IF EXISTS dwh.f_outboundheaderhistory_key_idx3;

CREATE INDEX IF NOT EXISTS f_outboundheaderhistory_key_idx3
    ON dwh.f_outboundheaderhistory USING btree
    (obh_hr_his_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundheaderhistory_key_idx4;
	
CREATE INDEX IF NOT EXISTS f_outboundheaderhistory_key_idx4
    ON dwh.f_outboundheaderhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outbounditemdetailhistory_key_idx3;

CREATE INDEX IF NOT EXISTS f_outbounditemdetailhistory_key_idx3
    ON dwh.f_outbounditemdetailhistory USING btree
    (obd_idl_his_key ASC NULLS LAST, obh_hr_his_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outbounditemdetailhistory_key_idx4;
	
CREATE INDEX IF NOT EXISTS f_outbounditemdetailhistory_key_idx4
    ON dwh.f_outbounditemdetailhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundlotsrldetailhistory_key_idx3;

CREATE INDEX IF NOT EXISTS f_outboundlotsrldetailhistory_key_idx3
    ON dwh.f_outboundlotsrldetailhistory USING btree
    (oub_lotsl_loc_his_key ASC NULLS LAST, obh_hr_his_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
DROP INDEX IF EXISTS dwh.f_outboundlotsrldetailhistory_key_idx4;
	
CREATE INDEX IF NOT EXISTS f_outboundlotsrldetailhistory_key_idx4
    ON dwh.f_outboundlotsrldetailhistory USING btree
    (( coalesce ( etlupdatedatetime , etlcreatedatetime ) :: date ));
	
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundschdetailhistory_key_idx3;

CREATE INDEX IF NOT EXISTS f_outboundschdetailhistory_key_idx3
    ON dwh.f_outboundschdetailhistory USING btree
    (obd_sdl_his_key ASC NULLS LAST,obh_hr_his_key ASC NULLS LAST)
    TABLESPACE pg_default;
	
	
	
DROP INDEX IF EXISTS dwh.f_outboundschdetailhistory_key_idx;

CREATE INDEX IF NOT EXISTS f_outboundschdetailhistory_key_idx
    ON dwh.f_outboundschdetailhistory USING btree
    ((COALESCE(etlupdatedatetime, etlcreatedatetime)::date) ASC NULLS LAST)
    TABLESPACE pg_default;
