IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_dtl_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_contract_dtl_w','wms_contract_dtl','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_contract_dtl',NULL,NULL,'2022-12-22 16:53:07.536754','2022-12-22 16:53:07.536754',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_contract_dtl where CAST(isnull(wms_cont_modified_dt,wms_cont_created_dt) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:12:21.786','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_dtl_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_contract_dtl_w','stg_wms_contract_dtl','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_contractdetail','usp_f_contractdetailWeekly',NULL,'2022-12-22 16:53:07.794237','2022-12-22 16:53:07.794237',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:23:48.297','3',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_detail_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_asn_detail_h_w','wms_asn_detail_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_asn_detail_h',NULL,NULL,'2022-12-22 17:42:00.217078','2022-12-22 17:42:00.217078',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_asn_detail_h d inner join wms_asn_header_h h on h.wms_asn_ou = d.wms_asn_ou and h.wms_asn_location = d.wms_asn_location and h.wms_asn_no = d.wms_asn_no and h.wms_asn_amendno = d.wms_asn_amendno where CAST(isnull(h.wms_asn_modified_date,h.wms_asn_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:23:14.655','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_detail_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_asn_detail_h_w','stg_wms_asn_detail_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_ASNDetailHistory','usp_f_asndetailhistoryWeekly',NULL,'2022-12-22 17:42:00.243542','2022-12-22 17:42:00.243542',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:23:20.8','2',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_hdr_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_contract_hdr_h_w','wms_contract_hdr_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_contract_hdr_h',NULL,NULL,'2022-12-22 17:09:55.196709','2022-12-22 17:09:55.196709',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_contract_hdr_h where CAST(isnull(wms_cont_modified_dt,wms_cont_created_dt) AS DATE) >=  CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 17:57:55.964','3',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_hdr_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_contract_hdr_h_w','stg_wms_contract_hdr_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_ContractHeaderHistory','usp_f_contractheaderhistoryWeekly',NULL,'2022-12-22 17:09:55.326825','2022-12-22 17:09:55.326825',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 17:59:58.621','3',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_header_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_asn_header_h_w','wms_asn_header_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_asn_header_h',NULL,NULL,'2022-12-22 17:04:02.795185','2022-12-22 17:04:02.795185',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select   * from wms_asn_header_h where CAST(isnull(wms_asn_modified_date,wms_asn_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 18:28:08.877','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_header_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_asn_header_h_w','stg_wms_asn_header_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_ASNHeaderHistory','usp_f_asnheaderhistoryweekly',NULL,'2022-12-22 17:04:02.947681','2022-12-22 17:04:02.947681',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:28:18.664','2',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_dtl_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_contract_dtl_h_w','wms_contract_dtl_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_contract_dtl_h',NULL,NULL,'2022-12-22 17:49:01.654163','2022-12-22 17:49:01.654163',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_contract_dtl_h d inner join wms_contract_hdr_h h on h.wms_cont_id = d.wms_cont_id and h.wms_cont_ou = d.wms_cont_ou and h.wms_cont_amendno = d.wms_cont_amendno where CAST(isnull(h.wms_cont_modified_dt,h.wms_cont_created_dt) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:41:16.779','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_dtl_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_contract_dtl_h_w','stg_wms_contract_dtl_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_ContractDetailHistory','usp_f_contractdetailhistoryWeekly',NULL,'2022-12-22 17:49:02.297631','2022-12-22 17:49:02.297631',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:41:36.078','2',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_sch_dtl_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_sch_dtl_w','wms_outbound_sch_dtl','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_sch_dtl',NULL,NULL,'2022-12-22 17:36:34.239881','2022-12-22 17:36:34.239881',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_sch_dtl d join wms_outbound_header h on d.wms_oub_sch_loc_code = h.wms_oub_loc_code and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord and d.wms_oub_sch_ou = h.wms_oub_ou where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:26:10.5','3',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_sch_dtl_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_sch_dtl_w','stg_wms_outbound_sch_dtl','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundSchDetail','usp_f_outboundschdetailWeekly',NULL,'2022-12-22 17:36:34.263991','2022-12-22 17:36:34.263991',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:28:09.828','4',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_header_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_asn_header_w','wms_asn_header','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_asn_header',NULL,NULL,'2022-12-22 17:16:12.82574','2022-12-22 17:16:12.82574',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_asn_header where CAST(isnull(wms_asn_modified_date,wms_asn_created_date) AS DATE) >=CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 17:40:58.837','1',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_header_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_asn_header_w','stg_wms_asn_header','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_asnheader','usp_f_asnheaderWeekly',NULL,'2022-12-22 17:16:12.95327','2022-12-22 17:16:12.95327',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 17:42:34.44','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_lot_ser_dtl_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_lot_ser_dtl_w','wms_outbound_lot_ser_dtl','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_lot_ser_dtl',NULL,NULL,'2022-12-22 17:59:46.618272','2022-12-22 17:59:46.618272',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_lot_ser_dtl d  join wms_outbound_header h  on d.wms_oub_lotsl_loc_code = h.wms_oub_loc_code   and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord  and d.wms_oub_lotsl_ou = h.wms_oub_ou where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:17:45.678','1',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_lot_ser_dtl_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_lot_ser_dtl_w','stg_wms_outbound_lot_ser_dtl','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundLotSrlDetail','usp_f_outboundLotSrlDetailWeekly',NULL,'2022-12-22 17:59:46.665751','2022-12-22 17:59:46.665751',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:24:26.065','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_doc_detail_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_doc_detail_w','wms_outbound_doc_detail','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_doc_detail',NULL,NULL,'2022-12-22 17:49:04.715733','2022-12-22 17:49:04.715733',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_doc_detail d join wms_outbound_header h on d.wms_oub_doc_ou = h.wms_oub_ou and d.wms_oub_doc_loc_code = h.wms_oub_loc_code and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 18:40:55.633','1',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_doc_detail_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_doc_detail_w','stg_wms_outbound_doc_detail','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundDocDetail','usp_f_outboundDocDetailWeekly',NULL,'2022-12-22 17:49:05.52024','2022-12-22 17:49:05.52024',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:51:03.539','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_detail_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_asn_detail_w','wms_asn_detail','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_asn_detail',NULL,NULL,'2022-12-22 15:44:46.397514','2022-12-22 15:44:46.397514',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_asn_detail d inner join wms_asn_header h on h.wms_asn_ou = d.wms_asn_ou and h.wms_asn_location = d.wms_asn_location and h.wms_asn_no = d.wms_asn_no where CAST(isnull(h.wms_asn_modified_date,h.wms_asn_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-26 13:09:59.072','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_asn_detail_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_asn_detail_w','stg_wms_asn_detail','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_asndetails','usp_f_asndetailsweekly',NULL,'2022-12-22 15:44:47.232029','2022-12-22 15:44:47.232029',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-26 13:11:21.909','3',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_hdr_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_contract_hdr_w','wms_contract_hdr','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_contract_hdr',NULL,NULL,'2022-12-22 16:06:33.383233','2022-12-22 16:06:33.383233',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_contract_hdr  where CAST(isnull(wms_cont_modified_dt,wms_cont_created_dt) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);;','1','2022-12-23 18:08:32.449','3',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_contract_hdr_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_contract_hdr_w','stg_wms_contract_hdr','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_contractheader','usp_f_contractheaderweekly',NULL,'2022-12-22 16:06:33.451744','2022-12-22 16:06:33.451744',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:08:45.471','4',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_header_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_header_w','wms_outbound_header','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_header',NULL,NULL,'2022-12-22 17:06:11.205081','2022-12-22 17:06:11.205081',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_outbound_header  where CAST(isnull(wms_oub_modified_date,wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 17:57:55.013','1',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_header_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_header_w','stg_wms_outbound_header','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundheader','usp_f_outboundheaderWeekly',NULL,'2022-12-22 17:06:11.32112','2022-12-22 17:06:11.32112',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 17:59:54.034','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_vas_hdr_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_vas_hdr_w','wms_outbound_vas_hdr','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_vas_hdr',NULL,NULL,'2022-12-22 17:14:50.518101','2022-12-22 17:14:50.518101',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_vas_hdr d  join wms_outbound_header h on d.wms_oub_loc_code = h.wms_oub_loc_code   and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord and d.wms_oub_ou = h.wms_oub_ou  where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 17:58:13.865','1',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_vas_hdr_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_vas_hdr_w','stg_wms_outbound_vas_hdr','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundvasheader','usp_f_outboundvasheaderWeekly',NULL,'2022-12-22 17:14:50.576637','2022-12-22 17:14:50.576637',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:00:36.109','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_item_detail_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_item_detail_w','wms_outbound_item_detail','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_item_detail',NULL,NULL,'2022-12-22 17:40:21.838697','2022-12-22 17:40:21.838697',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_item_detail d  join wms_outbound_header h  on d.wms_oub_itm_loc_code = h.wms_oub_loc_code   and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord  and d.wms_oub_itm_ou = h.wms_oub_ou where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 18:40:51.375','1',NULL,'7'); END IF;	
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_item_detail_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_item_detail_w','stg_wms_outbound_item_detail','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outbounditemdetail','usp_f_outbounditemdetailWeekly',NULL,'2022-12-22 17:40:21.880908','2022-12-22 17:40:21.880908',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:49:20.108','1',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_pack_exec_thu_dtl_hist_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_pack_exec_thu_dtl_hist_w','wms_pack_exec_thu_dtl_hist','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_pack_exec_thu_dtl_hist',NULL,NULL,'2022-12-22 17:06:29.684147','2022-12-22 17:06:29.684147',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from wms_pack_exec_thu_dtl_hist h  where CAST(h.wms_pack_created_date AS DATE ) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 18:38:40.706','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_pack_exec_thu_dtl_hist_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_pack_exec_thu_dtl_hist_w','stg_wms_pack_exec_thu_dtl_hist','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_PackExecTHUDetailHistory','USP_F_PackExecTHUDetailHistoryWeekly',NULL,'2022-12-22 17:06:29.718035','2022-12-22 17:06:29.718035',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:50:56.997','2',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_header_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_header_h_w','wms_outbound_header_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_header_h',NULL,NULL,'2022-12-22 16:01:14.156279','2022-12-22 16:01:14.156279',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select  * from wms_outbound_header_h where CAST(isnull(wms_oub_modified_date,wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 17:55:42.338','5',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_header_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_header_h_w','stg_wms_outbound_header_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_OutboundHeaderHistory','USP_F_OutboundHeaderHistoryWeekly',NULL,'2022-12-22 16:01:14.67667','2022-12-22 16:01:14.67667',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 17:59:55.196','3',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_item_detail_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_item_detail_h_w','wms_outbound_item_detail_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_item_detail_h',NULL,NULL,'2022-12-22 17:13:28.337443','2022-12-22 17:13:28.337443',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_item_detail_h d join wms_outbound_header_h h on d.wms_oub_itm_loc_code = h.wms_oub_loc_code and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord and d.wms_oub_itm_ou = h.wms_oub_ou and d.wms_oub_itm_amendno=h.wms_oub_amendno where CAST(isnull(h.wms_oub_modified_date,h.wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 18:38:43.255','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_item_detail_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_item_detail_h_w','stg_wms_outbound_item_detail_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_OutboundItemDetailHistory','USP_F_OutboundItemDetailHistoryWeekly',NULL,'2022-12-22 17:13:28.635821','2022-12-22 17:13:28.635821',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 18:51:01.769','4',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_lot_ser_dtl_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_lot_ser_dtl_h_w','wms_outbound_lot_ser_dtl_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_lot_ser_dtl_h',NULL,NULL,'2022-12-22 17:33:51.331973','2022-12-22 17:33:51.331973',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_lot_ser_dtl_h d join wms_outbound_header_h h on d.wms_oub_lotsl_loc_code = h.wms_oub_loc_code and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord and d.wms_oub_lotsl_ou = h.wms_oub_ou and d.wms_oub_lotsl_amendno = h.wms_oub_amendno where CAST(isnull(wms_oub_modified_date,wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:12:22.553','4',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_lot_ser_dtl_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_lot_ser_dtl_h_w','stg_wms_outbound_lot_ser_dtl_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','f_outboundlotsrldetailhistory','usp_f_outboundlotsrldetailhistoryweekly',NULL,'2022-12-22 17:33:52.04147','2022-12-22 17:33:52.04147',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:23:48.474','3',NULL,'7'); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_sch_dtl_h_w' and dataflowflag = 'SRCtoStg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','wms_outbound_sch_dtl_h_w','wms_outbound_sch_dtl_h','SRCtoStg','1','Incremental','Weekly','Completed','onesource','stg','stg_wms_outbound_sch_dtl_h',NULL,NULL,'2022-12-22 15:29:46.463574','2022-12-22 15:29:46.463574',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select d.* from wms_outbound_sch_dtl_h d join wms_outbound_header_h h on d.wms_oub_sch_loc_code = h.wms_oub_loc_code and d.wms_oub_outbound_ord =h.wms_oub_outbound_ord  and d.wms_oub_sch_ou = h.wms_oub_ou and d.wms_oub_sch_amendno = h.wms_oub_amendno where CAST(isnull(wms_oub_modified_date,wms_oub_created_date) AS DATE) >= CAST(DATEADD(DD,-<<intervaldays>>,getdate()) AS DATE);','1','2022-12-23 19:12:11.982','2',NULL,'7'); END IF;
IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'wms_outbound_sch_dtl_h_w' and dataflowflag = 'StgtoDW') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','wms_outbound_sch_dtl_h_w','stg_wms_outbound_sch_dtl_h','StgtoDW','0','Incremental','Weekly','Completed','onesource','dwh','F_OutboundSchDetailHistory','USP_F_OutboundSchDetailHistoryWeekly',NULL,'2022-12-22 15:29:46.886087','2022-12-22 15:29:46.886087',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-23 19:23:46.155','3',NULL,'7'); END IF;

