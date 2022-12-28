insert into ods.dwhtoclickcontroldtl
(objecttype    , objectname, executionflag, seqexecution, createddatetime,updateddatetime, loadtype, loadfrequency)
values
('Fact'        , 'usp_d_inboundtat', '1'        , '1'    , now()::TIMESTAMP, now()::TIMESTAMP, 'incremental', 'always'
);

insert into ods.dwhtoclickcontroldtl
(objecttype    , objectname, executionflag, seqexecution, createddatetime,updateddatetime, loadtype, loadfrequency)
values
('Fact'        , 'usp_d_tmsdeliverytat', '1'        , '1'    , now()::TIMESTAMP, now()::TIMESTAMP, 'Truncate and reload', 'always'
);


insert into ods.dwhtoclickcontroldtl
(objecttype    , objectname, executionflag, seqexecution, createddatetime,updateddatetime, loadtype, loadfrequency)
values
('Fact'        , 'usp_d_outboundtat', '1'        , '1'    , now()::TIMESTAMP, now()::TIMESTAMP, 'Truncate and reload', 'always'
);