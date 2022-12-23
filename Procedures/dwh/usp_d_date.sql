-- PROCEDURE: dwh.usp_d_date(date, date)

-- DROP PROCEDURE IF EXISTS dwh.usp_d_date(date, date);

CREATE OR REPLACE PROCEDURE dwh.usp_d_date(
	IN p_startdate date,
	IN p_enddate date)
LANGUAGE 'plpgsql'
AS $BODY$
DECLARE v_enddate INT; v_NextFourYearDate DATE; v_MaxDate DATE;  
BEGIN
	v_NextFourYearDate := INTERVAL '4 YEAR' +NOW();
	
 	SELECT MAX(dateactual) INTO v_MaxDate FROM dwh.D_Date;  
	
	IF v_maxdate IS NULL THEN
	
		IF p_startdate IS NULL THEN
			p_startdate := '2017-01-01' ;
		END IF;	
		
		IF p_enddate IS NULL THEN 
		p_enddate := v_NextFourYearDate;
		END IF;
		
		SELECT ABS(DATE_PART('day', p_startdate::timestamp - p_enddate::timestamp)) INTO v_enddate;
	END IF;
		
	IF v_maxdate < v_NextFourYearDate THEN
		v_maxdate := INTERVAL '1 DAY' + v_maxdate;
		p_startdate := v_maxdate;
		SELECT ABS(DATE_PART('day', p_startdate::timestamp - v_NextFourYearDate::timestamp)) INTO v_enddate;	
	END IF;
	
	INSERT INTO dwh.d_date
	(
		datekey, dateactual, epoch, daysuffix, dayname, dayofweek, dayofmonth, dayofquarter, dayofyear, weekofmonth, 
		weekofyear, weekofyeariso, monthactual, monthname, monthnameabbreviated, quarteractual, quartername, yearactual, firstdayofweek, lastdayofweek, 
		firstdayofmonth, lastdayofmonth, firstdayofquarter, lastdayofquarter, firstdayofyear, lastdayofyear,mmyyyy, mmddyyyy, weekendindr	
	)
	SELECT 
		TO_CHAR(datum, 'yyyymmdd')::INT AS date_dim_id,
		datum AS date_actual,
		EXTRACT(EPOCH FROM datum) AS epoch,
		TO_CHAR(datum, 'fmDDth') AS day_suffix,
		TO_CHAR(datum, 'TMDay') AS day_name,
		EXTRACT(ISODOW FROM datum) AS day_of_week,
		EXTRACT(DAY FROM datum) AS day_of_month,
		datum - DATE_TRUNC('quarter', datum)::DATE + 1 AS day_of_quarter,
		EXTRACT(DOY FROM datum) AS day_of_year,
		TO_CHAR(datum, 'W')::INT AS week_of_month,
		EXTRACT(WEEK FROM datum) AS week_of_year,
		EXTRACT(ISOYEAR FROM datum) || TO_CHAR(datum, '"-W"IW-') || EXTRACT(ISODOW FROM datum) AS week_of_year_iso,
		EXTRACT(MONTH FROM datum) AS month_actual,
		TO_CHAR(datum, 'TMMonth') AS month_name,
		TO_CHAR(datum, 'Mon') AS month_name_abbreviated,
		EXTRACT(QUARTER FROM datum) AS quarter_actual,
		CASE
		   WHEN EXTRACT(QUARTER FROM datum) = 1 THEN 'First'
		   WHEN EXTRACT(QUARTER FROM datum) = 2 THEN 'Second'
		   WHEN EXTRACT(QUARTER FROM datum) = 3 THEN 'Third'
		   WHEN EXTRACT(QUARTER FROM datum) = 4 THEN 'Fourth'
		   END AS quarter_name,
		EXTRACT(YEAR FROM datum) AS year_actual,
		datum + (1 - EXTRACT(ISODOW FROM datum))::INT AS first_day_of_week,
		datum + (7 - EXTRACT(ISODOW FROM datum))::INT AS last_day_of_week,
		datum + (1 - EXTRACT(DAY FROM datum))::INT AS first_day_of_month,
		(DATE_TRUNC('MONTH', datum) + INTERVAL '1 MONTH - 1 day')::DATE AS last_day_of_month,
		DATE_TRUNC('quarter', datum)::DATE AS first_day_of_quarter,
		(DATE_TRUNC('quarter', datum) + INTERVAL '3 MONTH - 1 day')::DATE AS last_day_of_quarter,
		TO_DATE(EXTRACT(YEAR FROM datum) || '-01-01', 'YYYY-MM-DD') AS first_day_of_year,
		TO_DATE(EXTRACT(YEAR FROM datum) || '-12-31', 'YYYY-MM-DD') AS last_day_of_year,
		TO_CHAR(datum, 'mmyyyy') AS mmyyyy,
		TO_CHAR(datum, 'mmddyyyy') AS mmddyyyy,
		CASE
		   WHEN EXTRACT(ISODOW FROM datum) IN (6, 7) THEN TRUE
		   ELSE FALSE
		   END AS weekend_indr
	FROM (SELECT p_startdate::DATE + SEQUENCE.DAY AS datum
		  FROM GENERATE_SERIES(0, v_enddate) AS SEQUENCE (DAY)
		  GROUP BY SEQUENCE.DAY) DQ
	ORDER BY 1;
	
	UPDATE dwh.d_date
	SET
		Rolling12MonthInd = (CASE WHEN 	dateactual >= (interval '-1 YEAR' + date_trunc('month', NOW()::date))::date AND
										dateactual <= (date_trunc('month', NOW()::date) + interval '- 1 day')::date THEN 1 ELSE 0 END)::BIT,
		PriorRolling12MonthInd = (CASE WHEN dateactual >= (interval '-2 YEAR' + date_trunc('month', NOW()::date))::date AND
											dateactual <= (date_trunc('month', NOW()::date) + interval '-1 YEAR - 1 day')::date THEN 1 ELSE 0 END)::BIT,		
		PriorPriorRolling12MonthInd = (CASE WHEN 	dateactual >= (interval '-3 YEAR' + date_trunc('month', NOW()::date))::date AND
													dateactual <= (date_trunc('month', NOW()::date) + interval '-2 YEAR - 1 day')::date THEN 1 ELSE 0 END)::BIT,
		Rolling24MonthInd = (CASE WHEN 	dateactual >= (interval '-2 YEAR' + date_trunc('month', NOW()::date))::date AND
										dateactual <= (date_trunc('month', NOW()::date) + interval '-1 YEAR - 1 day')::date THEN 1 ELSE 0 END)::BIT,		
		Rolling36MonthInd = (CASE WHEN 	dateactual >= (interval '-3 YEAR' + date_trunc('month', NOW()::date))::date AND
										dateactual <= (date_trunc('month', NOW()::date) + interval '-2 YEAR - 1 day')::date THEN 1 ELSE 0 END)::BIT,	
		Rolling2YearInd = (CASE WHEN 	DATE_PART('YEAR',dateactual::DATE) >= DATE_PART('YEAR',(interval '-2 YEAR' + date_trunc('month', NOW()::date))::date) AND
										DATE_PART('YEAR',dateactual::DATE) <= DATE_PART('YEAR',(date_trunc('month', NOW()::date) + interval '-1 YEAR - 1 day')::date) THEN 1 ELSE 0 END)::BIT,
		Rolling3YearInd = (CASE WHEN 	DATE_PART('YEAR',dateactual::DATE) >= DATE_PART('YEAR',(interval '-3 YEAR' + date_trunc('month', NOW()::date))::date) AND
										DATE_PART('YEAR',dateactual::DATE) <= DATE_PART('YEAR',(date_trunc('month', NOW()::date) + interval '-2 YEAR - 1 day')::date) THEN 1 ELSE 0 END)::BIT,		
		Rolling6MonthInd = (CASE WHEN 	dateactual >= (date_trunc('month', NOW()::date) + interval '-6 month')::date AND
										dateactual <= (date_trunc('month', NOW()::date) + interval '- 1 day')::date THEN 1 ELSE 0 END)::BIT,
		Roling3MonthInd = (CASE WHEN 	dateactual >= (date_trunc('month', NOW()::date) + interval '-3 month')::date AND
										dateactual <= (date_trunc('month', NOW()::date) + interval '- 1 day')::date THEN 1 ELSE 0 END)::BIT,	
		CurrentMonthInd = (CASE WHEN 	EXTRACT(MONTH FROM dateactual) = EXTRACT(MONTH FROM NOW()::DATE) THEN 1 ELSE 0 END)::BIT,
		PriorYearCurrentMonthInd = (CASE WHEN 	EXTRACT(MONTH FROM dateactual) = EXTRACT(MONTH FROM (NOW() + INTERVAL '-1 YEAR')::DATE) THEN 1 ELSE 0 END)::BIT,
		Future6MonthInd = (CASE WHEN dateactual >= date_trunc('month', NOW()::date) + interval '1 month' AND dateactual <=	date_trunc('month', NOW()::date) + interval '7 month - 1 DAY' THEN 1 ELSE 0 END)::BIT,	
		Future5MonthInd = (CASE WHEN dateactual >= date_trunc('month', NOW()::date) + interval '1 month' AND dateactual <=	date_trunc('month', NOW()::date) + interval '6 month - 1 DAY' THEN 1 ELSE 0 END)::BIT,
		Future4MonthInd = (CASE WHEN dateactual >= date_trunc('month', NOW()::date) + interval '1 month' AND dateactual <=	date_trunc('month', NOW()::date) + interval '5 month - 1 DAY' THEN 1 ELSE 0 END)::BIT,
		Future3MonthInd = (CASE WHEN dateactual >= date_trunc('month', NOW()::date) + interval '1 month' AND dateactual <=	date_trunc('month', NOW()::date) + interval '4 month - 1 DAY' THEN 1 ELSE 0 END)::BIT,
		Future12MonthInd = (CASE WHEN dateactual >= date_trunc('month', NOW()::date) + interval '1 month' AND dateactual <= date_trunc('month', NOW()::date) + interval '13 month - 1 DAY' THEN 1 ELSE 0 END)::BIT,
		YearToLastCompletedMonthInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',NOW()::DATE + interval '-1 month') AND DATE_PART('MONTH',dateactual::DATE) <= DATE_PART('MONTH',NOW()::DATE + interval '-1 month') THEN 1 ELSE 0 END)::BIT,
		PriorYearToLastCompletedMonthInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',NOW()::DATE + interval '-1 month - 1 YEAR') AND DATE_PART('MONTH',dateactual::DATE) <= DATE_PART('MONTH',NOW()::DATE + interval '-1 month') THEN 1 ELSE 0 END)::BIT,
		PriorPriorYearToLastCompletedMonthInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',NOW()::DATE + interval '-1 month - 2 YEAR') AND DATE_PART('MONTH',dateactual::DATE) <= DATE_PART('MONTH',NOW()::DATE + interval '-1 month') THEN 1 ELSE 0 END)::BIT,
		FullYearInd = (CASE WHEN dateactual BETWEEN TO_DATE(DATE_PART('YEAR',NOW()) || '-01-01', 'YYYY-MM-DD')::date AND (NOW() + INTERVAL '- 1 DAY')::date THEN 1 ELSE 0 END)::BIT,
		PriorFullYearInd = (CASE WHEN dateactual BETWEEN TO_DATE(DATE_PART('YEAR',NOW()+ INTERVAL '- 1 YEAR') || '-01-01', 'YYYY-MM-DD')::date AND (NOW() + INTERVAL '- 1 DAY - 1 YEAR')::date THEN 1 ELSE 0 END)::BIT,
		MonthToDateInd = (CASE WHEN dateactual >= date_trunc('month', p_startdate::date) AND dateactual <= NOW() + INTERVAL '- 1 DAY' THEN 1 ELSE 0 END)::BIT,
		PriorYearMonthToDateInd = (CASE WHEN dateactual >= (date_trunc('month', p_startdate::date) + INTERVAL '- 1 YEAR')::DATE AND dateactual <= (NOW() + INTERVAL '- 1 YEAR')::DATE THEN 1 ELSE 0 END)::BIT,
		YearToDateInd = (CASE WHEN dateactual >= TO_DATE(DATE_PART('YEAR',NOW()) || '-01-01', 'YYYY-MM-DD')::date AND dateactual <= NOW() + INTERVAL '- 1 DAY' THEN 1 ELSE 0 END)::BIT,
		PriorYearToDateInd = (CASE WHEN dateactual BETWEEN TO_DATE(DATE_PART('YEAR',NOW() + INTERVAL '- 1 YEAR') || '-01-01', 'YYYY-MM-DD')::date AND NOW() + INTERVAL '- 1 DAY - 1 YEAR' THEN 1 ELSE 0 END)::BIT,
		CurrentYearInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',(NOW() + INTERVAL '- 1 MONTH')) THEN 1 ELSE 0 END)::BIT,
		PriorYearInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',(NOW() + INTERVAL '- 1 MONTH - 1 YEAR')) THEN 1 ELSE 0 END)::BIT,
		PriorMonthInd = (CASE WHEN TO_CHAR(p_startdate, 'yyyyMM') = TO_CHAR(NOW() + INTERVAL '- 1 MONTH', 'yyyyMM') THEN 1 ELSE 0 END)::BIT,
		PriorPriorYearToDateInd = (CASE WHEN dateactual BETWEEN TO_DATE(DATE_PART('YEAR',NOW() + INTERVAL '- 2 YEAR') || '-01-01', 'YYYY-MM-DD')::date AND NOW() + INTERVAL '- 1 DAY - 2 YEAR' THEN 1 ELSE 0 END)::BIT,
		PriorPriorYearMonthToDateInd = (CASE WHEN dateactual >= (date_trunc('month', p_startdate::date) + INTERVAL '- 2 YEAR')::DATE AND dateactual <= (NOW() + INTERVAL '- 2 YEAR')::DATE THEN 1 ELSE 0 END)::BIT,
		PriorPriorYearInd = (CASE WHEN DATE_PART('YEAR',dateactual::DATE) = DATE_PART('YEAR',(NOW() + INTERVAL '- 1 MONTH - 2 YEAR')) THEN 1 ELSE 0 END)::BIT,
		Rolling365DaysInd = (CASE WHEN dateactual BETWEEN NOW() + INTERVAL '- 1 YEAR' AND NOW() THEN 1 ELSE 0 END)::BIT,
		finacialyearind = (CASE WHEN dateactual BETWEEN TO_DATE(EXTRACT(YEAR FROM NOW()) || '-04-01', 'YYYY-MM-DD') AND TO_DATE(EXTRACT(YEAR FROM NOW() + interval '1 YEAR') || '-03-31', 'YYYY-MM-DD') THEN 1 ELSE 0 END)::BIT,
		prioryearfinancialyearind = (CASE WHEN dateactual BETWEEN TO_DATE(EXTRACT(YEAR FROM NOW() + interval '-1 YEAR') || '-04-01', 'YYYY-MM-DD') AND TO_DATE(EXTRACT(YEAR FROM NOW()) || '-03-31', 'YYYY-MM-DD') THEN 1 ELSE 0 END)::BIT;
END;
$BODY$;
ALTER PROCEDURE dwh.usp_d_date(date, date)
    OWNER TO proconnect;
