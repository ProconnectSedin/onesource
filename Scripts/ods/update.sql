update  ods.controlheader 
set dwobjectname  = 'd_outboundtat'
where  sourceid  = 'dim_outbound_Tat';

update ods.controldetail 
set targetobject = 'd_OutboundTAT',
targetprocedurename = 'USP_d_OutboundTAT'
where dataflowflag = 'StgtoDW'
and sourceid  = 'dim_outbound_Tat';



update ods.controlheader set  adlscontainername = 'Finance' 
where dwobjectname in ( 'd_astaxyearhdr', 	'd_finquickcodemet', 
'f_abbaccountbudgetdtl', 	'f_acapassethdr', 
'f_adepdeprratehdr', 	'f_adeppprocesshdr', 	
'f_ainqcwipaccountinginfo', 	'f_aplanacqproposalhdr', 
'f_aplanproposalbaldtl', 	'f_cbadjadjvcrdocdtl', 	
'f_cbadjadjvdrdocdtl', 	'f_cbadjadjvoucherhdr', 	
'f_cdcnaccdtl', 	'f_cdcnarpostingsdtl', 	'f_cdcndcnotehdr', 
'f_cdcnitemdtl', 	'f_cdiarpostingsdtl', 	'f_cdiinvoicehdr',
'f_cdiitemdtl', 	'f_cidochdr', 	'f_eamamchdr', 	'f_fbpaccountbalance', 
'f_fbppostedtrndtl', 	'f_fbpvoucherdtl', 	'f_fbpvoucherhdr',
'f_jvvouchertrndtl', 	'f_jvvouchertrnhdr', 	'f_rppostingsdtl', 
'f_rptacctinfodtl', 	'f_sadadjvcrdocdtl', 	'f_sadadjvdrdocdtl', 
'f_sadadjvoucherhdr', 	'f_scdnaccdtl', 	'f_scdnappostingsdtl', 	
'f_scdndcnotehdr', 	'f_sdinappostingsdtl', 	'f_sdinexpensedtl', 	
'f_sdininvoicehdr', 	'f_sidochdr', 	'f_silinedtl', 	'f_sinappostingsdtl', 	
'f_sininvoicehdr', 	'f_sinitemdtl', 	'f_snpfbpostingdtl', 	
'f_snpvoucherdtl', 	'f_snpvoucherhdr', 	'f_spypaybatchdtl', 	
'f_spypaybatchhdr', 	'f_spyprepayvchhdr', 	'f_spyvoucherdtl', 
'f_spyvoucherhdr', 	'f_surfbpostingsdtl', 
'f_surreceiptdtl', 	'f_surreceipthdr', 
'f_tbpvoucherhdr', 	'f_tcaltranhdr');




update ods.controlheader set  adlscontainername = 'Operational' 
where dwobjectname  not in ( 'd_astaxyearhdr', 	'd_finquickcodemet', 
'f_abbaccountbudgetdtl', 	'f_acapassethdr', 
'f_adepdeprratehdr', 	'f_adeppprocesshdr', 	
'f_ainqcwipaccountinginfo', 	'f_aplanacqproposalhdr', 
'f_aplanproposalbaldtl', 	'f_cbadjadjvcrdocdtl', 	
'f_cbadjadjvdrdocdtl', 	'f_cbadjadjvoucherhdr', 	
'f_cdcnaccdtl', 	'f_cdcnarpostingsdtl', 	'f_cdcndcnotehdr', 
'f_cdcnitemdtl', 	'f_cdiarpostingsdtl', 	'f_cdiinvoicehdr',
'f_cdiitemdtl', 	'f_cidochdr', 	'f_eamamchdr', 	'f_fbpaccountbalance', 
'f_fbppostedtrndtl', 	'f_fbpvoucherdtl', 	'f_fbpvoucherhdr',
'f_jvvouchertrndtl', 	'f_jvvouchertrnhdr', 	'f_rppostingsdtl', 
'f_rptacctinfodtl', 	'f_sadadjvcrdocdtl', 	'f_sadadjvdrdocdtl', 
'f_sadadjvoucherhdr', 	'f_scdnaccdtl', 	'f_scdnappostingsdtl', 	
'f_scdndcnotehdr', 	'f_sdinappostingsdtl', 	'f_sdinexpensedtl', 	
'f_sdininvoicehdr', 	'f_sidochdr', 	'f_silinedtl', 	'f_sinappostingsdtl', 	
'f_sininvoicehdr', 	'f_sinitemdtl', 	'f_snpfbpostingdtl', 	
'f_snpvoucherdtl', 	'f_snpvoucherhdr', 	'f_spypaybatchdtl', 	
'f_spypaybatchhdr', 	'f_spyprepayvchhdr', 	'f_spyvoucherdtl', 
'f_spyvoucherhdr', 	'f_surfbpostingsdtl', 
'f_surreceiptdtl', 	'f_surreceipthdr', 
'f_tbpvoucherhdr', 	'f_tcaltranhdr');

