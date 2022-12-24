CREATE OR REPLACE PROCEDURE click.usp_d_date()
    LANGUAGE plpgsql
    AS $$

BEGIN
    UPDATE click.d_date t
    SET
        datekey = s.datekey,
        dateactual = s.dateactual,
        epoch = s.epoch,
        daysuffix = s.daysuffix,
        dayname = s.dayname,
        dayofweek = s.dayofweek,
        dayofmonth = s.dayofmonth,
        dayofquarter = s.dayofquarter,
        dayofyear = s.dayofyear,
        weekofmonth = s.weekofmonth,
        weekofyear = s.weekofyear,
        weekofyeariso = s.weekofyeariso,
        monthactual = s.monthactual,
        monthname = s.monthname,
        monthnameabbreviated = s.monthnameabbreviated,
        quarteractual = s.quarteractual,
        quartername = s.quartername,
        yearactual = s.yearactual,
        firstdayofweek = s.firstdayofweek,
        lastdayofweek = s.lastdayofweek,
        firstdayofmonth = s.firstdayofmonth,
        lastdayofmonth = s.lastdayofmonth,
        firstdayofquarter = s.firstdayofquarter,
        lastdayofquarter = s.lastdayofquarter,
        firstdayofyear = s.firstdayofyear,
        lastdayofyear = s.lastdayofyear,
        rolling12monthind = s.rolling12monthind,
        priorrolling12monthind = s.priorrolling12monthind,
        priorpriorrolling12monthind = s.priorpriorrolling12monthind,
        rolling24monthind = s.rolling24monthind,
        rolling36monthind = s.rolling36monthind,
        rolling2yearind = s.rolling2yearind,
        rolling3yearind = s.rolling3yearind,
        rolling6monthind = s.rolling6monthind,
        roling3monthind = s.roling3monthind,
        currentmonthind = s.currentmonthind,
        prioryearcurrentmonthind = s.prioryearcurrentmonthind,
        future6monthind = s.future6monthind,
        future5monthind = s.future5monthind,
        future4monthind = s.future4monthind,
        future3monthind = s.future3monthind,
        future12monthind = s.future12monthind,
        yeartolastcompletedmonthind = s.yeartolastcompletedmonthind,
        prioryeartolastcompletedmonthind = s.prioryeartolastcompletedmonthind,
        priorprioryeartolastcompletedmonthind = s.priorprioryeartolastcompletedmonthind,
        fullyearind = s.fullyearind,
        priorfullyearind = s.priorfullyearind,
        monthtodateind = s.monthtodateind,
        prioryearmonthtodateind = s.prioryearmonthtodateind,
        yeartodateind = s.yeartodateind,
        currentyearind = s.currentyearind,
        prioryearind = s.prioryearind,
        priormonthind = s.priormonthind,
        prioryeartodateind = s.prioryeartodateind,
        priorprioryeartodateind = s.priorprioryeartodateind,
        priorprioryearmonthtodateind = s.priorprioryearmonthtodateind,
        priorprioryearind = s.priorprioryearind,
        rolling365daysind = s.rolling365daysind,
        finacialyearind = s.finacialyearind,
        prioryearfinancialyearind = s.prioryearfinancialyearind,
        etlactiveind = s.etlactiveind,
        mmyyyy = s.mmyyyy,
        mmddyyyy = s.mmddyyyy,
        weekendindr = s.weekendindr
    FROM dwh.d_date s
    WHERE t.dateactual = s.dateactual;

    INSERT INTO click.d_date(datekey, dateactual, epoch, daysuffix, dayname, dayofweek, dayofmonth, dayofquarter, dayofyear, weekofmonth, weekofyear, weekofyeariso, monthactual, monthname, monthnameabbreviated, quarteractual, quartername, yearactual, firstdayofweek, lastdayofweek, firstdayofmonth, lastdayofmonth, firstdayofquarter, lastdayofquarter, firstdayofyear, lastdayofyear, rolling12monthind, priorrolling12monthind, priorpriorrolling12monthind, rolling24monthind, rolling36monthind, rolling2yearind, rolling3yearind, rolling6monthind, roling3monthind, currentmonthind, prioryearcurrentmonthind, future6monthind, future5monthind, future4monthind, future3monthind, future12monthind, yeartolastcompletedmonthind, prioryeartolastcompletedmonthind, priorprioryeartolastcompletedmonthind, fullyearind, priorfullyearind, monthtodateind, prioryearmonthtodateind, yeartodateind, currentyearind, prioryearind, priormonthind, prioryeartodateind, priorprioryeartodateind, priorprioryearmonthtodateind, priorprioryearind, rolling365daysind, finacialyearind, prioryearfinancialyearind, etlactiveind, mmyyyy, mmddyyyy,weekendindr)
    SELECT s.datekey, s.dateactual, s.epoch, s.daysuffix, s.dayname, s.dayofweek, s.dayofmonth, s.dayofquarter, s.dayofyear, s.weekofmonth, s.weekofyear, s.weekofyeariso, s.monthactual, s.monthname, s.monthnameabbreviated, s.quarteractual, s.quartername, s.yearactual, s.firstdayofweek, s.lastdayofweek, s.firstdayofmonth, s.lastdayofmonth, s.firstdayofquarter, s.lastdayofquarter, s.firstdayofyear, s.lastdayofyear, s.rolling12monthind, s.priorrolling12monthind, s.priorpriorrolling12monthind, s.rolling24monthind, s.rolling36monthind, s.rolling2yearind, s.rolling3yearind, s.rolling6monthind, s.roling3monthind, s.currentmonthind, s.prioryearcurrentmonthind, s.future6monthind, s.future5monthind, s.future4monthind, s.future3monthind, s.future12monthind, s.yeartolastcompletedmonthind, s.prioryeartolastcompletedmonthind, s.priorprioryeartolastcompletedmonthind, s.fullyearind, s.priorfullyearind, s.monthtodateind, s.prioryearmonthtodateind, s.yeartodateind, s.currentyearind, s.prioryearind, s.priormonthind, s.prioryeartodateind, s.priorprioryeartodateind, s.priorprioryearmonthtodateind, s.priorprioryearind, s.rolling365daysind, s.finacialyearind, s.prioryearfinancialyearind, s.etlactiveind, s.mmyyyy, s.mmddyyyy,s.weekendindr
    FROM dwh.d_date s
    LEFT JOIN click.d_date t
    ON t.dateactual = s.dateactual
    WHERE t.dateactual IS NULL;
END;
$$;