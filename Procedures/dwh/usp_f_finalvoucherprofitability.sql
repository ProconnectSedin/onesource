-- PROCEDURE: dwh.usp_f_finalvoucherprofitability(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_f_finalvoucherprofitability(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_f_finalvoucherprofitability(
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
    FROM stg.stg_final_voucher_profitability;
/*
    UPDATE dwh.f_finalvoucherprofitability t
    SET
        SNo                            = s.SNo,
        CompanyCode                    = s.CompanyCode,
        CompanyName                    = s.CompanyName,
        TranOU                         = s.TranOU,
        TranOUName                     = s.TranOUName,
        FinancialYear                  = s.FinancialYear,
        FinancialPeriod                = s.FinancialPeriod,
        LocationCustomerCode           = s.LocationCustomerCode,
        LocationCode                   = s.LocationCode,
        LocationName                   = s.LocationName,
        CustomerCode                   = s.CustomerCode,
        CustomerName                   = s.CustomerName,
        CustomerType                   = s.CustomerType,
        CustomerNameGroup              = s.CustomerNameGroup,
        CustomerBusinessType           = s.CustomerBusinessType,
        PCSBusinessType                = s.PCSBusinessType,
        OperationRegionName            = s.OperationRegionName,
        SalesRegionName                = s.SalesRegionName,
        SpaceSqFt                      = s.SpaceSqFt,
        WarehouseClass                 = s.WarehouseClass,
        LocationCity                   = s.LocationCity,
        LocationState                  = s.LocationState,
        CityType                       = s.CityType,
        Level1                         = s.Level1,
        Level2                         = s.Level2,
        Level3                         = s.Level3,
        ERPCostCenterCode              = s.ERPCostCenterCode,
        ERPCostCenterDesc              = s.ERPCostCenterDesc,
        BillingType                    = s.BillingType,
        TransType                      = s.TransType,
        RevenueNormal                  = s.RevenueNormal,
        RevenueECom                    = s.RevenueECom,
        RevenueCorporate               = s.RevenueCorporate,
        RevenueManagement              = s.RevenueManagement,
        DirectExpensesNormal           = s.DirectExpensesNormal,
        DirectExpensesECom             = s.DirectExpensesECom,
        Expenses9999                   = s.Expenses9999,
        Expenses8888                   = s.Expenses8888,
        OprnExpensesNorthIDN           = s.OprnExpensesNorthIDN,
        OprnExpensesEastIDN            = s.OprnExpensesEastIDN,
        OprnExpensesWestIDN            = s.OprnExpensesWestIDN,
        OprnExpensesSouthIDN           = s.OprnExpensesSouthIDN,
        OprnExpensesNorthIDE           = s.OprnExpensesNorthIDE,
        OprnExpensesEastIDE            = s.OprnExpensesEastIDE,
        OprnExpensesWestIDE            = s.OprnExpensesWestIDE,
        OprnExpensesSouthIDE           = s.OprnExpensesSouthIDE,
        RDExpenses                     = s.RDExpenses,
        BDExpensesNorth                = s.BDExpensesNorth,
        BDExpensesEast                 = s.BDExpensesEast,
        BDExpensesWest                 = s.BDExpensesWest,
        BDExpensesSouth                = s.BDExpensesSouth,
        CorporateExpenses              = s.CorporateExpenses,
        TransExpenses                  = s.TransExpenses,
        ManagementExpenses             = s.ManagementExpenses,
        UnallocatedExpenses            = s.UnallocatedExpenses,
        Is_Published                   = s.Is_Published,
        LOCATIONCODE_V                 = s.LOCATIONCODE_V,
        CUSTOMERCODE_V                 = s.CUSTOMERCODE_V,
        FINANCIALPERIOD_V              = s.FINANCIALPERIOD_V,
        TRANSTYPE_V                    = s.TRANSTYPE_V,
        TranOU_V                       = s.TranOU_V,
        LEVEL_1_V                      = s.LEVEL_1_V,
        LEVEL_2_V                      = s.LEVEL_2_V,
        LEVEL_3_V                      = s.LEVEL_3_V,
        COSTCENTER_V                   = s.COSTCENTER_V,
        DOCUMENTNO                     = s.DOCUMENTNO,
        DOCUMENTDATE                   = s.DOCUMENTDATE,
        ACCOUNTCODE                    = s.ACCOUNTCODE,
        ACCOUNTDESC                    = s.ACCOUNTDESC,
        BASEAMOUNT                     = s.BASEAMOUNT,
        ALLOCATEDAMOUNT                = s.ALLOCATEDAMOUNT,
        ROW_NUM                        = s.ROW_NUM,
        ROW_NUM_1                      = s.ROW_NUM_1,
        ROW_NUM_2                      = s.ROW_NUM_2,
        ROW_NUM_3                      = s.ROW_NUM_3,
        ROW_NUM_4                      = s.ROW_NUM_4,
        ROW_NUM_5                      = s.ROW_NUM_5,
        ROW_NUM_6                      = s.ROW_NUM_6,
        ROW_NUM_7                      = s.ROW_NUM_7,
        ROW_NUM_8                      = s.ROW_NUM_8,
        ROW_NUM_9                      = s.ROW_NUM_9,
        ROW_NUM_10                     = s.ROW_NUM_10,
        ROW_NUM_11                     = s.ROW_NUM_11,
        ROW_NUM_12                     = s.ROW_NUM_12,
        ROW_NUM_13                     = s.ROW_NUM_13,
        ROW_NUM_14                     = s.ROW_NUM_14,
        ROW_NUM_15                     = s.ROW_NUM_15,
        ROW_NUM_16                     = s.ROW_NUM_16,
        ROW_NUM_17                     = s.ROW_NUM_17,
        ROW_NUM_18                     = s.ROW_NUM_18,
        ROW_NUM_19                     = s.ROW_NUM_19,
        ROW_NUM_20                     = s.ROW_NUM_20,
        ROW_NUM_21                     = s.ROW_NUM_21,
        ROW_NUM_22                     = s.ROW_NUM_22,
        ROW_NUM_23                     = s.ROW_NUM_23,
        ROW_NUM_24                     = s.ROW_NUM_24,
        ROW_NUM_25                     = s.ROW_NUM_25,
        SERVICE_TYPE                   = s.SERVICE_TYPE,
        BILLINGTYPE_UPDATED            = s.BILLINGTYPE_UPDATED,
        Customer_Creation_Month        = s.Customer_Creation_Month,
        Customer_Creation_Year         = s.Customer_Creation_Year,
        Customer_Name_Group            = s.Customer_Name_Group,
        SalesRegion                    = s.SalesRegion,
        etlactiveind                   = 1,
        etljobname                     = p_etljobname,
        envsourcecd                    = p_envsourcecd,
        datasourcecd                   = p_datasourcecd,
        etlupdatedatetime              = NOW()
    FROM stg.stg_final_voucher_profitability s
    WHERE ;

    GET DIAGNOSTICS updcnt = ROW_COUNT;
*/
	SELECT 0 INTO updcnt;

	DELETE FROM dwh.f_finalvoucherprofitability 
	WHERE RIGHT(FinancialPeriod,2) >= RIGHT((EXTRACT(YEAR FROM NOW())- 1)::CHARACTER VARYING,2);

	INSERT INTO dwh.f_finalvoucherprofitability
    (
		company_key				, loc_key				, customer_key			, opcoa_key				,
        SNo						, CompanyCode			, CompanyName			, TranOU				, TranOUName			, FinancialYear, 
		FinancialPeriod			, LocationCustomerCode	, LocationCode			, LocationName			, CustomerCode			, CustomerName, 
		CustomerType			, CustomerNameGroup		, CustomerBusinessType	, PCSBusinessType		, OperationRegionName	, SalesRegionName, 
		SpaceSqFt				, WarehouseClass		, LocationCity			, LocationState			, CityType				, Level1,
		Level2					, Level3				, ERPCostCenterCode		, ERPCostCenterDesc		, BillingType			, TransType, 
		RevenueNormal			, RevenueECom			, RevenueCorporate		, RevenueManagement		, DirectExpensesNormal	, 
		DirectExpensesECom		, Expenses9999			, Expenses8888			, OprnExpensesNorthIDN	, OprnExpensesEastIDN	, OprnExpensesWestIDN,
		OprnExpensesSouthIDN	, OprnExpensesNorthIDE	, OprnExpensesEastIDE	, OprnExpensesWestIDE	, OprnExpensesSouthIDE	, RDExpenses, 
		BDExpensesNorth			, BDExpensesEast		, BDExpensesWest		, BDExpensesSouth		, CorporateExpenses		, TransExpenses, 
		ManagementExpenses		, UnallocatedExpenses	, Is_Published			, LOCATIONCODE_V		, CUSTOMERCODE_V		, FINANCIALPERIOD_V,
		TRANSTYPE_V				, TranOU_V				, LEVEL_1_V				, LEVEL_2_V				, LEVEL_3_V				, COSTCENTER_V,
		DOCUMENTNO				, DOCUMENTDATE			, ACCOUNTCODE			, ACCOUNTDESC			, BASEAMOUNT			, ALLOCATEDAMOUNT, 
		ROW_NUM					, ROW_NUM_1				, ROW_NUM_2				, ROW_NUM_3				, ROW_NUM_4				, ROW_NUM_5,
		ROW_NUM_6				, ROW_NUM_7				, ROW_NUM_8				, ROW_NUM_9				, ROW_NUM_10			, ROW_NUM_11, 
		ROW_NUM_12				, ROW_NUM_13			, ROW_NUM_14			, ROW_NUM_15			, ROW_NUM_16			, ROW_NUM_17,
		ROW_NUM_18				, ROW_NUM_19			, ROW_NUM_20			, ROW_NUM_21			, ROW_NUM_22			, ROW_NUM_23, 
		ROW_NUM_24				, ROW_NUM_25			, SERVICE_TYPE			, BILLINGTYPE_UPDATED	, Customer_Creation_Month, Customer_Creation_Year,
		Customer_Name_Group		, SalesRegion			, 
		etlactiveind			, etljobname			, envsourcecd			, datasourcecd			, etlcreatedatetime
    )

    SELECT
		COALESCE(com.company_key,-1), COALESCE(L.loc_key,-1)	, COALESCE(cus.customer_key,-1)	, COALESCE(op.opcoa_key,-1), 
        s.SNo					, s.CompanyCode			, s.CompanyName				, s.TranOU				, s.TranOUName			, s.FinancialYear, 
		s.FinancialPeriod		, s.LocationCustomerCode, s.LocationCode			, s.LocationName		, s.CustomerCode		, s.CustomerName, 
		s.CustomerType			, s.CustomerNameGroup	, s.CustomerBusinessType	, s.PCSBusinessType		, s.OperationRegionName	, s.SalesRegionName, 
		s.SpaceSqFt				, s.WarehouseClass		, s.LocationCity			, s.LocationState		, s.CityType			, s.Level1,
		s.Level2				, s.Level3				, s.ERPCostCenterCode		, s.ERPCostCenterDesc	, s.BillingType			, s.TransType, 
		s.RevenueNormal			, s.RevenueECom			, s.RevenueCorporate		, s.RevenueManagement	, s.DirectExpensesNormal, 
		s.DirectExpensesECom	, s.Expenses9999		, s.Expenses8888			, s.OprnExpensesNorthIDN, s.OprnExpensesEastIDN	, s.OprnExpensesWestIDN, 
		s.OprnExpensesSouthIDN	, s.OprnExpensesNorthIDE, s.OprnExpensesEastIDE		, s.OprnExpensesWestIDE	, s.OprnExpensesSouthIDE, s.RDExpenses, 
		s.BDExpensesNorth		, s.BDExpensesEast		, s.BDExpensesWest			, s.BDExpensesSouth		, s.CorporateExpenses	, s.TransExpenses, 
		s.ManagementExpenses	, s.UnallocatedExpenses	, s.Is_Published			, s.LOCATIONCODE_V		, s.CUSTOMERCODE_V		, s.FINANCIALPERIOD_V, 
		s.TRANSTYPE_V			, s.TranOU_V			, s.LEVEL_1_V				, s.LEVEL_2_V			, s.LEVEL_3_V			, s.COSTCENTER_V,
		s.DOCUMENTNO			, s.DOCUMENTDATE		, s.ACCOUNTCODE				, s.ACCOUNTDESC			, s.BASEAMOUNT			, s.ALLOCATEDAMOUNT, 
		s.ROW_NUM				, s.ROW_NUM_1			, s.ROW_NUM_2				, s.ROW_NUM_3			, s.ROW_NUM_4			, s.ROW_NUM_5, 
		s.ROW_NUM_6				, s.ROW_NUM_7			, s.ROW_NUM_8				, s.ROW_NUM_9			, s.ROW_NUM_10			, s.ROW_NUM_11,
		s.ROW_NUM_12			, s.ROW_NUM_13			, s.ROW_NUM_14				, s.ROW_NUM_15			, s.ROW_NUM_16			, s.ROW_NUM_17,
		s.ROW_NUM_18			, s.ROW_NUM_19			, s.ROW_NUM_20				, s.ROW_NUM_21			, s.ROW_NUM_22			, s.ROW_NUM_23,
		s.ROW_NUM_24			, s.ROW_NUM_25			, s.SERVICE_TYPE			, s.BILLINGTYPE_UPDATED	, s.Customer_Creation_Month	, s.Customer_Creation_Year, 
		s.Customer_Name_Group	, s.SalesRegion			,
				1				, p_etljobname			, p_envsourcecd				, p_datasourcecd		, NOW()
  	FROM stg.stg_final_voucher_profitability s
	LEFT JOIN dwh.d_company com
	ON s.CompanyCode		= com.company_code
	LEFT JOIN dwh.d_location l
	ON s.LocationCode		= l.loc_code
	AND s.tranou 			= l.loc_ou
	LEFT JOIN dwh.d_customer cus
	ON s.CustomerCode		= cus.customer_id
	AND s.TranOU			= cus.customer_ou
	LEFT JOIN dwh.d_operationalaccountdetail op
	ON s.accountcode::VARCHAR	= op.account_code;

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN

    INSERT INTO raw.raw_final_voucher_profitability
    (
        SNo, CompanyCode, CompanyName, TranOU, TranOUName, FinancialYear, FinancialPeriod, LocationCustomerCode, LocationCode, LocationName, CustomerCode, CustomerName, CustomerType, CustomerNameGroup, CustomerBusinessType, PCSBusinessType, OperationRegionName, SalesRegionName, SpaceSqFt, WarehouseClass, LocationCity, LocationState, CityType, Level1, Level2, Level3, ERPCostCenterCode, ERPCostCenterDesc, BillingType, TransType, RevenueNormal, RevenueECom, RevenueCorporate, RevenueManagement, DirectExpensesNormal, DirectExpensesECom, Expenses9999, Expenses8888, OprnExpensesNorthIDN, OprnExpensesEastIDN, OprnExpensesWestIDN, OprnExpensesSouthIDN, OprnExpensesNorthIDE, OprnExpensesEastIDE, OprnExpensesWestIDE, OprnExpensesSouthIDE, RDExpenses, BDExpensesNorth, BDExpensesEast, BDExpensesWest, BDExpensesSouth, CorporateExpenses, TransExpenses, ManagementExpenses, UnallocatedExpenses, Is_Published, LOCATIONCODE_V, CUSTOMERCODE_V, FINANCIALPERIOD_V, TRANSTYPE_V, TranOU_V, LEVEL_1_V, LEVEL_2_V, LEVEL_3_V, COSTCENTER_V, DOCUMENTNO, DOCUMENTDATE, ACCOUNTCODE, ACCOUNTDESC, BASEAMOUNT, ALLOCATEDAMOUNT, ROW_NUM, ROW_NUM_1, ROW_NUM_2, ROW_NUM_3, ROW_NUM_4, ROW_NUM_5, ROW_NUM_6, ROW_NUM_7, ROW_NUM_8, ROW_NUM_9, ROW_NUM_10, ROW_NUM_11, ROW_NUM_12, ROW_NUM_13, ROW_NUM_14, ROW_NUM_15, ROW_NUM_16, ROW_NUM_17, ROW_NUM_18, ROW_NUM_19, ROW_NUM_20, ROW_NUM_21, ROW_NUM_22, ROW_NUM_23, ROW_NUM_24, ROW_NUM_25, SERVICE_TYPE, BILLINGTYPE_UPDATED, Customer_Creation_Month, Customer_Creation_Year, Customer_Name_Group, SalesRegion, etlcreatedatetime
    )
    SELECT
        SNo, CompanyCode, CompanyName, TranOU, TranOUName, FinancialYear, FinancialPeriod, LocationCustomerCode, LocationCode, LocationName, CustomerCode, CustomerName, CustomerType, CustomerNameGroup, CustomerBusinessType, PCSBusinessType, OperationRegionName, SalesRegionName, SpaceSqFt, WarehouseClass, LocationCity, LocationState, CityType, Level1, Level2, Level3, ERPCostCenterCode, ERPCostCenterDesc, BillingType, TransType, RevenueNormal, RevenueECom, RevenueCorporate, RevenueManagement, DirectExpensesNormal, DirectExpensesECom, Expenses9999, Expenses8888, OprnExpensesNorthIDN, OprnExpensesEastIDN, OprnExpensesWestIDN, OprnExpensesSouthIDN, OprnExpensesNorthIDE, OprnExpensesEastIDE, OprnExpensesWestIDE, OprnExpensesSouthIDE, RDExpenses, BDExpensesNorth, BDExpensesEast, BDExpensesWest, BDExpensesSouth, CorporateExpenses, TransExpenses, ManagementExpenses, UnallocatedExpenses, Is_Published, LOCATIONCODE_V, CUSTOMERCODE_V, FINANCIALPERIOD_V, TRANSTYPE_V, TranOU_V, LEVEL_1_V, LEVEL_2_V, LEVEL_3_V, COSTCENTER_V, DOCUMENTNO, DOCUMENTDATE, ACCOUNTCODE, ACCOUNTDESC, BASEAMOUNT, ALLOCATEDAMOUNT, ROW_NUM, ROW_NUM_1, ROW_NUM_2, ROW_NUM_3, ROW_NUM_4, ROW_NUM_5, ROW_NUM_6, ROW_NUM_7, ROW_NUM_8, ROW_NUM_9, ROW_NUM_10, ROW_NUM_11, ROW_NUM_12, ROW_NUM_13, ROW_NUM_14, ROW_NUM_15, ROW_NUM_16, ROW_NUM_17, ROW_NUM_18, ROW_NUM_19, ROW_NUM_20, ROW_NUM_21, ROW_NUM_22, ROW_NUM_23, ROW_NUM_24, ROW_NUM_25, SERVICE_TYPE, BILLINGTYPE_UPDATED, Customer_Creation_Month, Customer_Creation_Year, Customer_Name_Group, SalesRegion, etlcreatedatetime
    FROM stg.stg_final_voucher_profitability;
    
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
ALTER PROCEDURE dwh.usp_f_finalvoucherprofitability(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
