CREATE OR REPLACE PROCEDURE click.usp_d_company()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_company t
    SET
        company_key = s.company_key,
        company_code = s.company_code,
        serial_no = s.serial_no,
        ctimestamp = s.ctimestamp,
        company_name = s.company_name,
        address1 = s.address1,
        address2 = s.address2,
        address3 = s.address3,
        city = s.city,
        country = s.country,
        zip_code = s.zip_code,
        phone_no = s.phone_no,
        state = s.state,
        company_url = s.company_url,
        par_comp_code = s.par_comp_code,
        base_currency = s.base_currency,
        status = s.status,
        effective_from = s.effective_from,
        para_base_flag = s.para_base_flag,
        reg_date = s.reg_date,
        createdby = s.createdby,
        createddate = s.createddate,
        modifiedby = s.modifiedby,
        modifieddate = s.modifieddate,
        company_id = s.company_id,
        etlactiveind = s.etlactiveind,
        etljobname = s.etljobname,
        envsourcecd = s.envsourcecd,
        datasourcecd = s.datasourcecd,
        etlupdatedatetime = NOW()
    FROM dwh.d_company s
    WHERE t.company_code = s.company_code
    AND t.serial_no = s.serial_no;

    INSERT INTO click.d_company(company_key, company_code, serial_no, ctimestamp, company_name, address1, address2, address3, city, country, zip_code, phone_no, state, company_url, par_comp_code, base_currency, status, effective_from, para_base_flag, reg_date, createdby, createddate, modifiedby, modifieddate, company_id, etlactiveind, etljobname, envsourcecd, datasourcecd, etlcreatedatetime)
    SELECT s.company_key, s.company_code, s.serial_no, s.ctimestamp, s.company_name, s.address1, s.address2, s.address3, s.city, s.country, s.zip_code, s.phone_no, s.state, s.company_url, s.par_comp_code, s.base_currency, s.status, s.effective_from, s.para_base_flag, s.reg_date, s.createdby, s.createddate, s.modifiedby, s.modifieddate, s.company_id, s.etlactiveind, s.etljobname, s.envsourcecd, s.datasourcecd, NOW()
    FROM dwh.d_company s
    LEFT JOIN click.d_company t
    ON t.company_code = s.company_code
    AND t.serial_no = s.serial_no
    WHERE t.company_code IS NULL;
END;
$$;