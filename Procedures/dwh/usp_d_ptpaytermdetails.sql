-- PROCEDURE: dwh.usp_d_ptpaytermdetails(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_ptpaytermdetails(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_ptpaytermdetails(
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
    FROM stg.stg_pt_payterm_details;

    UPDATE dwh.d_ptpaytermdetails t
    SET
        pt_duedays                   = s.pt_duedays,
        pt_duepercentage             = s.pt_duepercentage,
        pt_discountdays              = s.pt_discountdays,
        pt_discountpercentage        = s.pt_discountpercentage,
        pt_penalty                   = s.pt_penalty,
        pt_per                       = s.pt_per,
        pt_timeunit                  = s.pt_timeunit,
        pt_created_by                = s.pt_created_by,
        pt_created_date              = s.pt_created_date,
        pt_modified_by               = s.pt_modified_by,
        pt_modified_date             = s.pt_modified_date,
        etlactiveind                 = 1,
        etljobname                   = p_etljobname,
        envsourcecd                  = p_envsourcecd,
        datasourcecd                 = p_datasourcecd,
        etlupdatedatetime            = NOW()
    FROM stg.stg_pt_payterm_details s
    WHERE t.pt_ouinstance 			 = s.pt_ouinstance
    AND   t.pt_paytermcode 			 = s.pt_paytermcode
    AND   t.pt_version_no 			 = s.pt_version_no
    AND   t.pt_serialno 			 = s.pt_serialno;

    GET DIAGNOSTICS updcnt = ROW_COUNT;

    INSERT INTO dwh.d_ptpaytermdetails
    (
        pt_ouinstance, 		pt_paytermcode, 		pt_version_no, 			pt_serialno, 		pt_duedays, 
		pt_duepercentage, 	pt_discountdays, 		pt_discountpercentage, 	pt_penalty, 		pt_per, 
		pt_timeunit, 		pt_created_by, 			pt_created_date, 		pt_modified_by, 	pt_modified_date, 
		etlactiveind, 		etljobname, 			envsourcecd, 			datasourcecd, 		etlcreatedatetime
    )

    SELECT
        s.pt_ouinstance, 	s.pt_paytermcode, 		s.pt_version_no, 			s.pt_serialno, 		s.pt_duedays, 
		s.pt_duepercentage, s.pt_discountdays, 		s.pt_discountpercentage, 	s.pt_penalty, 		s.pt_per, 
		s.pt_timeunit, 		s.pt_created_by, 		s.pt_created_date, 			s.pt_modified_by, 	s.pt_modified_date, 
		1, 					p_etljobname, 			p_envsourcecd, 				p_datasourcecd, 	NOW()
    FROM stg.stg_pt_payterm_details s
    LEFT JOIN dwh.d_ptpaytermdetails t
    ON  s.pt_ouinstance   	= t.pt_ouinstance
    AND s.pt_paytermcode 	= t.pt_paytermcode
    AND s.pt_version_no 	= t.pt_version_no
    AND s.pt_serialno 		= t.pt_serialno
    WHERE t.pt_ouinstance IS NULL;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_pt_payterm_details
    (
        pt_ouinstance, 		pt_paytermcode, 	pt_version_no, 			pt_serialno, 		pt_duedays, 
		pt_duepercentage, 	pt_discountdays, 	pt_discountpercentage, 	pt_penalty, 		pt_per, 
		pt_timeunit, 		pt_created_by, 		pt_created_date, 		pt_modified_by, 	pt_modified_date, 
		etlcreateddatetime
    )
    SELECT
        pt_ouinstance, 		pt_paytermcode, 	pt_version_no, 			pt_serialno, 		pt_duedays, 
		pt_duepercentage, 	pt_discountdays, 	pt_discountpercentage, 	pt_penalty, 		pt_per, 
		pt_timeunit, 		pt_created_by, 		pt_created_date, 		pt_modified_by, 	pt_modified_date, 
		etlcreateddatetime
    FROM stg.stg_pt_payterm_details;
    
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
ALTER PROCEDURE dwh.usp_d_ptpaytermdetails(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
