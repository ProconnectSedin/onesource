CREATE OR REPLACE PROCEDURE click.usp_f_attrition(
	)
LANGUAGE 'plpgsql'
AS $BODY$

BEGIN

	TRUNCATE TABLE CLICK.f_attrition RESTART IDENTITY;

		insert into click.f_attrition
		(				
			attrition_key		, loc_key			, emp_key			, supp_key,
			wh_key				, ou				, attendance_month	, vendor_code,
			location_code		, employee_type2	, vendor_name		, warehouse_code,
			warehouse_name		, employee_code		, job_code			, job_title,
			emp_count			, addition			, seperation		, inserted_ts,
			stg_createddatetime	, etlactiveind		, etljobname		, envsourcecd,
			datasourcecd		, etlcreatedatetime	, etlupdatedatetime	, createddate
		)
		select
			ak.attrition_key		, ak.loc_key			, ak.emp_key			, ak.supp_key,
			ak.wh_key				, ak.ou					, ak.attendance_month	, ak.vendor_code,
			ak.location_code		, ak.employee_type2		, ak.vendor_name		, ak.warehouse_code,
			ak.warehouse_name		, ak.employee_code		, ak.job_code			, ak.job_title,
			ak.emp_count			, ak.addition			, ak.seperation			, ak.inserted_ts,
			ak.createddatetime	, ak.etlactiveind		, ak.etljobname			, ak.envsourcecd,
			ak.datasourcecd			, ak.etlcreatedatetime	, ak.etlupdatedatetime	, NOW()
		FROM DWH.f_attrition ak;
END;
$BODY$;
ALTER PROCEDURE click.usp_f_attrition()
    OWNER TO proconnect;