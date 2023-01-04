DO $$
BEGIN   
IF NOT EXISTS (SELECT 1 FROM ods.controlheader WHERE sourceid = 'cdcn_dcnote_hdr') THEN INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) VALUES ('scmdb','SQL Server','cdcn_dcnote_hdr','cdcn_dcnote_hdr','host:52.140.55.131;database:scmdb;username:sedindwuser;password:Welcome@123','Finance','F_cdcndcnotehdr','Fact',NULL,'0','0','0','Completed','2022-12-30 01:14:36.015359','2023-01-04 10:02:36.532724','Super User','1','DB Profile',NULL,NULL,NULL,'0','4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'cdcn_dcnote_hdr' and dataflowflag = 'srctostg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','cdcn_dcnote_hdr','cdcn_dcnote_hdr','SRCtoStg','1','Incremental','Daily','Completed','onesource','stg','stg_cdcn_dcnote_hdr',NULL,NULL,'2022-12-30 01:14:36.423333','2022-12-30 01:14:36.423333',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from dbo.cdcn_dcnote_hdr where isnull(modifieddate,createddate) >= <<EtlLastRunDate>>;',NULL,'2019-01-01','14',NULL,NULL); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'cdcn_dcnote_hdr' and dataflowflag = 'stgtodw') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','cdcn_dcnote_hdr','stg_cdcn_dcnote_hdr','StgtoDW','0','Incremental','Daily','Completed','onesource','dwh','F_cdcndcnotehdr','usp_F_cdcndcnotehdr',NULL,'2022-12-30 01:14:36.673813','2022-12-30 01:14:36.673813',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,NULL,'2023-01-04 10:02:36.533','14',NULL,NULL); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controlheader WHERE sourceid = 'cdcn_item_dtl') THEN INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) VALUES ('scmdb','SQL Server','cdcn_item_dtl','cdcn_item_dtl','host:52.140.55.131;database:scmdb;username:sedindwuser;password:Welcome@123','Finance','F_cdcnitemdtl','Fact',NULL,'0','0','0','Completed','2022-12-30 01:18:31.507169','2023-01-04 10:02:43.032854','Super User','1','DB Profile',NULL,NULL,NULL,'0','4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'cdcn_item_dtl' and dataflowflag = 'srctostg') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('scmdb','SQL Server','ERP Data Source','cdcn_item_dtl','cdcn_item_dtl','SRCtoStg','1','Incremental','Daily','Completed','onesource','stg','stg_cdcn_item_dtl',NULL,NULL,'2022-12-30 01:18:31.558622','2022-12-30 01:18:31.558622',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from dbo.cdcn_item_dtl;',NULL,'2019-01-01','14',NULL,NULL); END IF;

IF NOT EXISTS (SELECT 1 FROM ods.controldetail WHERE sourceid = 'cdcn_item_dtl' and dataflowflag = 'stgtodw') THEN INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','cdcn_item_dtl','stg_cdcn_item_dtl','StgtoDW','0','Incremental','Daily','Completed','onesource','dwh','F_cdcnitemdtl','usp_F_cdcnitemdtl',NULL,'2022-12-30 01:18:31.651665','2022-12-30 01:18:31.651665',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,NULL,'2023-01-04 10:02:43.033','14',NULL,NULL); END IF;

END$$;