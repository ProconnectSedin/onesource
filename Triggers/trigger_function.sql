CREATE OR REPLACE FUNCTION ods.controlheaderaudit() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (TG_OP = 'INSERT') THEN
    INSERT INTO
        ods.controlheaderaudit(id,sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,
                              dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,
                              lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,
                              archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,
                              apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,
                              rawstorageflag,sourcegroup,eventname)
                    VALUES	(new.id,			 new.sourcename, new.sourcetype,	new.sourcedescription,new.sourceid,new.connectionstr,new.adlscontainername,
                             new.dwobjectname,	 new.objecttype, new.dldirstructure,new.dlpurgeflag,new.dwpurgeflag,new.ftpcheck,new.status,new.createddate,
                             new.lastupdateddate,new.createduser,new.isapplicable,	new.profilename,new.emailto,new.archcondition,new.depsource,
                             new.archintvlcond,	 new.sourcecallingseq,new.apiurl,	new.apimethod,new.apiauthorizationtype,new.apiaccesstoken,
                             new.apipymodulename,new.apiqueryparameters,new.apirequestbody,new.envsourcecode,new.datasourcecode,new.sourcedelimiter,
                             new.rawstorageflag, new.sourcegroup,tg_op);

      RETURN new;
      ELSIF (TG_OP = 'UPDATE') THEN
          INSERT INTO
        ods.controlheaderaudit(id,sourcename,sourcetype,sourcedescription,sourceid,connectionstr,adlscontainername,
                              dwobjectname,objecttype,dldirstructure,dlpurgeflag,dwpurgeflag,ftpcheck,status,createddate,
                              lastupdateddate,createduser,isapplicable,profilename,emailto,archcondition,depsource,
                              archintvlcond,sourcecallingseq,apiurl,apimethod,apiauthorizationtype,apiaccesstoken,
                              apipymodulename,apiqueryparameters,apirequestbody,envsourcecode,datasourcecode,sourcedelimiter,
                              rawstorageflag,sourcegroup,eventname)
                    VALUES	(old.id,			 old.sourcename, old.sourcetype,	old.sourcedescription,old.sourceid,old.connectionstr,old.adlscontainername,
                             old.dwobjectname,	 old.objecttype, old.dldirstructure,old.dlpurgeflag,old.dwpurgeflag,old.ftpcheck,old.status,old.createddate,
                             old.lastupdateddate,old.createduser,old.isapplicable,	old.profilename,old.emailto,old.archcondition,old.depsource,
                             old.archintvlcond,	 old.sourcecallingseq,old.apiurl,	old.apimethod,old.apiauthorizationtype,old.apiaccesstoken,
                             old.apipymodulename,old.apiqueryparameters,old.apirequestbody,old.envsourcecode,old.datasourcecode,old.sourcedelimiter,
                             old.rawstorageflag, old.sourcegroup,tg_op);

      RETURN old;
      END IF;
END;
$BODY$
language plpgsql;







CREATE OR REPLACE FUNCTION ods.controldetailaudit() RETURNS TRIGGER AS
$BODY$
BEGIN
    IF (TG_OP = 'INSERT') THEN
    INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES	(new.id, new.sourcename, new.sourcetype,	new.sourcedescription,new.sourceid,new.sourceobject,new.dataflowflag,
                             new.isreadyforexecution,	 new.loadtype, new.loadfrequency,new.flowstatus,new.targetname,new.targetschemaname,new.targetobject,new.targetprocedurename,
                             new.jobname,new.createddate,new.lastupdateddate,	new.createduser,new.isapplicable,new.profilename,new.emailto,
                             new.archcondition,	 new.isdecomreq,new.archintvlcond,	new.sourcequery,new.sourcecallingseq,new.etllastrundate,
                             new.latestbatchid,new.executiontype,new.intervaldays,tg_op);

      RETURN new;
      ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES	(old.id, old.sourcename, old.sourcetype,	old.sourcedescription,old.sourceid,old.sourceobject,old.dataflowflag,
                             old.isreadyforexecution,	 old.loadtype, old.loadfrequency,old.flowstatus,old.targetname,old.targetschemaname,old.targetobject,old.targetprocedurename,
                             old.jobname,old.createddate,old.lastupdateddate,	old.createduser,old.isapplicable,old.profilename,old.emailto,
                             old.archcondition,	 old.isdecomreq,old.archintvlcond,	old.sourcequery,old.sourcecallingseq,old.etllastrundate,
                             old.latestbatchid,old.executiontype,old.intervaldays,tg_op);
     RETURN old;
     END IF;
END;
$BODY$
language plpgsql;


