-- PROCEDURE: dwh.usp_f_clientservicelog(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_clientservicelog(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_clientservicelog(
	IN p_sourceid character varying,
	IN p_dataflowflag character varying,
	IN p_targetobject character varying,
	OUT srccnt integer,
	OUT inscnt integer,
	OUT updcnt integer,
	OUT dltcount integer,
	INOUT flag1 character varying,
	OUT flag2 character varying)
LANGUAGE 'plpgsql'
AS $BODY$

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
    FROM stg.stg_client_service_log;

    UPDATE dwh.f_clientservicelog t
    SET
        cust_Id                        = s.cust_Id,
        client_Name                    = s.client_Name,
        service_Name                   = s.service_Name,
        service_Type                   = s.service_Type,
        client_Json                    = s.client_Json,
        status                         = s.status,
        error_Message                  = s.error_Message,
        key_Search1                    = s.key_Search1,
        key_Search2                    = s.key_Search2,
        key_Search3                    = s.key_Search3,
        key_Search4                    = s.key_Search4,
        ip_Address                     = s.ip_Address,
        created_Date                   = s.created_Date,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_client_service_log s
    WHERE	t.cust_Id			= s.cust_Id;

   GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.f_clientservicelog
    (
         cust_Id,   client_Name,    service_Name,   service_Type,   client_Json,  
           status,     error_Message,  key_Search1,    key_Search2,    key_Search3,  
             key_Search4,    ip_Address,     created_Date,etlactiveind, etljobname, 
             envsourcecd, datasourcecd, etlcreatedatetime
    )

    SELECT
        s.cust_Id,  s.client_Name,  s.service_Name,     s.service_Type,     s.client_Json,  
        s.status,   s.error_Message,   s.key_Search1,  s.key_Search2,  s.key_Search3, 
         s.key_Search4,  s.ip_Address,   s.created_Date, 1, p_etljobname,
          p_envsourcecd, p_datasourcecd, NOW()
    FROM stg.stg_client_service_log s
    LEFT JOIN dwh.f_clientservicelog t
    ON		s.cust_Id			= t.cust_Id
    WHERE	t.cust_Id IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

	
    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_client_service_log
    (
         
		  cust_Id,   client_Name,    service_Name,   service_Type,   client_Json,  
           status,     error_Message,  key_Search1,    key_Search2,    key_Search3,  
             key_Search4,    ip_Address,     created_Date,etlcreateddatetime
    )
    SELECT
          cust_Id,   client_Name,    service_Name,   service_Type,   client_Json,  
           status,     error_Message,  key_Search1,    key_Search2,    key_Search3,  
             key_Search4,    ip_Address,     created_Date,etlcreateddatetime
    FROM stg.stg_client_service_log;
    END IF;
	
	
	EXCEPTION WHEN others THEN
        get stacked diagnostics
            p_errorid   = returned_sqlstate,
            p_errordesc = message_text;
    CALL ods.usp_etlerrorinsert(p_sourceid, p_targetobject, p_dataflowflag, p_batchid,p_taskname, 'sp_ExceptionHandling', p_errorid, p_errordesc, null);
       select 0 into inscnt;
       select 0 into updcnt;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_f_clientservicelog(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
