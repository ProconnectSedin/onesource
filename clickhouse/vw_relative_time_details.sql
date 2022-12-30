CREATE VIEW default.vw_relative_time_details
(
    `PERIOD` String,
    `TYPE` String,
    `SNO` UInt8,
    `SEQNO` Int32,
    `YearNum` Int32,
    `QuarterNum` Int32,
    `MonthNum` Int32,
    `weekNum` Int32
) AS
SELECT
    PERIOD,
    TYPE,
    SNO,
    SEQNO,
    YearNum,
    QuarterNum,
    MonthNum,
    weekNum
FROM
(
   
SELECT DISTINCT
        CAST(yearactual, 'VARCHAR(20)') AS PERIOD,
        'Y' AS TYPE,
        4 AS SNO,
        yearactual AS YearNum,
        CAST(yearactual, 'INT') AS SEQNO,
        0 AS QuarterNum,
        0 AS MonthNum,
        0 AS weekNum
   
FROM onesource.d_date
   
WHERE (yearactual >= 2019) AND (yearactual <= toYear(now()))
    UNION ALL
   
SELECT DISTINCT
        concat('Q', CAST(quarteractual, 'varchar(5)'), ' ', CAST(yearactual, 'VARCHAR(4)')) AS PERIOD,
        'Q' AS TYPE,
        3 AS SNO,
        yearactual AS YearNum,
        CAST(quarteractual, 'INT') AS SEQNO,
        quarteractual AS QuarterNum,
        0 AS MonthNum,
        0 AS weekNum
   
FROM onesource.d_date
   
WHERE (yearactual >= 2019) AND (yearactual <= toYear(now()))
    UNION ALL
   
SELECT DISTINCT
        concat(monthnameabbreviated, ' ', CAST(yearactual, 'VARCHAR(4)')) AS PERIOD,
        'M' AS TYPE,
        2 AS SNO,
        yearactual AS YearNum,
        CAST(monthactual, 'INT') AS SEQNO,
        0 AS QuarterNum,
        monthactual AS MonthNum,
        0 AS weekNum
   
FROM onesource.d_date
   
WHERE (yearactual >= 2019) AND (yearactual <= toYear(now()))
    UNION ALL
   
SELECT DISTINCT
        CAST(concat('W', CAST(weekofyear, 'VARCHAR(2)'), ' ', CAST(yearactual, 'VARCHAR(4)')), 'VARCHAR(20)') AS PERIOD,
        'W' AS TYPE,
        1 AS SNO,
        yearactual AS YearNum,
        CAST(weekofyear, 'INT') AS SEQNO,
        0 AS QuarterNum,
        0 AS MonthNum,
        weekofyear AS weekNum
   
FROM onesource.d_date
   
WHERE (yearactual >= 2019) AND (yearactual <= toYear(now()))
) AS A
ORDER BY
    TYPE ASC,
    YearNum ASC,
    SEQNO ASC,
    SNO ASC