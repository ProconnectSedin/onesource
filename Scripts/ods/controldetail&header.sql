INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('SVPDB','SQL Server','ERP Data Source','client_service_log','client_service_log','SRCtoStg','1','Incremental','Daily','Completed','onesource','stg','stg_client_service_log',NULL,NULL,'2022-12-29 11:58:41.051258','2022-12-29 11:58:41.051258',NULL,'1','DB Profile',NULL,NULL,'0',NULL,'select * from dbo.client_service_log where CAST((created_Date) AS DATE) >= <<EtlLastRunDate>>;','1','2022-12-29 14:43:44.85','10',NULL,NULL);


INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) VALUES ('onesource','PostgreSQL','PostgreSQL','client_service_log','stg_client_service_log','StgtoDW','0','Incremental','Daily','Completed','onesource','dwh','f_clientservicelog','usp_f_clientservicelog',NULL,'2022-12-29 11:58:41.071685','2022-12-29 11:58:41.071685',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2022-12-29 17:53:29.597','9',NULL,NULL);


INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) VALUES ('SVPDB','SQL Server','client_service_log','client_service_log','host:52.140.55.131;database:SVPDB;username:sedindwuser;password:Welcome@123','Operational','f_clientservicelog','Fact',NULL,'0','0','0','Completed','2022-12-29 11:58:41.010629','2022-12-29 17:53:29.59723','Super User','1','DB Profile',NULL,NULL,NULL,'0','4',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SVPDB','DW',NULL,'0',NULL);