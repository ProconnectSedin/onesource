
DO $$

begin

IF NOT EXISTS
 (
   SELECT 1 FROM ods.controlheader
   WHERE sourceid = 'wmpnps'
) 
THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) 
VALUES ('excel','Excel','wmpnps','wmpnps','/datadisk/Source Files/pending/','Operational','f_wmpnps','Dimension',NULL,'0','0','0','Completed','2023-02-01 11:03:16.049','2023-02-01 12:21:37.913684','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);

 END IF;




IF NOT EXISTS 
     (
      SELECT 1 FROM ods.controldetail 
      WHERE sourceid = 'wmpnps'
     ) 

THEN 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('excel','Excel','ERP Data Source','wmpnps','wmpnps.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_wmpnps',NULL,NULL,'2023-02-01 11:02:07.592','2023-02-01 11:02:07.592',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-02-01 11:58:06.761','1',NULL,NULL); 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) 
VALUES ('onesource','PostgreSQL','PostgreSQL','wmpnps','stg_wmpnps','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpnps','usp_f_wmpnps',NULL,'2023-02-01 11:02:07.592','2023-02-01 11:02:07.592',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-02-01 12:21:37.914','1',NULL,NULL); 

END IF;

 



IF NOT EXISTS
 (
   SELECT 1 FROM ods.controlheader
 WHERE sourceid = 'WMPSecurityGadgets'
  ) 
THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup)
 VALUES ('excel','Excel','wmpsecuritygadgets','wmpsecuritygadgets','/datadisk/Source Files/pending/','Operational','f_wmpsecuritygadgets','Dimesnion',NULL,'0','0','0','Completed','2023-01-31 18:55:44.158','2023-01-31 19:11:55.46413','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);
 
END IF;

IF NOT EXISTS
      (
	SELECT 1 FROM ods.controldetail 
        WHERE sourceid = 'WMPSecurityGadgets'
      ) 

THEN 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('excel','Excel','ERP Data Source','wmpsecuritygadgets','wmpsecuritygadgets.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_wmpsecuritygadgets',NULL,NULL,'2023-01-31 18:54:34.621','2023-01-31 18:54:34.621',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-01-31 18:58:35.311','1',NULL,NULL);

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('onesource','PostgreSQL','PostgreSQL','wmpsecuritygadgets','stg_wmpsecuritygadgets','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpsecuritygadgets','usp_f_wmpsecuritygadgets',NULL,'2023-01-31 18:54:34.621','2023-01-31 18:54:34.621',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-01-31 19:11:55.464','1',NULL,NULL);

 END IF;

IF NOT EXISTS 
   (
    SELECT 1 FROM ods.controlheader 
    WHERE sourceid = 'Wmpaccidentfreedays'
   ) 
THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup)
 VALUES ('excel','Excel','wmpaccidentfreedays','wmpaccidentfreedays','/datadisk/Source Files/pending/','Operational','f_wmpaccidentfreedays','Dimension',NULL,'0','0','0','Completed','2023-01-31 18:06:22.996','2023-01-31 18:19:47.501836','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);

 END IF;

IF NOT EXISTS 
	(
	 SELECT 1 FROM ods.controldetail
	 WHERE sourceid = 'Wmpaccidentfreedays'
	) 

THEN 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) 
VALUES ('excel','Excel','ERP Data Source','wmpaccidentfreedays','wmpaccidentfreedays.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_wmpaccidentfreedays','null',NULL,'2023-01-31 18:04:08.135','2023-01-31 18:04:08.135',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-01-31 18:07:59.517','1',NULL,NULL); 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('onesource','PostgreSQL','PostgreSQL','wmpaccidentfreedays','stg_wmpaccidentfreedays','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpaccidentfreedays','usp_f_wmpaccidentfreedays',NULL,'2023-01-31 18:04:08.136','2023-01-31 18:04:08.136',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-01-31 18:19:47.502','1',NULL,NULL); 

END IF;

IF NOT EXISTS 
    (
     SELECT 1 FROM ods.controlheader 
     WHERE sourceid = 'WmpCustomerClaims'
    ) 

THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) 
VALUES ('excel','Excel','wmpcustomerclaims','wmpcustomerclaims','/datadisk/Source Files/pending/','Operational','f_wmpcustomerclaims','Dimension',NULL,'0','0','0','Completed','2023-01-31 17:09:31.445','2023-01-31 18:37:25.96546','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);

 END IF;

IF NOT EXISTS 
	(
	 SELECT 1 FROM ods.controldetail
	 WHERE sourceid = 'WmpCustomerClaims'
	)

 THEN 

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('excel','Excel','ERP Data Source','wmpcustomerclaims','wmpcustomerclaims.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_wmpcustomerclaims','null',NULL,'2023-01-31 17:07:31.848','2023-01-31 17:07:31.848',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-01-31 18:32:41.434','3',NULL,NULL);

INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays) 
VALUES ('onesource','PostgreSQL','PostgreSQL','wmpcustomerclaims','stg_wmpcustomerclaims','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpcustomerclaims','usp_f_wmpcustomerclaims',NULL,'2023-01-31 17:07:31.848','2023-01-31 17:07:31.848',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-01-31 18:37:25.965','2',NULL,NULL); 
 END IF;

IF NOT EXISTS
    (
      SELECT 1 FROM ods.controlheader
      WHERE sourceid = 'wmpmonthlystockcount'
    )

 THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup) 
VALUES ('excel','Excel','wmpmonthlystockcount','wmpmonthlystockcount','/datadisk/Source Files/pending/','Operational','f_wmpmonthlystockcount','Dimension',NULL,'0','0','0','Completed','2023-01-31 15:23:58.392','2023-01-31 18:37:25.48254','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);

 END IF;

IF NOT EXISTS 
	(
	SELECT 1 FROM ods.controldetail
	 WHERE sourceid = 'wmpmonthlystockcount'
	)

 THEN

 INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('onesource','PostgreSQL','PostgreSQL','wmpmonthlystockcount','stg_wmpmonthlystockcount','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpmonthlystockcount','usp_f_wmpmonthlystockcount',NULL,'2023-01-31 15:22:42.427','2023-01-31 15:22:42.427',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-01-31 18:37:25.483','5',NULL,NULL); 

 INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('excel','Excel','ERP Data Source','wmpmonthlystockcount','wmpmonthlystockcount.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_wmpmonthlystockcount',NULL,NULL,'2023-01-31 15:22:42.426','2023-01-31 15:22:42.426',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-01-31 18:32:41.285','2',NULL,NULL); 

END IF;

IF NOT EXISTS
     (
      SELECT 1 FROM ods.controlheader
      WHERE sourceid = 'WmpDCProfit'
     )

 THEN 

INSERT INTO ods.controlheader(sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,rawstorageflag,sourcegroup)
 VALUES ('excel','Excel','wmpdcprofit','wmpdcprofit','/datadisk/Source Files/pending/','Operational','f_wmpdcprofit','Dimension',NULL,'0','0','0','Completed','2023-01-31 13:00:39.046','2023-01-31 18:37:24.742066','Super User','1','DB Profile',NULL,NULL,NULL,'0','1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'SCMDB','DW',NULL,'1',NULL);

 END IF;

IF NOT EXISTS 
	(
	SELECT 1 FROM ods.controldetail
	 WHERE sourceid = 'WmpDCProfit'
	) 
THEN

 INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('excel','Excel','ERP Data Source','wmpdcprofit','f_wmpdcprofit.xlsx','SRCtoStg','1',NULL,'Daily','Completed','onesource','stg','stg_f_wmpdcprofit',NULL,NULL,'2023-01-31 12:56:26.986','2023-01-31 12:56:26.986',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'1','2023-01-31 18:32:41.143','5',NULL,NULL); 


 INSERT INTO ods.controldetail(sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,latestbatchid,executiontype,intervaldays)
 VALUES ('onesource','PostgreSQL','PostgreSQL','wmpdcprofit','stg_f_wmpdcprofit','StgtoDW','0',NULL,'Daily','Completed','onesource','dwh','f_wmpdcprofit','usp_f_wmpdcprofit',NULL,'2023-01-31 12:56:26.986','2023-01-31 12:56:26.986',NULL,'1','DB Profile',NULL,NULL,'0',NULL,NULL,'2','2023-01-31 18:37:24.742','4',NULL,NULL); 

END IF;




IF NOT EXISTS(SELECT 1 FROM ods.dwhtoclickcontroldtl
			  WHERE OBJECTNAME in
			  (
			  'usp_f_wmpnps','usp_f_wmpsecuritygadgets','usp_f_wmpaccidentfreedays',
			   'usp_f_wmpcustomerclaims','usp_f_wmpmonthlystockcount','usp_f_wmpdcprofit'
			  )
			  )
			  
Then			  

insert into ods.dwhtoclickcontroldtl
(objecttype, objectname, executionflag, seqexecution,loadtype, loadfrequency)
values 
			  
('Fact', 'usp_f_wmpnps', '1', '1', 'Truncate and reload', 'always'),
('Fact', 'usp_f_wmpmonthlystockcount', '1', '1', 'Truncate and reload', 'always'),
('Fact', 'usp_f_wmpsecuritygadgets', '1', '1', 'Truncate and reload', 'always'),
('Fact', 'usp_f_wmpaccidentfreedays', '1', '1', 'Truncate and reload', 'always'),
('Fact', 'usp_f_wmpcustomerclaims', '1', '1', 'Truncate and reload', 'always'),
('Fact', 'usp_f_wmpdcprofit', '1', '1', 'Truncate and reload', 'always');
END IF;	

END$$;



