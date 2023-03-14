-- PROCEDURE: dwh.usp_d_locationcustomermst(character varying, character varying, character varying, character varying)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_locationcustomermst(character varying, character varying, character varying, character varying);

CREATE OR REPLACE PROCEDURE dwh.usp_d_locationcustomermst(
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
    FROM stg.stg_locationcustomer_mst;

	UPDATE dwh.d_LocationCustomerMst t
	SET 
		location_key			= coalesce(l.loc_key,-1),
		customer_key			= coalesce(c.customer_key,-1),
		loccust_key				= coalesce(b.loc_key,-1),
		TranOU					= s.TranOU,
		TranOUName				= s.TranOUName,
		CustomerCode			= s.CustomerCode,
		CustomerName			= s.CustomerName,
		LocationCode			= s.LocationCode,
		LocationName			= s.LocationName,
		FBID					= s.FBID,
		CostCenter				= s.CostCenter,
		OperationRegionID		= s.OperationRegionID,
		OperationRegion			= s.OperationRegion,
		SalesRegionID			= s.SalesRegionID,
		SalesRegion				= s.SalesRegion,
		ActualCostCenter		= s.ActualCostCenter,
		BusinessTypeID			= s.BusinessTypeID,
		BusinessType			= s.BusinessType,
		Vertical				= s.Vertical,
		SpaceSqFt				= s.SpaceSqFt,
		WarehouseClass			= s.WarehouseClass,
		LocationCity			= s.LocationCity,
		CityType				= s.CityType,
		Customer_Creation_Date	= s.Customer_Creation_Date,
		CustomerType			= s.CustomerType,
		CustomerGroup			= s.CustomerGroup,
		CustomerBusinessType	= s.CustomerBusinessType,
		BillingType				= s.BillingType,
		Customer_Creation_Month	= s.Customer_Creation_Month,
		Customer_Creation_Year	= s.Customer_Creation_Year,
		StorageArea				= s.StorageArea,
		Customer_Name_Group		= s.Customer_Name_Group,
		BusinessType1			= s.BusinessType1,
		SAM1					= s.SAM1,
		Location_Status			= s.Location_Status,
		Warehouse_Type			= s.Warehouse_Type,
		Locust_code				= s.Locust_code,
		Access					= s.Access,
		LocationType			= s.LocationType,
		WH_Group				= s.WH_Group,
		Master_Created_by		= s.Master_Created_by,
		etlactiveind			= 1,
		etljobname				= p_etljobname,
		envsourcecd				= p_envsourcecd,
		datasourcecd			= p_datasourcecd,
		etlupdatedatetime		= NOW()
		from stg.stg_locationcustomer_mst s
		LEFT JOIN dwh.d_location l
		ON l.loc_code			= s.locationcode
		AND l.loc_ou			= s.TranOU
		LEFT JOIN dwh.d_customer c
		ON c.customer_id		= s.customercode
		AND c.customer_ou		= s.TranOU
		left join  dwh.d_location b
		on s.Locust_code=b.loc_code
		and s.TranOU	=b.loc_ou
		WHERE t.TranOU 			= s.TranOU
		AND t.customercode		= s.customercode
		AND t.locationcode		= s.locationcode;

	    GET DIAGNOSTICS updcnt = ROW_COUNT;

	INSERT INTO dwh.d_LocationCustomerMst
		(
		location_key			,customer_key,loccust_key,
		TranOU					, TranOUName			, CustomerCode		, CustomerName			, LocationCode, 
		LocationName			, FBID					, CostCenter		, OperationRegionID		, OperationRegion, 
		SalesRegionID			, SalesRegion			, ActualCostCenter	, BusinessTypeID		, BusinessType, 
		Vertical				, SpaceSqFt				, WarehouseClass	, LocationCity			, CityType, 
		Customer_Creation_Date	, CustomerType			, CustomerGroup		, CustomerBusinessType	, BillingType,
		Customer_Creation_Month	, Customer_Creation_Year, StorageArea		, Customer_Name_Group	, BusinessType1, 
		SAM1					, Location_Status		, Warehouse_Type	, Locust_code			, Access, 
		LocationType			, WH_Group				, Master_Created_by	, 
		etlactiveind			, etljobname			, envsourcecd		, datasourcecd			, etlcreatedatetime
		)
	
	SELECT
		coalesce(l.loc_key,-1)		,coalesce(c.customer_key,-1),coalesce(b.loc_key,-1),
		s.TranOU					, s.TranOUName				, s.CustomerCode		, s.CustomerName			, s.LocationCode, 
		s.LocationName				, s.FBID					, s.CostCenter			, s.OperationRegionID		, s.OperationRegion, 
		s.SalesRegionID				, s.SalesRegion				, s.ActualCostCenter	, s.BusinessTypeID			, s.BusinessType, 
		s.Vertical					, s.SpaceSqFt				, s.WarehouseClass		, s.LocationCity			, s.CityType, 
		s.Customer_Creation_Date	, s.CustomerType			, s.CustomerGroup		, s.CustomerBusinessType	, s.BillingType,
		s.Customer_Creation_Month	, s.Customer_Creation_Year	, s.StorageArea			, s.Customer_Name_Group		, s.BusinessType1, 
		s.SAM1						, s.Location_Status			, s.Warehouse_Type		, s.Locust_code				, s.Access, 
		s.LocationType				, s.WH_Group				, s.Master_Created_by	,
				1					, p_etljobname				, p_envsourcecd			, p_datasourcecd			, NOW()
		FROM stg.stg_locationcustomer_mst s
		LEFT JOIN dwh.d_location l
		ON l.loc_code			= s.locationcode
		AND l.loc_ou			= s.TranOU
		LEFT JOIN dwh.d_customer c
		ON c.customer_id		= s.customercode
		AND c.customer_ou		= s.TranOU	
		left join  dwh.d_location b
		on s.Locust_code=b.loc_code
		and s.TranOU	=b.loc_ou
		LEFT JOIN dwh.d_LocationCustomerMst t
		ON t.TranOU 			= s.TranOU
		AND t.customercode		= s.customercode
		AND t.locationcode		= s.locationcode
		WHERE t.locationcode IS NULL;
		--select * from dwh.d_location
		
-- 		select * from dwh.d_locationcustomermst a
-- 		inner join  dwh.d_location b
-- 		on a.Locust_code=b.loc_code
-- 		and a.TranOU	=b.loc_ou

    GET DIAGNOSTICS inscnt = ROW_COUNT;

    IF p_rawstorageflag = 1
    THEN		
		
		INSERT INTO raw.raw_locationcustomer_mst
		(
			TranOU					, TranOUName			, CustomerCode		, CustomerName			, LocationCode, 
			LocationName			, FBID					, CostCenter		, OperationRegionID		, OperationRegion, 
			SalesRegionID			, SalesRegion			, ActualCostCenter	, BusinessTypeID		, BusinessType, 
			Vertical				, SpaceSqFt				, WarehouseClass	, LocationCity			, CityType, 
			Customer_Creation_Date	, CustomerType			, CustomerGroup		, CustomerBusinessType	, BillingType,
			Customer_Creation_Month	, Customer_Creation_Year, StorageArea		, Customer_Name_Group	, BusinessType1, 
			SAM1					, Location_Status		, Warehouse_Type	, Locust_code			, Access, 
			LocationType			, WH_Group				, Master_Created_by	, etlcreatedatetime
		)
			
		select 
			TranOU					, TranOUName			, CustomerCode		, CustomerName			, LocationCode, 
			LocationName			, FBID					, CostCenter		, OperationRegionID		, OperationRegion, 
			SalesRegionID			, SalesRegion			, ActualCostCenter	, BusinessTypeID		, BusinessType, 
			Vertical				, SpaceSqFt				, WarehouseClass	, LocationCity			, CityType, 
			Customer_Creation_Date	, CustomerType			, CustomerGroup		, CustomerBusinessType	, BillingType,
			Customer_Creation_Month	, Customer_Creation_Year, StorageArea		, Customer_Name_Group	, BusinessType1, 
			SAM1					, Location_Status		, Warehouse_Type	, Locust_code			, Access, 
			LocationType			, WH_Group				, Master_Created_by	, etlcreatedatetime
		FROM stg.stg_locationcustomer_mst;

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
ALTER PROCEDURE dwh.usp_d_locationcustomermst(character varying, character varying, character varying, character varying)
    OWNER TO proconnect;
