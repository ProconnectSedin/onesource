--click.f_pnd_oub_activity;

alter TABLE click.f_pnd_oub_activity
add column activeindicator integer;

update click.f_pnd_oub_activity
set activeindicator = 1;


--click.f_skumaster;

alter TABLE click.f_skumaster
add column activeindicator integer;

update click.f_skumaster
set activeindicator = 1;


--click.f_binmaster;

alter TABLE click.f_binmaster
add column activeindicator integer;

update click.f_binmaster
set activeindicator = 1;


--click.f_shipment_details;

alter TABLE click.f_shipment_details
add column activeindicator integer;

update click.f_shipment_details
set activeindicator = 1;


--click.f_sla_shipment;

alter TABLE click.f_sla_shipment
add column activeindicator integer;

update click.f_sla_shipment
set activeindicator = 1;


--click.f_pnd_inb_actvity;

alter TABLE click.f_pnd_inb_actvity
add column activeindicator integer;

update click.f_pnd_inb_actvity
set activeindicator = 1;


--click.f_wh_space_detail;

alter TABLE click.f_wh_space_detail
add column activeindicator integer;

update click.f_wh_space_detail
set activeindicator = 1;


--click.f_wmsinboundsummary;

alter TABLE click.f_wmsinboundsummary
add column activeindicator integer;

update click.f_wmsinboundsummary
set activeindicator = 1;


--click.f_inboundsladetail;

alter TABLE click.f_inboundsladetail
add column activeindicator integer;

update click.f_inboundsladetail
set activeindicator = 1;


--click.f_outboundorderdetail;

alter TABLE click.f_outboundorderdetail
add column activeindicator integer;

update click.f_outboundorderdetail
set activeindicator = 1;


--click.f_outboundpickpackdetail;

alter TABLE click.f_outboundpickpackdetail
add column activeindicator integer;

update click.f_outboundpickpackdetail
set activeindicator = 1;


--click.f_outboundsladetail;

alter TABLE click.f_outboundsladetail
add column activeindicator integer;

update click.f_outboundsladetail
set activeindicator = 1;


--click.f_bin_utilization;

alter TABLE click.f_bin_utilization
add column activeindicator integer;

update click.f_bin_utilization
set activeindicator = 1;