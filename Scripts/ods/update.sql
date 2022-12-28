update  ods.controlheader 
set dwobjectname  = 'd_outboundtat'
where  sourceid  = 'dim_outbound_Tat';

update ods.controldetail 
set targetobject = 'd_OutboundTAT',
targetprocedurename = 'USP_d_OutboundTAT'
where dataflowflag = 'StgtoDW'
and sourceid  = 'dim_outbound_Tat';