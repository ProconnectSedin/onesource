CREATE VIEW default.vw_d_date
(
    `DateKey` Int32,
    `Date` Date,
    `epoch` Int64,
    `daysuffix` String,
    `DayName` String,
    `DayNum` Int32,
    `dayofmonth` Int32,
    `dayofquarter` Int32,
    `dayofyear` Int32,
    `WeekNum` Int32,
    `weekofyear` Int32,
    `weekofyeariso` String,
    `MonthNum` Int32,
    `MonthName` String,
    `monthnameabbreviated` String,
    `QuarterNum` Int32,
    `QuarterName` String,
    `YearNum` Int32,
    `firstdayofweek` Date,
    `lastdayofweek` Date,
    `firstdayofmonth` Date,
    `lastdayofmonth` Date,
    `firstdayofquarter` Date,
    `lastdayofquarter` Date,
    `firstdayofyear` Date,
    `lastdayofyear` Date,
    `rolling12monthind` Nullable(String),
    `priorrolling12monthind` Nullable(String),
    `priorpriorrolling12monthind` Nullable(String),
    `rolling24monthind` Nullable(String),
    `rolling36monthind` Nullable(String),
    `rolling2yearind` Nullable(String),
    `rolling3yearind` Nullable(String),
    `rolling6monthind` Nullable(String),
    `roling3monthind` Nullable(String),
    `currentmonthind` Nullable(String),
    `prioryearcurrentmonthind` Nullable(String),
    `future6monthind` Nullable(String),
    `future5monthind` Nullable(String),
    `future4monthind` Nullable(String),
    `future3monthind` Nullable(String),
    `future12monthind` Nullable(String),
    `yeartolastcompletedmonthind` Nullable(String),
    `prioryeartolastcompletedmonthind` Nullable(String),
    `priorprioryeartolastcompletedmonthind` Nullable(String),
    `fullyearind` Nullable(String),
    `priorfullyearind` Nullable(String),
    `monthtodateind` Nullable(String),
    `prioryearmonthtodateind` Nullable(String),
    `yeartodateind` Nullable(String),
    `currentyearind` Nullable(String),
    `prioryearind` Nullable(String),
    `priormonthind` Nullable(String),
    `prioryeartodateind` Nullable(String),
    `priorprioryeartodateind` Nullable(String),
    `priorprioryearmonthtodateind` Nullable(String),
    `priorprioryearind` Nullable(String),
    `rolling365daysind` Nullable(String),
    `finacialyearind` Nullable(String),
    `prioryearfinancialyearind` Nullable(String),
    `etlactiveind` Nullable(String),
    `mmyyyy` String,
    `mmddyyyy` String,
    `weekendindr` UInt8
) AS
SELECT
    datekey AS DateKey,
    dateactual AS Date,
    epoch,
    daysuffix,
    dayname AS DayName,
    dayofweek AS DayNum,
    dayofmonth,
    dayofquarter,
    dayofyear,
    weekofmonth AS WeekNum,
    weekofyear,
    weekofyeariso,
    monthactual AS MonthNum,
    monthname AS MonthName,
    monthnameabbreviated,
    quarteractual AS QuarterNum,
    quartername AS QuarterName,
    yearactual AS YearNum,
    firstdayofweek,
    lastdayofweek,
    firstdayofmonth,
    lastdayofmonth,
    firstdayofquarter,
    lastdayofquarter,
    firstdayofyear,
    lastdayofyear,
    rolling12monthind,
    priorrolling12monthind,
    priorpriorrolling12monthind,
    rolling24monthind,
    rolling36monthind,
    rolling2yearind,
    rolling3yearind,
    rolling6monthind,
    roling3monthind,
    currentmonthind,
    prioryearcurrentmonthind,
    future6monthind,
    future5monthind,
    future4monthind,
    future3monthind,
    future12monthind,
    yeartolastcompletedmonthind,
    prioryeartolastcompletedmonthind,
    priorprioryeartolastcompletedmonthind,
    fullyearind,
    priorfullyearind,
    monthtodateind,
    prioryearmonthtodateind,
    yeartodateind,
    currentyearind,
    prioryearind,
    priormonthind,
    prioryeartodateind,
    priorprioryeartodateind,
    priorprioryearmonthtodateind,
    priorprioryearind,
    rolling365daysind,
    finacialyearind,
    prioryearfinancialyearind,
    etlactiveind,
    mmyyyy,
    mmddyyyy,
    weekendindr
FROM onesource.d_date