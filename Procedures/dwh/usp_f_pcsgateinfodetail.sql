CREATE OR REPLACE PROCEDURE dwh.usp_f_pcsgateinfodetail(IN p_sourceid character varying, IN p_dataflowflag character varying, IN p_targetobject character varying, OUT srccnt integer, OUT inscnt integer, OUT updcnt integer, OUT dltcount integer, INOUT flag1 character varying, OUT flag2 character varying)
    LANGUAGE plpgsql
    AS $$

DECLARE
    p_etljobname VARCHAR(100);
    p_envsourcecd VARCHAR(50);
    p_datasourcecd VARCHAR(50);
    p_batchid integer;
    p_taskname VARCHAR(100);
    p_packagename  VARCHAR(100);
    p_errorid integer;
    p_errordesc character varying;
    p_errorline integer;
    p_rawstorageflag integer;

BEGIN
    SELECT d.jobname, h.envsourcecode, h.datasourcecode, d.latestbatchid, d.targetprocedurename, h.rawstorageflag
    INTO p_etljobname, p_envsourcecd, p_datasourcecd, p_batchid, p_taskname, p_rawstorageflag
    FROM ods.controldetail d
    INNER JOIN ods.controlheader h
        ON d.sourceid = h.sourceid
    WHERE d.sourceid = p_sourceId
        AND d.dataflowflag = p_dataflowflag
        AND d.targetobject = p_targetobject;

    SELECT COUNT(1) INTO srccnt
    FROM stg.stg_pcsit_gateinfo_dtl;

    UPDATE dwh.F_PCSGateInfoDetail t
    SET
        datekey					= COALESCE(d.datekey,-1),
		orderno                	= s.orderno,
        Gateno                 	= s.Gateno,
        ewayno                 	= s.ewayno,
        ewaydate               	= s.ewaydate,
        awbno                  	= s.awbno,
        Drivername             	= s.Drivername,
        contactno              	= s.contactno,
        vehno                  	= s.vehno,
        driverlicenseno        	= s.driverlicenseno,
        transporter            	= s.transporter,
        isnno                  	= s.isnno,
        createdby              	= s.createdby,
        createddate            	= s.createddate,
        etlactiveind           	= 1,
        etljobname             	= p_etljobname,
        envsourcecd            	= p_envsourcecd,
        datasourcecd           	= p_datasourcecd,
        etlupdatedatetime      	= NOW()
    FROM stg.stg_pcsit_gateinfo_dtl s
	LEFT JOIN dwh.d_date d
		ON CAST(s.ewaydate AS DATE)	= d.dateactual
    WHERE  t.id                 	= s.id;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.F_PCSGateInfoDetail
    (
        datekey, id, orderno, Gateno, ewayno, ewaydate, awbno, Drivername, contactno, vehno, driverlicenseno, transporter, isnno, createdby, createddate, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        COALESCE(d.datekey,-1), s.id, s.orderno, s.Gateno, s.ewayno, s.ewaydate, s.awbno, s.Drivername, s.contactno, s.vehno, s.driverlicenseno, s.transporter, s.isnno, s.createdby, s.createddate, 1, p_etljobname, p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_pcsit_gateinfo_dtl s
	LEFT JOIN dwh.d_date d
		ON CAST(s.ewaydate AS DATE)	= d.dateactual	
    LEFT JOIN dwh.F_PCSGateInfoDetail t
		ON t.id						= s.id
    WHERE t.id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_pcsit_gateinfo_dtl
    (
        id, orderno, Gateno, ewayno, ewaydate, awbno, Drivername, contactno, vehno, driverlicenseno, transporter, isnno, createdby, createddate, etlcreateddatetime
    )
    SELECT
        id, orderno, Gateno, ewayno, ewaydate, awbno, Drivername, contactno, vehno, driverlicenseno, transporter, isnno, createdby, createddate, etlcreateddatetime
    FROM stg.stg_pcsit_gateinfo_dtl;
    
    END IF;
    EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$$;