CREATE FUNCTION ods.controldetailaudit() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
    INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES  (new.id, new.sourcename, new.sourcetype,    new.sourcedescription,new.sourceid,new.sourceobject,new.dataflowflag,
                             new.isreadyforexecution,    new.loadtype, new.loadfrequency,new.flowstatus,new.targetname,new.targetschemaname,new.targetobject,new.targetprocedurename,
                             new.jobname,new.createddate,new.lastupdateddate,   new.createduser,new.isapplicable,new.profilename,new.emailto,
                             new.archcondition,  new.isdecomreq,new.archintvlcond,  new.sourcequery,new.sourcecallingseq,new.etllastrundate,
                             new.latestbatchid,new.executiontype,new.intervaldays,tg_op);

      RETURN new;
      ELSIF (TG_OP = 'UPDATE') THEN
      INSERT INTO
        ods.controldetailaudit(id,sourcename,sourcetype,sourcedescription,sourceid,sourceobject,dataflowflag,
                              isreadyforexecution,loadtype,loadfrequency,flowstatus,targetname,targetschemaname,targetobject,targetprocedurename,
                              jobname,createddate,lastupdateddate,createduser,isapplicable,profilename,emailto,
                              archcondition,isdecomreq,archintvlcond,sourcequery,sourcecallingseq,etllastrundate,
                              latestbatchid,executiontype,intervaldays,eventname)
                    VALUES  (old.id, old.sourcename, old.sourcetype,    old.sourcedescription,old.sourceid,old.sourceobject,old.dataflowflag,
                             old.isreadyforexecution,    old.loadtype, old.loadfrequency,old.flowstatus,old.targetname,old.targetschemaname,old.targetobject,old.targetprocedurename,
                             old.jobname,old.createddate,old.lastupdateddate,   old.createduser,old.isapplicable,old.profilename,old.emailto,
                             old.archcondition,  old.isdecomreq,old.archintvlcond,  old.sourcequery,old.sourcecallingseq,old.etllastrundate,
                             old.latestbatchid,old.executiontype,old.intervaldays,tg_op);
     RETURN old;
     END IF;
END;
$$;