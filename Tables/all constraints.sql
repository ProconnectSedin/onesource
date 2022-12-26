ALTER TABLE ONLY click.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_pkey PRIMARY KEY (acc_mst_key);

ALTER TABLE ONLY click.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_ukey UNIQUE (company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no);

ALTER TABLE ONLY click.d_address
    ADD CONSTRAINT d_adress_pkey PRIMARY KEY (address_key);

ALTER TABLE ONLY click.d_address
    ADD CONSTRAINT d_adress_ukey UNIQUE (address_id);

ALTER TABLE ONLY click.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_pkey PRIMARY KEY (d_asset_mst_key);

ALTER TABLE ONLY click.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_ukey UNIQUE (company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no);

ALTER TABLE ONLY click.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_pkey PRIMARY KEY (bank_acc_mst_key);

ALTER TABLE ONLY click.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_ukey UNIQUE (company_code, bank_ref_no, bank_acc_no, serial_no);

ALTER TABLE ONLY click.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_pkey PRIMARY KEY (d_bank_mst_key);

ALTER TABLE ONLY click.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_ukey UNIQUE (company_code, fb_id, bank_ptt_code, effective_from, sequence_no);

ALTER TABLE ONLY click.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_pkey PRIMARY KEY (bank_ref_mst_key);

ALTER TABLE ONLY click.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_ukey UNIQUE (bank_ref_no, bank_status);

ALTER TABLE ONLY click.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_pkey PRIMARY KEY (bin_typ_loc_code, bin_typ_code, bin_typ_lineno, bin_typ_ou);

ALTER TABLE ONLY click.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_ukey UNIQUE (bin_typ_key);

ALTER TABLE ONLY click.d_bintypes
    ADD CONSTRAINT d_bintypes_pkey PRIMARY KEY (bin_typ_key);

ALTER TABLE ONLY click.d_bintypes
    ADD CONSTRAINT d_bintypes_ukey UNIQUE (bin_typ_ou, bin_typ_code, bin_typ_loc_code);

ALTER TABLE ONLY click.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_pkey PRIMARY KEY (bu_loc_map_key);

ALTER TABLE ONLY click.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_ukey UNIQUE (lo_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY click.d_businessunit
    ADD CONSTRAINT d_businessunit_pkey PRIMARY KEY (bu_key);

ALTER TABLE ONLY click.d_businessunit
    ADD CONSTRAINT d_businessunit_ukey UNIQUE (company_code, bu_id, serial_no);

ALTER TABLE ONLY click.d_company
    ADD CONSTRAINT d_company_pkey PRIMARY KEY (company_key);

ALTER TABLE ONLY click.d_company
    ADD CONSTRAINT d_company_ukey UNIQUE (company_code, serial_no);

ALTER TABLE ONLY click.d_companycurrencymap
    ADD CONSTRAINT d_companycurrencymap_pkey PRIMARY KEY (d_companycurrencymap_key);

ALTER TABLE ONLY click.d_companycurrencymap
    ADD CONSTRAINT d_companycurrencymap_ukey UNIQUE (serial_no, company_code, currency_code);

ALTER TABLE ONLY click.d_consignee
    ADD CONSTRAINT d_consignee_pkey PRIMARY KEY (consignee_hdr_key);

ALTER TABLE ONLY click.d_consignee
    ADD CONSTRAINT d_consignee_ukey UNIQUE (consignee_id, consignee_ou);

ALTER TABLE ONLY click.d_consignor
    ADD CONSTRAINT d_consignor_pkey PRIMARY KEY (consignor_key);

ALTER TABLE ONLY click.d_consignor
    ADD CONSTRAINT d_consignor_ukey UNIQUE (consignor_id, consignor_ou);

ALTER TABLE ONLY click.d_currency
    ADD CONSTRAINT d_currency_pkey PRIMARY KEY (curr_key);

ALTER TABLE ONLY click.d_currency
    ADD CONSTRAINT d_currency_ukey UNIQUE (iso_curr_code, serial_no);

ALTER TABLE ONLY click.d_customer
    ADD CONSTRAINT d_customer_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY click.d_customer
    ADD CONSTRAINT d_customer_ukey UNIQUE (customer_id, customer_ou);

ALTER TABLE ONLY click.d_customerattributes
    ADD CONSTRAINT d_customerattributes_pkey PRIMARY KEY (wms_cust_attr_key);

ALTER TABLE ONLY click.d_customerattributes
    ADD CONSTRAINT d_customerattributes_ukey UNIQUE (wms_cust_attr_cust_code, wms_cust_attr_lineno, wms_cust_attr_ou);

ALTER TABLE ONLY click.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_pkey PRIMARY KEY (cgh_key);

ALTER TABLE ONLY click.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_ukey UNIQUE (cgh_cust_group_code, cgh_group_type_code, cgh_control_group_flag, cgh_lo);

ALTER TABLE ONLY click.d_customerlocation
    ADD CONSTRAINT d_customerlocation_pkey PRIMARY KEY (loc_cust_key);

ALTER TABLE ONLY click.d_customerlocation
    ADD CONSTRAINT d_customerlocation_ukey UNIQUE (loc_ou, loc_code, loc_lineno);

ALTER TABLE ONLY click.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_pkey PRIMARY KEY (clo_key);

ALTER TABLE ONLY click.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_ukey UNIQUE (clo_lo, clo_cust_code);

ALTER TABLE ONLY click.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_pkey PRIMARY KEY (wms_customer_key);

ALTER TABLE ONLY click.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_ukey UNIQUE (wms_customer_id, wms_customer_ou, wms_customer_lineno);

ALTER TABLE ONLY click.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_pkey PRIMARY KEY (cou_key);

ALTER TABLE ONLY click.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_ukey UNIQUE (cou_cust_code, cou_lo, cou_bu, cou_ou);

ALTER TABLE ONLY click.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY click.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_ukey UNIQUE (customer_id, customer_ou, customer_lineno);

ALTER TABLE ONLY click.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_pkey PRIMARY KEY (cpr_key);

ALTER TABLE ONLY click.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_ukey UNIQUE (cpr_lo, cpr_prosp_cust_code);

ALTER TABLE ONLY click.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_pkey PRIMARY KEY (geo_city_key);

ALTER TABLE ONLY click.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_ukey UNIQUE (geo_city_code, geo_city_ou, geo_country_code, geo_state_code, geo_city_lineno);

ALTER TABLE ONLY click.d_date
    ADD CONSTRAINT d_date_date_key_pk PRIMARY KEY (datekey);

ALTER TABLE ONLY click.d_division
    ADD CONSTRAINT d_division_pkey PRIMARY KEY (div_key);

ALTER TABLE ONLY click.d_division
    ADD CONSTRAINT d_division_ukey UNIQUE (div_ou, div_code);

ALTER TABLE ONLY click.d_divloclist
    ADD CONSTRAINT d_divloclist_pkey PRIMARY KEY (div_loc_key);

ALTER TABLE ONLY click.d_divloclist
    ADD CONSTRAINT d_divloclist_ukey UNIQUE (div_ou, div_code, div_lineno);

ALTER TABLE ONLY click.d_employeeheader
    ADD CONSTRAINT d_employeeheader_pkey PRIMARY KEY (emp_hdr_key);

ALTER TABLE ONLY click.d_employeeheader
    ADD CONSTRAINT d_employeeheader_ukey UNIQUE (emp_employee_code, emp_ou);

ALTER TABLE ONLY click.d_employeelicense
    ADD CONSTRAINT d_employeelicense_pkey PRIMARY KEY (emp_key);

ALTER TABLE ONLY click.d_employeelicense
    ADD CONSTRAINT d_employeelicense_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY click.d_employeelocation
    ADD CONSTRAINT d_employeelocation_pkey PRIMARY KEY (emp_loc_key);

ALTER TABLE ONLY click.d_employeelocation
    ADD CONSTRAINT d_employeelocation_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY click.d_employeeskills
    ADD CONSTRAINT d_employeeskills_pkey PRIMARY KEY (emp_skill_key);

ALTER TABLE ONLY click.d_employeeskills
    ADD CONSTRAINT d_employeeskills_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY click.d_employeetype
    ADD CONSTRAINT d_employeetype_pkey PRIMARY KEY (emp_employee_key);

ALTER TABLE ONLY click.d_employeetype
    ADD CONSTRAINT d_employeetype_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY click.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_pkey PRIMARY KEY (emp_udate_key);

ALTER TABLE ONLY click.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_ukey UNIQUE (emp_employee_code, emp_lineno, emp_ou);

ALTER TABLE ONLY click.d_equipment
    ADD CONSTRAINT d_equipment_pkey PRIMARY KEY (eqp_key);

ALTER TABLE ONLY click.d_equipment
    ADD CONSTRAINT d_equipment_ukey UNIQUE (eqp_equipment_id, eqp_ou);

ALTER TABLE ONLY click.d_equipmentgroup
    ADD CONSTRAINT d_equipmentgroup_pkey PRIMARY KEY (egrp_key);

ALTER TABLE ONLY click.d_equipmentgroup
    ADD CONSTRAINT d_equipmentgroup_ukey UNIQUE (egrp_id, egrp_ou);

ALTER TABLE ONLY click.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_pkey PRIMARY KEY (egrp_key);

ALTER TABLE ONLY click.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_ukey UNIQUE (egrp_id, egrp_ou, egrp_lineno);

ALTER TABLE ONLY click.d_excessitem
    ADD CONSTRAINT d_excessitem_pkey PRIMARY KEY (ex_itm_key);

ALTER TABLE ONLY click.d_excessitem
    ADD CONSTRAINT d_excessitem_ukey UNIQUE (ex_itm_code, ex_itm_loc_code, ex_itm_ou);

ALTER TABLE ONLY click.d_exchangerate
    ADD CONSTRAINT d_exchangerate_pkey PRIMARY KEY (d_exchangerate_key);

ALTER TABLE ONLY click.d_exchangerate
    ADD CONSTRAINT d_exchangerate_ukey UNIQUE (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);

ALTER TABLE ONLY click.d_financebook
    ADD CONSTRAINT d_financebook_pkey PRIMARY KEY (fb_key);

ALTER TABLE ONLY click.d_financebook
    ADD CONSTRAINT d_financebook_ukey UNIQUE (fb_id, company_code, serial_no, fb_type);

ALTER TABLE ONLY click.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_pkey PRIMARY KEY (gate_emp_map_key);

ALTER TABLE ONLY click.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_ukey UNIQUE (gate_loc_code, gate_ou, gate_lineno);

ALTER TABLE ONLY click.d_geocountrydetail
    ADD CONSTRAINT d_geocountrydetail_pkey PRIMARY KEY (geo_country_key);

ALTER TABLE ONLY click.d_geocountrydetail
    ADD CONSTRAINT d_geocountrydetail_ukey UNIQUE (geo_country_code, geo_country_ou, geo_country_lineno);

ALTER TABLE ONLY click.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_pkey PRIMARY KEY (geo_postal_key);

ALTER TABLE ONLY click.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_ukey UNIQUE (geo_postal_code, geo_postal_ou, geo_country_code, geo_state_code, geo_city_code, geo_postal_lineno);

ALTER TABLE ONLY click.d_georegion
    ADD CONSTRAINT d_georegion_pkey PRIMARY KEY (geo_reg_key);

ALTER TABLE ONLY click.d_georegion
    ADD CONSTRAINT d_georegion_ukey UNIQUE (geo_reg, geo_reg_ou);

ALTER TABLE ONLY click.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY click.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_ukey UNIQUE (geo_state_code, geo_state_ou, geo_country_code, geo_state_lineno);

ALTER TABLE ONLY click.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY click.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_ukey UNIQUE (geo_country_code, geo_state_code, geo_city_code, geo_postal_code, geo_suburb_code, geo_suburb_ou, geo_suburb_lineno);

ALTER TABLE ONLY click.d_geosubzone
    ADD CONSTRAINT d_geosubzone_pkey PRIMARY KEY (geo_sub_zone_key);

ALTER TABLE ONLY click.d_geosubzone
    ADD CONSTRAINT d_geosubzone_ukey UNIQUE (geo_sub_zone, geo_sub_zone_ou);

ALTER TABLE ONLY click.d_geozone
    ADD CONSTRAINT d_geozone_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY click.d_geozone
    ADD CONSTRAINT d_geozone_ukey UNIQUE (geo_zone, geo_zone_ou);

ALTER TABLE ONLY click.d_hhtmaster
    ADD CONSTRAINT d_hht_master_pkey PRIMARY KEY (hht_master_key);

ALTER TABLE ONLY click.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_pkey PRIMARY KEY (item_igt_key);

ALTER TABLE ONLY click.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_ukey UNIQUE (item_igt_grouptype, item_igt_lo);

ALTER TABLE ONLY click.d_itemheader
    ADD CONSTRAINT d_itemheader_pkey PRIMARY KEY (itm_hdr_key);

ALTER TABLE ONLY click.d_itemheader
    ADD CONSTRAINT d_itemheader_ukey UNIQUE (itm_code, itm_ou);

ALTER TABLE ONLY click.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_pkey PRIMARY KEY (itm_supp_key);

ALTER TABLE ONLY click.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_ukey UNIQUE (itm_ou, itm_code, itm_lineno);

ALTER TABLE ONLY click.d_location
    ADD CONSTRAINT d_location_pkey PRIMARY KEY (loc_key);

ALTER TABLE ONLY click.d_location
    ADD CONSTRAINT d_location_ukey UNIQUE (loc_code, loc_ou);

ALTER TABLE ONLY click.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_pkey PRIMARY KEY (loc_geo_key);

ALTER TABLE ONLY click.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_ukey UNIQUE (loc_ou, loc_code, loc_geo_lineno);

ALTER TABLE ONLY click.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_pkey PRIMARY KEY (loc_opr_dtl_key);

ALTER TABLE ONLY click.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_ukey UNIQUE (loc_opr_loc_code, loc_opr_lineno, loc_opr_ou);

ALTER TABLE ONLY click.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_pkey PRIMARY KEY (loc_shft_dtl_key);

ALTER TABLE ONLY click.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_ukey UNIQUE (loc_code, loc_shft_lineno, loc_ou);

ALTER TABLE ONLY click.d_locationusermapping
    ADD CONSTRAINT d_locationusermapping_pkey PRIMARY KEY (loc_user_mapping_key);

ALTER TABLE ONLY click.d_locationusermapping
    ADD CONSTRAINT d_locationusermapping_ukey UNIQUE (loc_ou, loc_code, loc_lineno);

ALTER TABLE ONLY click.d_locattribute
    ADD CONSTRAINT d_locattribute_pkey PRIMARY KEY (loc_attr_key);

ALTER TABLE ONLY click.d_locattribute
    ADD CONSTRAINT d_locattribute_ukey UNIQUE (loc_attr_loc_code, loc_attr_lineno, loc_attr_ou);

ALTER TABLE ONLY click.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_pkey PRIMARY KEY (opcoa_key);

ALTER TABLE ONLY click.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_ukey UNIQUE (opcoa_id, account_code);

ALTER TABLE ONLY click.d_opscomponentlookup
    ADD CONSTRAINT d_opscomponentlookup_pkey PRIMARY KEY (comp_lkp_key);

ALTER TABLE ONLY click.d_oubumap
    ADD CONSTRAINT d_oubumap_pkey PRIMARY KEY (d_oubumap_key);

ALTER TABLE ONLY click.d_oubumap
    ADD CONSTRAINT d_oubumap_ukey UNIQUE (ou_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY click.d_oumaster
    ADD CONSTRAINT d_oumaster_pkey PRIMARY KEY (ou_key);

ALTER TABLE ONLY click.d_oumaster
    ADD CONSTRAINT d_oumaster_ukey UNIQUE (ou_id, bu_id, company_code, address_id, serial_no);

ALTER TABLE ONLY click.d_route
    ADD CONSTRAINT d_route_pkey PRIMARY KEY (rou_key);

ALTER TABLE ONLY click.d_route
    ADD CONSTRAINT d_route_ukey UNIQUE (rou_route_id, rou_ou);

ALTER TABLE ONLY click.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_pkey PRIMARY KEY (shp_pt_key);

ALTER TABLE ONLY click.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_ukey UNIQUE (shp_pt_ou, shp_pt_id);

ALTER TABLE ONLY click.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_pkey PRIMARY KEY (shp_pt_cus_key);

ALTER TABLE ONLY click.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_ukey UNIQUE (shp_pt_ou, shp_pt_id, shp_pt_lineno);

ALTER TABLE ONLY click.d_skills
    ADD CONSTRAINT d_skills_pkey PRIMARY KEY (skl_key);

ALTER TABLE ONLY click.d_skills
    ADD CONSTRAINT d_skills_ukey UNIQUE (skl_ou, skl_code, skl_type);

ALTER TABLE ONLY click.d_stage
    ADD CONSTRAINT d_stage_pkey PRIMARY KEY (stg_mas_key);

ALTER TABLE ONLY click.d_stage
    ADD CONSTRAINT d_stage_ukey UNIQUE (stg_mas_ou, stg_mas_id, stg_mas_loc);

ALTER TABLE ONLY click.d_tariffservice
    ADD CONSTRAINT d_tariffservice_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY click.d_tariffservice
    ADD CONSTRAINT d_tariffservice_ukey UNIQUE (tf_ser_id, tf_ser_ou);

ALTER TABLE ONLY click.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_pkey PRIMARY KEY (tf_tp_key);

ALTER TABLE ONLY click.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_ukey UNIQUE (tf_tp_id, tf_tp_ou);

ALTER TABLE ONLY click.d_tarifftype
    ADD CONSTRAINT d_tarifftype_pkey PRIMARY KEY (tar_key);

ALTER TABLE ONLY click.d_tarifftype
    ADD CONSTRAINT d_tarifftype_ukey UNIQUE (tar_lineno, tar_ou);

ALTER TABLE ONLY click.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY click.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_ukey UNIQUE (tf_grp_code, tf_type_code);

ALTER TABLE ONLY click.d_thu
    ADD CONSTRAINT d_thu_pkey PRIMARY KEY (thu_key);

ALTER TABLE ONLY click.d_thu
    ADD CONSTRAINT d_thu_ukey UNIQUE (thu_id, thu_ou);

ALTER TABLE ONLY click.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_pkey PRIMARY KEY (thu_itm_key);

ALTER TABLE ONLY click.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_ukey UNIQUE (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);

ALTER TABLE ONLY click.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_pkey PRIMARY KEY (tms_key);

ALTER TABLE ONLY click.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_ukey UNIQUE (tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid);

ALTER TABLE ONLY click.d_uom
    ADD CONSTRAINT d_uom_pkey PRIMARY KEY (uom_key);

ALTER TABLE ONLY click.d_uom
    ADD CONSTRAINT d_uom_ukey UNIQUE (mas_ouinstance, mas_uomcode);

ALTER TABLE ONLY click.d_uomconversion
    ADD CONSTRAINT d_uomconversion_pkey PRIMARY KEY (uom_con_key);

ALTER TABLE ONLY click.d_uomconversion
    ADD CONSTRAINT d_uomconversion_ukey UNIQUE (con_fromuomcode, con_touomcode);

ALTER TABLE ONLY click.d_vehicle
    ADD CONSTRAINT d_vehicle_pkey PRIMARY KEY (veh_key);

ALTER TABLE ONLY click.d_vehicle
    ADD CONSTRAINT d_vehicle_ukey UNIQUE (veh_ou, veh_id);

ALTER TABLE ONLY click.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_pkey PRIMARY KEY (veh_rifo_key);

ALTER TABLE ONLY click.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_ukey UNIQUE (veh_ou, veh_id, veh_line_no);

ALTER TABLE ONLY click.d_vendor
    ADD CONSTRAINT d_vendor_pkey PRIMARY KEY (vendor_key);

ALTER TABLE ONLY click.d_vendor
    ADD CONSTRAINT d_vendor_ukey UNIQUE (vendor_id, vendor_ou);

ALTER TABLE ONLY click.d_warehouse
    ADD CONSTRAINT d_warehouse_pkey PRIMARY KEY (wh_key);

ALTER TABLE ONLY click.d_warehouse
    ADD CONSTRAINT d_warehouse_ukey UNIQUE (wh_code, wh_ou);

ALTER TABLE ONLY click.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY click.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_ukey UNIQUE (geo_zone, geo_zone_ou, geo_zone_lineno, geo_zone_type_code);

ALTER TABLE ONLY click.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_pkey PRIMARY KEY (code_key);

ALTER TABLE ONLY click.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_ukey UNIQUE (code_ou, code_type, code);

ALTER TABLE ONLY click.d_yard
    ADD CONSTRAINT d_yard_pkey PRIMARY KEY (yard_key);

ALTER TABLE ONLY click.d_yard
    ADD CONSTRAINT d_yard_ukey UNIQUE (yard_id, yard_loc_code, yard_ou);

ALTER TABLE ONLY click.d_zone
    ADD CONSTRAINT d_zone_pkey PRIMARY KEY (zone_key);

ALTER TABLE ONLY click.d_zone
    ADD CONSTRAINT d_zone_ukey UNIQUE (zone_code, zone_ou, zone_loc_code);

ALTER TABLE ONLY click.f_asn
    ADD CONSTRAINT f_asn_pkey PRIMARY KEY (asn_key);

ALTER TABLE ONLY click.f_asn
    ADD CONSTRAINT f_asn_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_lineno);

ALTER TABLE ONLY click.f_bin_utilization
    ADD CONSTRAINT f_bin_utilization_pkey PRIMARY KEY (bin_util_key);

ALTER TABLE ONLY click.f_binmaster
    ADD CONSTRAINT f_binmaster_pkey PRIMARY KEY (f_binmaster_key);

ALTER TABLE ONLY click.f_binmaster
    ADD CONSTRAINT f_binmaster_ukey UNIQUE (bin_div_key, bin_typ_key, bin_dtl_key, bin_loc_key);

ALTER TABLE ONLY click.f_grn
    ADD CONSTRAINT f_grn_pkey PRIMARY KEY (grn_key);

ALTER TABLE ONLY click.f_grn
    ADD CONSTRAINT f_grn_ukey UNIQUE (gr_asn_no, gr_loc_code, gr_pln_ou, gr_pln_no, gr_exec_no, gr_lineno);

ALTER TABLE ONLY click.f_inboundsladetail
    ADD CONSTRAINT f_inboundsladetail_pk PRIMARY KEY (sla_ib_key);

ALTER TABLE ONLY click.f_outboundorderdetail
    ADD CONSTRAINT f_outboundorderdetail_pkey PRIMARY KEY (ord_key);

ALTER TABLE ONLY click.f_outboundpickpackdetail
    ADD CONSTRAINT f_outboundpickpackdetail_pk PRIMARY KEY (pickpack_key);

ALTER TABLE ONLY click.f_outboundsladetail
    ADD CONSTRAINT f_outboundsladetail_pk PRIMARY KEY (sla_ob_key);

ALTER TABLE ONLY click.f_pnd_inb_actvity
    ADD CONSTRAINT f_pnd_inb_key PRIMARY KEY (pnd_inb_key);

ALTER TABLE ONLY click.f_pnd_oub_activity
    ADD CONSTRAINT f_pnd_oub_pkey PRIMARY KEY (pnd_oub_key);

ALTER TABLE ONLY click.f_putaway
    ADD CONSTRAINT f_putaway_pkey PRIMARY KEY (pway_key);

ALTER TABLE ONLY click.f_shipment_details
    ADD CONSTRAINT f_shipment_details_pkey PRIMARY KEY (shipment_dtl_key);

ALTER TABLE ONLY click.f_skumaster
    ADD CONSTRAINT f_skumaster_pkey PRIMARY KEY (skumaster_key);

ALTER TABLE ONLY click.f_skumaster
    ADD CONSTRAINT f_skumaster_ukey UNIQUE (sku_ou, itm_hdr_key, d_ex_itm_key, ex_itm_line_no, customer_key);

ALTER TABLE ONLY click.f_sla_shipment
    ADD CONSTRAINT f_sla_shipment_pkey PRIMARY KEY (sla_shipment_key);

ALTER TABLE ONLY click.f_wh_space_detail
    ADD CONSTRAINT f_wh_space_detail_pkey PRIMARY KEY (wh_space_dtl_key);

ALTER TABLE ONLY click.f_wh_space_detail
    ADD CONSTRAINT f_wh_space_detail_ukey UNIQUE (ou, division, location_code, customer_code);

ALTER TABLE ONLY click.f_wmsinboundsummary
    ADD CONSTRAINT f_wmsinboundsummary_pkey PRIMARY KEY (wms_ib_key);

ALTER TABLE ONLY click.f_wmsoutboundsummary
    ADD CONSTRAINT f_wmsoutboundsummary_pkey PRIMARY KEY (wms_ob_key);

ALTER TABLE ONLY dwh.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_pkey PRIMARY KEY (acc_mst_key);

ALTER TABLE ONLY dwh.d_accountadditionalmaster
    ADD CONSTRAINT d_accountadditionalmaster_ukey UNIQUE (company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no);

ALTER TABLE ONLY dwh.d_address
    ADD CONSTRAINT d_adress_pkey PRIMARY KEY (address_key);

ALTER TABLE ONLY dwh.d_address
    ADD CONSTRAINT d_adress_ukey UNIQUE (address_id);

ALTER TABLE ONLY dwh.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_pkey PRIMARY KEY (d_asset_mst_key);

ALTER TABLE ONLY dwh.d_assetaccountmaster
    ADD CONSTRAINT d_assetaccountmaster_ukey UNIQUE (company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no);

ALTER TABLE ONLY dwh.d_astaxyearhdr
    ADD CONSTRAINT d_astaxyearhdr_pkey PRIMARY KEY (taxyr_hdr_key);

ALTER TABLE ONLY dwh.d_astaxyearhdr
    ADD CONSTRAINT d_astaxyearhdr_ukey UNIQUE (taxyr_code);

ALTER TABLE ONLY dwh.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_pkey PRIMARY KEY (bank_acc_mst_key);

ALTER TABLE ONLY dwh.d_bankaccountmaster
    ADD CONSTRAINT d_bankaccountmaster_ukey UNIQUE (company_code, bank_ref_no, bank_acc_no, serial_no);

ALTER TABLE ONLY dwh.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_pkey PRIMARY KEY (d_bank_mst_key);

ALTER TABLE ONLY dwh.d_bankcashaccountmaster
    ADD CONSTRAINT d_bankcashaccountmaster_ukey UNIQUE (company_code, fb_id, bank_ptt_code, effective_from, sequence_no);

ALTER TABLE ONLY dwh.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_pkey PRIMARY KEY (bank_ref_mst_key);

ALTER TABLE ONLY dwh.d_bankrefmaster
    ADD CONSTRAINT d_bankrefmaster_ukey UNIQUE (bank_ref_no, bank_status);

ALTER TABLE ONLY dwh.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_pkey PRIMARY KEY (bin_typ_loc_code, bin_typ_code, bin_typ_lineno, bin_typ_ou);

ALTER TABLE ONLY dwh.d_bintypelocation
    ADD CONSTRAINT d_bintypelocation_ukey UNIQUE (bin_typ_key);

ALTER TABLE ONLY dwh.d_bintypes
    ADD CONSTRAINT d_bintypes_pkey PRIMARY KEY (bin_typ_key);

ALTER TABLE ONLY dwh.d_bintypes
    ADD CONSTRAINT d_bintypes_ukey UNIQUE (bin_typ_ou, bin_typ_code, bin_typ_loc_code);

ALTER TABLE ONLY dwh.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_pkey PRIMARY KEY (bu_loc_map_key);

ALTER TABLE ONLY dwh.d_bulocationmap
    ADD CONSTRAINT d_bulocationmap_ukey UNIQUE (lo_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY dwh.d_businessunit
    ADD CONSTRAINT d_businessunit_pkey PRIMARY KEY (bu_key);

ALTER TABLE ONLY dwh.d_businessunit
    ADD CONSTRAINT d_businessunit_ukey UNIQUE (company_code, bu_id, serial_no);

ALTER TABLE ONLY dwh.d_company
    ADD CONSTRAINT d_company_pkey PRIMARY KEY (company_key);

ALTER TABLE ONLY dwh.d_company
    ADD CONSTRAINT d_company_ukey UNIQUE (company_code, serial_no);

ALTER TABLE ONLY dwh.d_companycurrencymap
    ADD CONSTRAINT d_companycurrencymap_pkey PRIMARY KEY (d_companycurrencymap_key);

ALTER TABLE ONLY dwh.d_companycurrencymap
    ADD CONSTRAINT d_companycurrencymap_ukey UNIQUE (serial_no, company_code, currency_code);

ALTER TABLE ONLY dwh.d_consignee
    ADD CONSTRAINT d_consignee_pkey PRIMARY KEY (consignee_hdr_key);

ALTER TABLE ONLY dwh.d_consignee
    ADD CONSTRAINT d_consignee_ukey UNIQUE (consignee_id, consignee_ou);

ALTER TABLE ONLY dwh.d_consignor
    ADD CONSTRAINT d_consignor_pkey PRIMARY KEY (consignor_key);

ALTER TABLE ONLY dwh.d_consignor
    ADD CONSTRAINT d_consignor_ukey UNIQUE (consignor_id, consignor_ou);

ALTER TABLE ONLY dwh.d_currency
    ADD CONSTRAINT d_currency_pkey PRIMARY KEY (curr_key);

ALTER TABLE ONLY dwh.d_currency
    ADD CONSTRAINT d_currency_ukey UNIQUE (iso_curr_code, serial_no);

ALTER TABLE ONLY dwh.d_customer
    ADD CONSTRAINT d_customer_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY dwh.d_customer
    ADD CONSTRAINT d_customer_ukey UNIQUE (customer_id, customer_ou);

ALTER TABLE ONLY dwh.d_customerattributes
    ADD CONSTRAINT d_customerattributes_pkey PRIMARY KEY (wms_cust_attr_key);

ALTER TABLE ONLY dwh.d_customerattributes
    ADD CONSTRAINT d_customerattributes_ukey UNIQUE (wms_cust_attr_cust_code, wms_cust_attr_lineno, wms_cust_attr_ou);

ALTER TABLE ONLY dwh.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_pkey PRIMARY KEY (cgh_key);

ALTER TABLE ONLY dwh.d_customergrouphdr
    ADD CONSTRAINT d_customergrouphdr_ukey UNIQUE (cgh_cust_group_code, cgh_group_type_code, cgh_control_group_flag, cgh_lo);

ALTER TABLE ONLY dwh.d_customerlocation
    ADD CONSTRAINT d_customerlocation_pkey PRIMARY KEY (loc_cust_key);

ALTER TABLE ONLY dwh.d_customerlocation
    ADD CONSTRAINT d_customerlocation_ukey UNIQUE (loc_ou, loc_code, loc_lineno);

ALTER TABLE ONLY dwh.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_pkey PRIMARY KEY (clo_key);

ALTER TABLE ONLY dwh.d_customerlocationinfo
    ADD CONSTRAINT d_customerlocationinfo_ukey UNIQUE (clo_lo, clo_cust_code);

ALTER TABLE ONLY dwh.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_pkey PRIMARY KEY (wms_customer_key);

ALTER TABLE ONLY dwh.d_customerlocdiv
    ADD CONSTRAINT d_customerlocdiv_ukey UNIQUE (wms_customer_id, wms_customer_ou, wms_customer_lineno);

ALTER TABLE ONLY dwh.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_pkey PRIMARY KEY (cou_key);

ALTER TABLE ONLY dwh.d_customerouinfo
    ADD CONSTRAINT d_customerouinfo_ukey UNIQUE (cou_cust_code, cou_lo, cou_bu, cou_ou);

ALTER TABLE ONLY dwh.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_pkey PRIMARY KEY (customer_key);

ALTER TABLE ONLY dwh.d_customerportalusermap
    ADD CONSTRAINT d_customerportalusermap_ukey UNIQUE (customer_id, customer_ou, customer_lineno);

ALTER TABLE ONLY dwh.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_pkey PRIMARY KEY (cpr_key);

ALTER TABLE ONLY dwh.d_custprospectinfo
    ADD CONSTRAINT d_custprospectinfo_ukey UNIQUE (cpr_lo, cpr_prosp_cust_code);

ALTER TABLE ONLY dwh.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_pkey PRIMARY KEY (geo_city_key);

ALTER TABLE ONLY dwh.d_geocitydetail
    ADD CONSTRAINT d_d_geocitydtl_ukey UNIQUE (geo_city_code, geo_city_ou, geo_country_code, geo_state_code, geo_city_lineno);

ALTER TABLE ONLY dwh.d_daily_stock_balance
    ADD CONSTRAINT d_daily_stock_balance_idx PRIMARY KEY (row_id);

ALTER TABLE ONLY dwh.d_date
    ADD CONSTRAINT d_date_date_key_pk PRIMARY KEY (datekey);

ALTER TABLE ONLY dwh.d_date
    ADD CONSTRAINT d_date_ukey UNIQUE (dateactual);

ALTER TABLE ONLY dwh.d_division
    ADD CONSTRAINT d_division_pkey PRIMARY KEY (div_key);

ALTER TABLE ONLY dwh.d_division
    ADD CONSTRAINT d_division_ukey UNIQUE (div_ou, div_code);

ALTER TABLE ONLY dwh.d_divloclist
    ADD CONSTRAINT d_divloclist_pkey PRIMARY KEY (div_loc_key);

ALTER TABLE ONLY dwh.d_divloclist
    ADD CONSTRAINT d_divloclist_ukey UNIQUE (div_ou, div_code, div_lineno);

ALTER TABLE ONLY dwh.d_employeeheader
    ADD CONSTRAINT d_employeeheader_pkey PRIMARY KEY (emp_hdr_key);

ALTER TABLE ONLY dwh.d_employeeheader
    ADD CONSTRAINT d_employeeheader_ukey UNIQUE (emp_employee_code, emp_ou);

ALTER TABLE ONLY dwh.d_employeelicense
    ADD CONSTRAINT d_employeelicense_pkey PRIMARY KEY (emp_key);

ALTER TABLE ONLY dwh.d_employeelicense
    ADD CONSTRAINT d_employeelicense_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY dwh.d_employeelocation
    ADD CONSTRAINT d_employeelocation_pkey PRIMARY KEY (emp_loc_key);

ALTER TABLE ONLY dwh.d_employeelocation
    ADD CONSTRAINT d_employeelocation_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY dwh.d_employeeskills
    ADD CONSTRAINT d_employeeskills_pkey PRIMARY KEY (emp_skill_key);

ALTER TABLE ONLY dwh.d_employeeskills
    ADD CONSTRAINT d_employeeskills_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY dwh.d_employeetype
    ADD CONSTRAINT d_employeetype_pkey PRIMARY KEY (emp_employee_key);

ALTER TABLE ONLY dwh.d_employeetype
    ADD CONSTRAINT d_employeetype_ukey UNIQUE (emp_employee_code, emp_ou, emp_lineno);

ALTER TABLE ONLY dwh.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_pkey PRIMARY KEY (emp_udate_key);

ALTER TABLE ONLY dwh.d_employeeunavdate
    ADD CONSTRAINT d_employeeunavdate_ukey UNIQUE (emp_employee_code, emp_lineno, emp_ou);

ALTER TABLE ONLY dwh.d_equipment
    ADD CONSTRAINT d_equipment_pkey PRIMARY KEY (eqp_key);

ALTER TABLE ONLY dwh.d_equipment
    ADD CONSTRAINT d_equipment_ukey UNIQUE (eqp_equipment_id, eqp_ou);

ALTER TABLE ONLY dwh.d_equipmentgroup
    ADD CONSTRAINT d_equipmentgroup_pkey PRIMARY KEY (egrp_key);

ALTER TABLE ONLY dwh.d_equipmentgroup
    ADD CONSTRAINT d_equipmentgroup_ukey UNIQUE (egrp_id, egrp_ou);

ALTER TABLE ONLY dwh.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_pkey PRIMARY KEY (egrp_key);

ALTER TABLE ONLY dwh.d_equipmentgroupdtl
    ADD CONSTRAINT d_equipmentgroupdtl_ukey UNIQUE (egrp_id, egrp_ou, egrp_lineno);

ALTER TABLE ONLY dwh.d_excessitem
    ADD CONSTRAINT d_excessitem_pkey PRIMARY KEY (ex_itm_key);

ALTER TABLE ONLY dwh.d_excessitem
    ADD CONSTRAINT d_excessitem_ukey UNIQUE (ex_itm_code, ex_itm_loc_code, ex_itm_ou);

ALTER TABLE ONLY dwh.d_excessitemsuconvdetail
    ADD CONSTRAINT d_excessitemsuconvdetail_pkey PRIMARY KEY (d_ex_itm_key);

ALTER TABLE ONLY dwh.d_exchangerate
    ADD CONSTRAINT d_exchangerate_pkey PRIMARY KEY (d_exchangerate_key);

ALTER TABLE ONLY dwh.d_exchangerate
    ADD CONSTRAINT d_exchangerate_ukey UNIQUE (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);

ALTER TABLE ONLY dwh.d_financebook
    ADD CONSTRAINT d_financebook_pkey PRIMARY KEY (fb_key);

ALTER TABLE ONLY dwh.d_financebook
    ADD CONSTRAINT d_financebook_ukey UNIQUE (fb_id, company_code, serial_no, fb_type);

ALTER TABLE ONLY dwh.d_finquickcodemet
    ADD CONSTRAINT d_finquickcodemet_pkey PRIMARY KEY (d_finquickcodemet_key);

ALTER TABLE ONLY dwh.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_pkey PRIMARY KEY (gate_emp_map_key);

ALTER TABLE ONLY dwh.d_gateemployeemapping
    ADD CONSTRAINT d_gateemployeemapping_ukey UNIQUE (gate_loc_code, gate_ou, gate_lineno);

ALTER TABLE ONLY dwh.d_geocountrydetail
    ADD CONSTRAINT d_geocountrydetail_pkey PRIMARY KEY (geo_country_key);

ALTER TABLE ONLY dwh.d_geocountrydetail
    ADD CONSTRAINT d_geocountrydetail_ukey UNIQUE (geo_country_code, geo_country_ou, geo_country_lineno);

ALTER TABLE ONLY dwh.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_pkey PRIMARY KEY (geo_postal_key);

ALTER TABLE ONLY dwh.d_geopostaldetail
    ADD CONSTRAINT d_geopostaldetail_ukey UNIQUE (geo_postal_code, geo_postal_ou, geo_country_code, geo_state_code, geo_city_code, geo_postal_lineno);

ALTER TABLE ONLY dwh.d_georegion
    ADD CONSTRAINT d_georegion_pkey PRIMARY KEY (geo_reg_key);

ALTER TABLE ONLY dwh.d_georegion
    ADD CONSTRAINT d_georegion_ukey UNIQUE (geo_reg, geo_reg_ou);

ALTER TABLE ONLY dwh.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY dwh.d_geostatedetail
    ADD CONSTRAINT d_geostatedetail_ukey UNIQUE (geo_state_code, geo_state_ou, geo_country_code, geo_state_lineno);

ALTER TABLE ONLY dwh.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_pkey PRIMARY KEY (geo_state_key);

ALTER TABLE ONLY dwh.d_geosuburbdetail
    ADD CONSTRAINT d_geosuburbdetail_ukey UNIQUE (geo_country_code, geo_state_code, geo_city_code, geo_postal_code, geo_suburb_code, geo_suburb_ou, geo_suburb_lineno);

ALTER TABLE ONLY dwh.d_geosubzone
    ADD CONSTRAINT d_geosubzone_pkey PRIMARY KEY (geo_sub_zone_key);

ALTER TABLE ONLY dwh.d_geosubzone
    ADD CONSTRAINT d_geosubzone_ukey UNIQUE (geo_sub_zone, geo_sub_zone_ou);

ALTER TABLE ONLY dwh.d_geozone
    ADD CONSTRAINT d_geozone_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY dwh.d_geozone
    ADD CONSTRAINT d_geozone_ukey UNIQUE (geo_zone, geo_zone_ou);

ALTER TABLE ONLY dwh.d_hht_master
    ADD CONSTRAINT d_hht_master_pkey PRIMARY KEY (d_hht_master_key);

ALTER TABLE ONLY dwh.d_inboundtat
    ADD CONSTRAINT d_inboundtat_pkey PRIMARY KEY (d_inboundtat_key);

ALTER TABLE ONLY dwh.d_inboundtat
    ADD CONSTRAINT d_inboundtat_ukey UNIQUE (id, ou, locationcode, ordertype, servicetype);

ALTER TABLE ONLY dwh.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_pkey PRIMARY KEY (item_igt_key);

ALTER TABLE ONLY dwh.d_itemgrouptype
    ADD CONSTRAINT d_itemgrouptype_ukey UNIQUE (item_igt_grouptype, item_igt_lo);

ALTER TABLE ONLY dwh.d_itemheader
    ADD CONSTRAINT d_itemheader_pkey PRIMARY KEY (itm_hdr_key);

ALTER TABLE ONLY dwh.d_itemheader
    ADD CONSTRAINT d_itemheader_ukey UNIQUE (itm_code, itm_ou);

ALTER TABLE ONLY dwh.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_pkey PRIMARY KEY (itm_supp_key);

ALTER TABLE ONLY dwh.d_itemsuppliermap
    ADD CONSTRAINT d_itemsuppliermap_ukey UNIQUE (itm_ou, itm_code, itm_lineno);

ALTER TABLE ONLY dwh.d_location
    ADD CONSTRAINT d_location_pkey PRIMARY KEY (loc_key);

ALTER TABLE ONLY dwh.d_location
    ADD CONSTRAINT d_location_ukey UNIQUE (loc_code, loc_ou);

ALTER TABLE ONLY dwh.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_pkey PRIMARY KEY (loc_geo_key);

ALTER TABLE ONLY dwh.d_locationgeomap
    ADD CONSTRAINT d_locationgeomap_ukey UNIQUE (loc_ou, loc_code, loc_geo_lineno);

ALTER TABLE ONLY dwh.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_pkey PRIMARY KEY (loc_opr_dtl_key);

ALTER TABLE ONLY dwh.d_locationoperationsdetail
    ADD CONSTRAINT d_locationoperationsdetail_ukey UNIQUE (loc_opr_loc_code, loc_opr_lineno, loc_opr_ou);

ALTER TABLE ONLY dwh.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_pkey PRIMARY KEY (loc_shft_dtl_key);

ALTER TABLE ONLY dwh.d_locationshiftdetails
    ADD CONSTRAINT d_locationshiftdetails_ukey UNIQUE (loc_code, loc_shft_lineno, loc_ou);

ALTER TABLE ONLY dwh.d_locationusermapping
    ADD CONSTRAINT d_locationusermapping_pkey PRIMARY KEY (loc_user_mapping_key);

ALTER TABLE ONLY dwh.d_locationusermapping
    ADD CONSTRAINT d_locationusermapping_ukey UNIQUE (loc_ou, loc_code, loc_lineno);

ALTER TABLE ONLY dwh.d_locattribute
    ADD CONSTRAINT d_locattribute_pkey PRIMARY KEY (loc_attr_key);

ALTER TABLE ONLY dwh.d_locattribute
    ADD CONSTRAINT d_locattribute_ukey UNIQUE (loc_attr_loc_code, loc_attr_lineno, loc_attr_ou);

ALTER TABLE ONLY dwh.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_pkey PRIMARY KEY (opcoa_key);

ALTER TABLE ONLY dwh.d_operationalaccountdetail
    ADD CONSTRAINT d_operationalaccountdetail_ukey UNIQUE (opcoa_id, account_code);

ALTER TABLE ONLY dwh.d_opscomponentlookup
    ADD CONSTRAINT d_opscomponentlookup_pkey PRIMARY KEY (comp_lkp_key);

ALTER TABLE ONLY dwh.d_oubumap
    ADD CONSTRAINT d_oubumap_pkey PRIMARY KEY (d_oubumap_key);

ALTER TABLE ONLY dwh.d_oubumap
    ADD CONSTRAINT d_oubumap_ukey UNIQUE (ou_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY dwh.d_oumaster
    ADD CONSTRAINT d_oumaster_pkey PRIMARY KEY (ou_key);

ALTER TABLE ONLY dwh.d_oumaster
    ADD CONSTRAINT d_oumaster_ukey UNIQUE (ou_id, bu_id, company_code, address_id, serial_no);

ALTER TABLE ONLY dwh.d_outboundlocshiftdetail
    ADD CONSTRAINT d_outboundlocshiftdetail_pkey PRIMARY KEY (obd_loc_dtl_key);

ALTER TABLE ONLY dwh.d_route
    ADD CONSTRAINT d_route_pkey PRIMARY KEY (rou_key);

ALTER TABLE ONLY dwh.d_route
    ADD CONSTRAINT d_route_ukey UNIQUE (rou_route_id, rou_ou);

ALTER TABLE ONLY dwh.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_pkey PRIMARY KEY (shp_pt_key);

ALTER TABLE ONLY dwh.d_shippingpoint
    ADD CONSTRAINT d_shippingpoint_ukey UNIQUE (shp_pt_ou, shp_pt_id);

ALTER TABLE ONLY dwh.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_pkey PRIMARY KEY (shp_pt_cus_key);

ALTER TABLE ONLY dwh.d_shippingpointcustmap
    ADD CONSTRAINT d_shippingpointcustmap_ukey UNIQUE (shp_pt_ou, shp_pt_id, shp_pt_lineno);

ALTER TABLE ONLY dwh.d_skills
    ADD CONSTRAINT d_skills_pkey PRIMARY KEY (skl_key);

ALTER TABLE ONLY dwh.d_skills
    ADD CONSTRAINT d_skills_ukey UNIQUE (skl_ou, skl_code, skl_type);

ALTER TABLE ONLY dwh.d_stage
    ADD CONSTRAINT d_stage_pkey PRIMARY KEY (stg_mas_key);

ALTER TABLE ONLY dwh.d_stage
    ADD CONSTRAINT d_stage_ukey UNIQUE (stg_mas_ou, stg_mas_id, stg_mas_loc);

ALTER TABLE ONLY dwh.d_tariffservice
    ADD CONSTRAINT d_tariffservice_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY dwh.d_tariffservice
    ADD CONSTRAINT d_tariffservice_ukey UNIQUE (tf_ser_id, tf_ser_ou);

ALTER TABLE ONLY dwh.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_pkey PRIMARY KEY (tf_tp_key);

ALTER TABLE ONLY dwh.d_tarifftransport
    ADD CONSTRAINT d_tarifftransport_ukey UNIQUE (tf_tp_id, tf_tp_ou);

ALTER TABLE ONLY dwh.d_tarifftype
    ADD CONSTRAINT d_tarifftype_pkey PRIMARY KEY (tar_key);

ALTER TABLE ONLY dwh.d_tarifftype
    ADD CONSTRAINT d_tarifftype_ukey UNIQUE (tar_lineno, tar_ou);

ALTER TABLE ONLY dwh.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_pkey PRIMARY KEY (tf_key);

ALTER TABLE ONLY dwh.d_tarifftypegroup
    ADD CONSTRAINT d_tarifftypegroup_ukey UNIQUE (tf_grp_code, tf_type_code);

ALTER TABLE ONLY dwh.d_thu
    ADD CONSTRAINT d_thu_pkey PRIMARY KEY (thu_key);

ALTER TABLE ONLY dwh.d_thu
    ADD CONSTRAINT d_thu_ukey UNIQUE (thu_id, thu_ou);

ALTER TABLE ONLY dwh.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_pkey PRIMARY KEY (thu_itm_key);

ALTER TABLE ONLY dwh.d_thuitemmap
    ADD CONSTRAINT d_thuitemmap_ukey UNIQUE (thu_loc_code, thu_ou, thu_serial_no, thu_id, thu_item, thu_lot_no, thu_itm_serial_no);

ALTER TABLE ONLY dwh.d_tmsdeliverytat
    ADD CONSTRAINT d_tmsdeliverytat_pkey PRIMARY KEY (tms_dly_tat_key);

ALTER TABLE ONLY dwh.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_pkey PRIMARY KEY (tms_key);

ALTER TABLE ONLY dwh.d_tmsparameter
    ADD CONSTRAINT d_tmsparameter_ukey UNIQUE (tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid);

ALTER TABLE ONLY dwh.d_uom
    ADD CONSTRAINT d_uom_pkey PRIMARY KEY (uom_key);

ALTER TABLE ONLY dwh.d_uom
    ADD CONSTRAINT d_uom_ukey UNIQUE (mas_ouinstance, mas_uomcode);

ALTER TABLE ONLY dwh.d_uomconversion
    ADD CONSTRAINT d_uomconversion_pkey PRIMARY KEY (uom_con_key);

ALTER TABLE ONLY dwh.d_uomconversion
    ADD CONSTRAINT d_uomconversion_ukey UNIQUE (con_fromuomcode, con_touomcode);

ALTER TABLE ONLY dwh.d_vehicle
    ADD CONSTRAINT d_vehicle_pkey PRIMARY KEY (veh_key);

ALTER TABLE ONLY dwh.d_vehicle
    ADD CONSTRAINT d_vehicle_ukey UNIQUE (veh_ou, veh_id);

ALTER TABLE ONLY dwh.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_pkey PRIMARY KEY (veh_rifo_key);

ALTER TABLE ONLY dwh.d_vehiclereginfo
    ADD CONSTRAINT d_vehiclereginfo_ukey UNIQUE (veh_ou, veh_id, veh_line_no);

ALTER TABLE ONLY dwh.d_vendor
    ADD CONSTRAINT d_vendor_pkey PRIMARY KEY (vendor_key);

ALTER TABLE ONLY dwh.d_vendor
    ADD CONSTRAINT d_vendor_ukey UNIQUE (vendor_id, vendor_ou);

ALTER TABLE ONLY dwh.d_warehouse
    ADD CONSTRAINT d_warehouse_pkey PRIMARY KEY (wh_key);

ALTER TABLE ONLY dwh.d_warehouse
    ADD CONSTRAINT d_warehouse_ukey UNIQUE (wh_code, wh_ou);

ALTER TABLE ONLY dwh.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_pkey PRIMARY KEY (geo_zone_key);

ALTER TABLE ONLY dwh.d_wmsgeozonedetail
    ADD CONSTRAINT d_wmsgeozonedetail_ukey UNIQUE (geo_zone, geo_zone_ou, geo_zone_lineno, geo_zone_type_code);

ALTER TABLE ONLY dwh.d_wmsoutboundtat
    ADD CONSTRAINT d_wmsoutboundtat_pkey PRIMARY KEY (wms_obd_tat_key);

ALTER TABLE ONLY dwh.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_pkey PRIMARY KEY (code_key);

ALTER TABLE ONLY dwh.d_wmsquickcodes
    ADD CONSTRAINT d_wmsquickcodes_ukey UNIQUE (code_ou, code_type, code);

ALTER TABLE ONLY dwh.d_yard
    ADD CONSTRAINT d_yard_pkey PRIMARY KEY (yard_key);

ALTER TABLE ONLY dwh.d_yard
    ADD CONSTRAINT d_yard_ukey UNIQUE (yard_id, yard_loc_code, yard_ou);

ALTER TABLE ONLY dwh.d_zone
    ADD CONSTRAINT d_zone_pkey PRIMARY KEY (zone_key);

ALTER TABLE ONLY dwh.d_zone
    ADD CONSTRAINT d_zone_ukey UNIQUE (zone_code, zone_ou, zone_loc_code);

ALTER TABLE ONLY dwh.f_abbaccountbudgetdtl
    ADD CONSTRAINT f_abbaccountbudgetdtl_pkey PRIMARY KEY (f_abbaccountbudgetdtl_key);

ALTER TABLE ONLY dwh.f_abbaccountbudgetdtl
    ADD CONSTRAINT f_abbaccountbudgetdtl_ukey UNIQUE (company_code, fb_id, fin_year_code, fin_period_code, account_code);

ALTER TABLE ONLY dwh.f_acapassethdr
    ADD CONSTRAINT f_acapassethdr_pkey PRIMARY KEY (f_acapassethdr_key);

ALTER TABLE ONLY dwh.f_acapassethdr
    ADD CONSTRAINT f_acapassethdr_ukey UNIQUE (ou_id, cap_number, asset_number);

ALTER TABLE ONLY dwh.f_adepdeprratehdr
    ADD CONSTRAINT f_adepdeprratehdr_pkey PRIMARY KEY (f_adepdeprratehdr_key);

ALTER TABLE ONLY dwh.f_adepdeprratehdr
    ADD CONSTRAINT f_adepdeprratehdr_ukey UNIQUE (ou_id, asset_class, depr_rate_id);

ALTER TABLE ONLY dwh.f_adeppprocesshdr
    ADD CONSTRAINT f_adeppprocesshdr_pkey PRIMARY KEY (f_adeppprocesshdr_key);

ALTER TABLE ONLY dwh.f_adeppprocesshdr
    ADD CONSTRAINT f_adeppprocesshdr_ukey UNIQUE (ou_id, depr_proc_runno, depr_book);

ALTER TABLE ONLY dwh.f_ainqcwipaccountinginfo
    ADD CONSTRAINT f_ainqcwipaccountinginfo_pkey PRIMARY KEY (f_ainqcwipaccountinginfo_key);

ALTER TABLE ONLY dwh.f_ainqcwipaccountinginfo
    ADD CONSTRAINT f_ainqcwipaccountinginfo_ukey UNIQUE (tran_ou, component_id, company_code, tran_number, proposal_no);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_pkey PRIMARY KEY (allc_key);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_ukey UNIQUE (allc_ouinstid, allc_doc_no, allc_doc_ou, allc_doc_line_no, allc_alloc_line_no);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_pkey PRIMARY KEY (pln_pro_key);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_ukey UNIQUE (ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number, addnl_entity);

ALTER TABLE ONLY dwh.f_aplanproposalbaldtl
    ADD CONSTRAINT f_aplanproposalbaldtl_pkey PRIMARY KEY (pln_pro_dtl_key);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_pkey PRIMARY KEY (asn_add_dl_key);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_ukey UNIQUE (asn_pop_asn_no, asn_pop_loc, asn_pop_ou, asn_pop_line_no);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_pkey PRIMARY KEY (asn_dtl_hst_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_amendno, asn_lineno);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_pkey PRIMARY KEY (asn_dtl_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_lineno);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_pkey PRIMARY KEY (asn_hr_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_ukey UNIQUE (asn_ou, asn_location, asn_no);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_pkey PRIMARY KEY (asn_hdr_hst_key);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_ukey UNIQUE (asn_ou, asn_location, asn_no, asn_amendno);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_pkey PRIMARY KEY (bin_dtl_key);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_ukey UNIQUE (bin_ou, bin_code, bin_loc_code, bin_zone, bin_type);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_pkey PRIMARY KEY (bin_exec_dtl_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_ukey UNIQUE (bin_loc_code, bin_exec_no, bin_pln_lineno, bin_exec_ou);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_pkey PRIMARY KEY (bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_ukey UNIQUE (bin_loc_code, bin_exec_no, bin_exec_ou);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_pkey PRIMARY KEY (bin_itm_dtl_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_ukey UNIQUE (bin_exec_no, bin_ref_lineno, bin_exec_lineno, bin_exec_ou, bin_loc_code);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_pkey PRIMARY KEY (bin_plan_key);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_ukey UNIQUE (bin_loc_code, bin_pln_no, bin_pln_lineno, bin_pln_ou);

ALTER TABLE ONLY dwh.f_binplanheader
    ADD CONSTRAINT f_binplanheader_pkey PRIMARY KEY (bin_hdr_key);

ALTER TABLE ONLY dwh.f_binplanheader
    ADD CONSTRAINT f_binplanheader_ukey UNIQUE (bin_loc_code, bin_pln_no, bin_pln_ou);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_pkey PRIMARY KEY (br_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_ukey UNIQUE (br_ouinstance, br_request_id);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_pkey PRIMARY KEY (br_bkreq_key);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_ukey UNIQUE (br_ouinstance, br_request_id, amend_no);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_pkey PRIMARY KEY (brccd_key);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_ukey UNIQUE (ccd_ouinstance, ccd_br_id);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_pkey PRIMARY KEY (brcd_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_ukey UNIQUE (cd_ouinstance, cd_br_id, cd_line_no);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_pkey PRIMARY KEY (brcsd_key);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_ukey UNIQUE (brcsd_ou, brcsd_br_id, brcsd_thu_line_no, brcsd_sku_line_no);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_pkey PRIMARY KEY (ctsd_thu_key);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_ukey UNIQUE (ctsd_ouinstance, ctsd_br_id, ctsd_thu_line_no, ctsd_thu_serial_line_no);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_pkey PRIMARY KEY (ewbd_key);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_ukey UNIQUE (ewbd_br_no, ewbd_ouinstance);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_pkey PRIMARY KEY (brppd_key);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_ukey UNIQUE (brppd_ouinstance, brppd_profile_id, brppd_br_id);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_pkey PRIMARY KEY (brsd_key);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_ukey UNIQUE (brsd_ouinstance, brsd_br_id);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_pkey PRIMARY KEY (brctd_key);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_ukey UNIQUE (brctd_ou, brctd_br_id, brctd_tariff_id, brctd_thu_line_no, brctd_staging_ref_document);

ALTER TABLE ONLY dwh.f_cbadjadjvcrdocdtl
    ADD CONSTRAINT f_cbadjadjvcrdocdtl_pkey PRIMARY KEY (adj_docdtl_key);

ALTER TABLE ONLY dwh.f_cbadjadjvcrdocdtl
    ADD CONSTRAINT f_cbadjadjvcrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type);

ALTER TABLE ONLY dwh.f_cbadjadjvdrdocdtl
    ADD CONSTRAINT f_cbadjadjvdrdocdtl_pkey PRIMARY KEY (adj_vdr_doc_dtl_key);

ALTER TABLE ONLY dwh.f_cbadjadjvdrdocdtl
    ADD CONSTRAINT f_cbadjadjvdrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, voucher_tran_type);

ALTER TABLE ONLY dwh.f_cbadjadjvoucherhdr
    ADD CONSTRAINT f_cbadjadjvoucherhdr_pkey PRIMARY KEY (adj_voucher_hdr_key);

ALTER TABLE ONLY dwh.f_cbadjadjvoucherhdr
    ADD CONSTRAINT f_cbadjadjvoucherhdr_ukey UNIQUE (ou_id, adj_voucher_no, voucher_tran_type);

ALTER TABLE ONLY dwh.f_cdcnaccdtl
    ADD CONSTRAINT f_cdcnaccdtl_pkey PRIMARY KEY (cd_cn_accdtl_key);

ALTER TABLE ONLY dwh.f_cdcnaccdtl
    ADD CONSTRAINT f_cdcnaccdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY dwh.f_cdcnarpostingsdtl
    ADD CONSTRAINT f_cdcnarpostingsdtl_pkey PRIMARY KEY (cdcnarpostingsdtl_key);

ALTER TABLE ONLY dwh.f_cdcnarpostingsdtl
    ADD CONSTRAINT f_cdcnarpostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY dwh.f_cdiarpostingsdtl
    ADD CONSTRAINT f_cdiarpostingsdtl_pkey PRIMARY KEY (cdi_dtl_key);

ALTER TABLE ONLY dwh.f_cdiarpostingsdtl
    ADD CONSTRAINT f_cdiarpostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, ctimestamp);

ALTER TABLE ONLY dwh.f_cdiinvoicehdr
    ADD CONSTRAINT f_cdiinvoicehdr_pkey PRIMARY KEY (cdi_inv_hdr_key);

ALTER TABLE ONLY dwh.f_cdiinvoicehdr
    ADD CONSTRAINT f_cdiinvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, ctimestamp, ict_flag, lgt_invoice, mail_sent);

ALTER TABLE ONLY dwh.f_cdiitemdtl
    ADD CONSTRAINT f_cdiitemdtl_pkey PRIMARY KEY (cdi_itm_dtl_key);

ALTER TABLE ONLY dwh.f_cdiitemdtl
    ADD CONSTRAINT f_cdiitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY dwh.f_cidochdr
    ADD CONSTRAINT f_cidochdr_pkey PRIMARY KEY (cid_hdr_key);

ALTER TABLE ONLY dwh.f_cidochdr
    ADD CONSTRAINT f_cidochdr_ukey UNIQUE (tran_ou, tran_type, tran_no, ctimestamp);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contract_pkey PRIMARY KEY (cont_hdr_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contract_ukey UNIQUE (cont_id, cont_ou);

ALTER TABLE ONLY dwh.f_contractdetail
    ADD CONSTRAINT f_contractdetail_pkey PRIMARY KEY (cont_dtl_key);

ALTER TABLE ONLY dwh.f_contractdetail
    ADD CONSTRAINT f_contractdetail_ukey UNIQUE (cont_id, cont_lineno, cont_ou, cont_tariff_id);

ALTER TABLE ONLY dwh.f_contractdetailhistory
    ADD CONSTRAINT f_contractdetailhistory_pkey PRIMARY KEY (cont_dtl_hst_key);

ALTER TABLE ONLY dwh.f_contractdetailhistory
    ADD CONSTRAINT f_contractdetailhistory_ukey UNIQUE (cont_id, cont_lineno, cont_ou, cont_amendno);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_pkey PRIMARY KEY (cont_hdr_hst_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_ukey UNIQUE (cont_id, cont_ou, cont_amendno);

ALTER TABLE ONLY dwh.f_contractrevleakdetail
    ADD CONSTRAINT f_contractrevleakdetail_pkey PRIMARY KEY (cont_rev_key);

ALTER TABLE ONLY dwh.f_contractrevleakdetail
    ADD CONSTRAINT f_contractrevleakdetail_ukey UNIQUE (cont_rev_lkge_ou, cont_rev_lkge_line_no);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_pkey PRIMARY KEY (cont_dtl_key);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_ukey UNIQUE (cont_transfer_inv_no, cont_transfer_lineno, cont_transfer_inv_ou);

ALTER TABLE ONLY dwh.f_contracttransferinvoiceheader
    ADD CONSTRAINT f_contracttransferinvoiceheader_pkey PRIMARY KEY (cont_hdr_key);

ALTER TABLE ONLY dwh.f_contracttransferinvoiceheader
    ADD CONSTRAINT f_contracttransferinvoiceheader_ukey UNIQUE (cont_transfer_inv_no, cont_transfer_inv_ou);

ALTER TABLE ONLY dwh.f_deliverydelayreason
    ADD CONSTRAINT f_deliverydelayreason_pkey PRIMARY KEY (f_deliverydelayreason_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_pkey PRIMARY KEY (disp_con_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_ukey UNIQUE (disp_location, disp_ou, disp_lineno);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_pkey PRIMARY KEY (dispatch_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_ukey UNIQUE (dispatch_loc_code, dispatch_ld_sheet_no, dispatch_ld_sheet_ou, dispatch_lineno);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_pkey PRIMARY KEY (ddh_key);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_pkey PRIMARY KEY (dds_key);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_ukey UNIQUE (dds_ouinstance, dds_trip_id, dds_seqno, dds_dispatch_doc_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_pkey PRIMARY KEY (ddtcd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_ukey UNIQUE (ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_pkey PRIMARY KEY (ddtd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ukey UNIQUE (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_pkey PRIMARY KEY (ddtsd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_ukey UNIQUE (ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_pkey PRIMARY KEY (ddtskud_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_ukey UNIQUE (ddtsd_ou, ddtsd_dispatch_doc_no, ddtsd_thu_line_no);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_pkey PRIMARY KEY (dispatch_hdr_key);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_ukey UNIQUE (dispatch_loc_code, dispatch_ld_sheet_no, dispatch_ld_sheet_ou);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchloaddetail_pkey PRIMARY KEY (disp_load_dtl_key);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchloaddetail_ukey UNIQUE (disp_location, disp_ou, disp_lineno);

ALTER TABLE ONLY dwh.f_divisionareadetail
    ADD CONSTRAINT f_divisionareadetail_pkey PRIMARY KEY (div_dtl_key);

ALTER TABLE ONLY dwh.f_divisionareadetail
    ADD CONSTRAINT f_divisionareadetail_ukey UNIQUE (div_code, div_ou);

ALTER TABLE ONLY dwh.f_draftbilldetail
    ADD CONSTRAINT f_draftbilldetail_pkey PRIMARY KEY (draft_bill_dtl_key);

ALTER TABLE ONLY dwh.f_draftbilldetail
    ADD CONSTRAINT f_draftbilldetail_ukey UNIQUE (draft_bill_no, draft_bill_ou, draft_bill_lineno);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_pkey PRIMARY KEY (draft_bill_exec_dtl_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_ukey UNIQUE (exec_loc_code, exec_ou, exec_no, exec_stage, exec_line_no);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_pkey PRIMARY KEY (draft_bill_hdr_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_ukey UNIQUE (draft_bill_no, draft_bill_ou);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_pkey PRIMARY KEY (draft_bill_key);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_ukey UNIQUE (draft_bill_ou, draft_bill_location, draft_bill_division, draft_bill_tran_type, draft_bill_ref_doc_no, draft_bill_ref_doc_type, draft_bill_vendor_id, draft_bill_resource_type);

ALTER TABLE ONLY dwh.f_draftbilltariffdetail
    ADD CONSTRAINT f_draftbilltariffdetail_pkey PRIMARY KEY (draft_bill_key);

ALTER TABLE ONLY dwh.f_draftbilltariffdetail
    ADD CONSTRAINT f_draftbilltariffdetail_ukey UNIQUE (draft_bill_ou, draft_bill_line_no, draft_bill_tran_type);

ALTER TABLE ONLY dwh.f_eamamchdr
    ADD CONSTRAINT f_eamamchdr_pkey PRIMARY KEY (amc_hdr_key);

ALTER TABLE ONLY dwh.f_eamamchdr
    ADD CONSTRAINT f_eamamchdr_ukey UNIQUE (amc_amcno, amc_amcou, amc_date, amc_fromdate, amc_todate, amc_revno, amc_suppcode, amc_createdate);

ALTER TABLE ONLY dwh.f_execthudetail
    ADD CONSTRAINT f_execthudetail_pkey PRIMARY KEY (pletd_exe_thu_dtl_key);

ALTER TABLE ONLY dwh.f_execthuserialdetail
    ADD CONSTRAINT f_execthuserialdetail_pkey PRIMARY KEY (pletsd_exc_srl_thu_dtl_key);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_pkey PRIMARY KEY (fbp_act_blc_key);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_ukey UNIQUE (ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code);

ALTER TABLE ONLY dwh.f_fbppostedtrndtl
    ADD CONSTRAINT f_fbppostedtrndtl_pkey PRIMARY KEY (fbp_trn_dtl_key);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_pkey PRIMARY KEY (fbp_dtl_key);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_ukey UNIQUE (parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no);

ALTER TABLE ONLY dwh.f_fbpvoucherhdr
    ADD CONSTRAINT f_fbpvoucherhdr_pkey PRIMARY KEY (fbp_hdr_key);

ALTER TABLE ONLY dwh.f_fbpvoucherhdr
    ADD CONSTRAINT f_fbpvoucherhdr_ukey UNIQUE (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_pkey PRIMARY KEY (gate_exec_dtl_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_ukey UNIQUE (gate_loc_code, gate_exec_no, gate_exec_ou);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_pkey PRIMARY KEY (gate_pln_dtl_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_ukey UNIQUE (gate_loc_code, gate_pln_no, gate_pln_ou);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_pkey PRIMARY KEY (gr_good_emp_key);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_ukey UNIQUE (gr_loc_cod, gr_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_pkey PRIMARY KEY (gi_gid_key);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_ukey UNIQUE (gi_no, gi_ou, gi_loc_code, gi_outbound_ord_no, gi_line_no);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_pkey PRIMARY KEY (gr_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_pkey PRIMARY KEY (gr_itm_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_pkey PRIMARY KEY (gr_hdr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_ukey UNIQUE (ouinstid, grno);

ALTER TABLE ONLY dwh.f_gritemtrackingdetail
    ADD CONSTRAINT f_gritemtrackingdetail_pkey PRIMARY KEY (gr_itm_tk_dtl_key);

ALTER TABLE ONLY dwh.f_gritemtrackingdetail
    ADD CONSTRAINT f_gritemtrackingdetail_ukey UNIQUE (stk_ou, stk_location, stk_customer, stk_date, stk_uid_serial_no, stk_lot_no, stk_pack_thu_serial_no);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_pkey PRIMARY KEY (gr_pln_key);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_pkey PRIMARY KEY (gr_gsi_key);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_lineno, gr_serial_no);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_pkey PRIMARY KEY (gr_thu_dtl_key);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_pkey PRIMARY KEY (gr_thu_hdr_key);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_thu_sno, gr_thu_su, gr_thu_uid_ser_no);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_pkey PRIMARY KEY (gr_lot_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_ukey UNIQUE (gr_loc_code, gr_exec_no, gr_exec_ou, gr_thu_id, gr_lot_thu_sno, gr_line_no, gr_thu_uid_sr_no, gr_thu_lot_su);

ALTER TABLE ONLY dwh.f_inboundamendheader
    ADD CONSTRAINT f_inboundamendheader_pkey PRIMARY KEY (inb_amh_key);

ALTER TABLE ONLY dwh.f_inboundamendheader
    ADD CONSTRAINT f_inboundamendheader_ukey UNIQUE (inb_loc_code, inb_orderno, inb_ou, inb_amendno);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_pkey PRIMARY KEY (inb_dtl_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_pkey PRIMARY KEY (inb_hdr_key);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_ukey UNIQUE (inb_loc_code, inb_orderno, inb_ou);

ALTER TABLE ONLY dwh.f_inbounditemamenddetail
    ADD CONSTRAINT f_inbounditemamenddetail_pkey PRIMARY KEY (inb_itm_dtl_key);

ALTER TABLE ONLY dwh.f_inbounditemamenddetail
    ADD CONSTRAINT f_inbounditemamenddetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou, inb_amendno);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_pkey PRIMARY KEY (in_ord_bin_dtl_key);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_ukey UNIQUE (in_ord_location, in_ord_no, in_ord_lineno, in_ord_ou);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_pkey PRIMARY KEY (pln_tracking_key);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_ukey UNIQUE (pln_lineno, pln_ou);

ALTER TABLE ONLY dwh.f_inboundscheduleitemamenddetail
    ADD CONSTRAINT f_inboundscheduleitemamenddetail_pkey PRIMARY KEY (inb_sl_itm_dtl_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemamenddetail
    ADD CONSTRAINT f_inboundscheduleitemamenddetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou, inb_amendno);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_pkey PRIMARY KEY (inb_sl_itm_dtl_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_ukey UNIQUE (inb_loc_code, inb_orderno, inb_lineno, inb_ou);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_pkey PRIMARY KEY (in_ord_hdr_key);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_ukey UNIQUE (in_ord_location, in_ord_no, in_ord_ou);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_pkey PRIMARY KEY (allc_dtl_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_ukey UNIQUE (allc_doc_no, allc_doc_line_no, allc_alloc_line_no, allc_doc_ou);

ALTER TABLE ONLY dwh.f_jvvouchertrndtl
    ADD CONSTRAINT f_jvvouchertrndtl_pkey PRIMARY KEY (jv_vcr_trn_dtl_key);

ALTER TABLE ONLY dwh.f_jvvouchertrndtl
    ADD CONSTRAINT f_jvvouchertrndtl_ukey UNIQUE (ou_id, voucher_no, voucher_serial_no);

ALTER TABLE ONLY dwh.f_jvvouchertrnhdr
    ADD CONSTRAINT f_jvvouchertrnhdr_pkey PRIMARY KEY (jv_vcr_trn_hdr_key);

ALTER TABLE ONLY dwh.f_jvvouchertrnhdr
    ADD CONSTRAINT f_jvvouchertrnhdr_ukey UNIQUE (ou_id, voucher_no);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_pkey PRIMARY KEY (loading_dtl_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_ukey UNIQUE (loading_loc_code, loading_exec_no, loading_exec_ou, loading_lineno);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_pkey PRIMARY KEY (loading_hdr_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_ukey UNIQUE (loading_loc_code, loading_exec_no, loading_exec_ou);

ALTER TABLE ONLY dwh.f_locationareadetail
    ADD CONSTRAINT f_locationareadetail_pkey PRIMARY KEY (loc_pop_dtl_key);

ALTER TABLE ONLY dwh.f_locationareadetail
    ADD CONSTRAINT f_locationareadetail_ukey UNIQUE (loc_pop_code, loc_pop_ou);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_pkey PRIMARY KEY (lot_mst_dtl_key);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_ukey UNIQUE (lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_pkey PRIMARY KEY (stk_lottrk_dtl_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_ukey UNIQUE (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_lot_no);

ALTER TABLE ONLY dwh.f_notesattachment
    ADD CONSTRAINT f_notesattachment_pkey PRIMARY KEY (note_atch_key);

ALTER TABLE ONLY dwh.f_notesattachment
    ADD CONSTRAINT f_notesattachment_ukey UNIQUE (sequence_no, notes_compkey, line_no, line_entity);

ALTER TABLE ONLY dwh.f_notesheader
    ADD CONSTRAINT f_notesheader_pkey PRIMARY KEY (notes_hdr_key);

ALTER TABLE ONLY dwh.f_notesheader
    ADD CONSTRAINT f_notesheader_ukey UNIQUE (notes_compkey);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_pkey PRIMARY KEY (obd_dl_key);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_ukey UNIQUE (oub_doc_loc_code, oub_outbound_ord, oub_doc_lineno, oub_doc_ou);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_pkey PRIMARY KEY (obh_hr_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_ukey UNIQUE (oub_ou, oub_loc_code, oub_outbound_ord);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_pkey PRIMARY KEY (obh_hr_his_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_ukey UNIQUE (oub_ou, oub_loc_code, oub_outbound_ord, oub_amendno);

ALTER TABLE ONLY dwh.f_outbounditemdetail
    ADD CONSTRAINT f_outbounditemdetail_pkey PRIMARY KEY (obd_idl_key);

ALTER TABLE ONLY dwh.f_outbounditemdetail
    ADD CONSTRAINT f_outbounditemdetail_ukey UNIQUE (oub_itm_ou, oub_itm_loc_code, oub_outbound_ord, oub_itm_lineno);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_pkey PRIMARY KEY (obd_idl_his_key);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_ukey UNIQUE (oub_itm_loc_code, oub_itm_ou, oub_outbound_ord, oub_itm_amendno, oub_itm_lineno);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_pkey PRIMARY KEY (oub_lotsl_loc_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_ukey UNIQUE (oub_lotsl_loc_code, oub_outbound_ord, oub_lotsl_lineno, oub_lotsl_ou);

ALTER TABLE ONLY dwh.f_outboundlotsrldetailhistory
    ADD CONSTRAINT f_outboundlotsrldetailhistory_pkey PRIMARY KEY (oub_lotsl_loc_his_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetailhistory
    ADD CONSTRAINT f_outboundlotsrldetailhistory_ukey UNIQUE (oub_lotsl_loc_code, oub_lotsl_ou, oub_outbound_ord, oub_lotsl_lineno, oub_lotsl_amendno);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_pkey PRIMARY KEY (obd_sdl_key);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_ukey UNIQUE (oub_sch_loc_code, oub_outbound_ord, oub_sch_lineno, oub_item_lineno, oub_sch_ou);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_pkey PRIMARY KEY (obd_sdl_his_key);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_ukey UNIQUE (oub_sch_loc_code, oub_sch_ou, oub_outbound_ord, oub_sch_amendno, oub_sch_lineno, oub_item_lineno);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_pkey PRIMARY KEY (oub_vhr_key);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_ukey UNIQUE (oub_loc_code, oub_ou, oub_outbound_ord, oub_lineno);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_pkey PRIMARY KEY (pack_exe_hdr_key);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_ukey UNIQUE (pack_loc_code, pack_exec_no, pack_exec_ou);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pkey PRIMARY KEY (pack_exec_thu_dtl_key);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pkey PRIMARY KEY (pack_exec_thu_dtl_hst_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pkey PRIMARY KEY (pack_exec_thu_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_ukey UNIQUE (pack_exec_ou, pack_exec_loc_code, pack_exec_no, pack_exec_thu_id, pack_exec_thu_sr_no);

ALTER TABLE ONLY dwh.f_packheader
    ADD CONSTRAINT f_packheader_pkey PRIMARY KEY (pack_hdr_key);

ALTER TABLE ONLY dwh.f_packheader
    ADD CONSTRAINT f_packheader_ukey UNIQUE (pack_location, pack_ou);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pkey PRIMARY KEY (pack_itm_sl_dtl_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pkey PRIMARY KEY (pack_pln_dtl_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_ukey UNIQUE (pack_loc_code, pack_pln_no, pack_pln_ou, pack_lineno);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pkey PRIMARY KEY (pack_pln_hdr_key);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_ukey UNIQUE (pack_loc_code, pack_pln_no, pack_pln_ou);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_pkey PRIMARY KEY (pack_storage_dtl_key);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_ukey UNIQUE (pack_location, pack_ou, pack_lineno);

ALTER TABLE ONLY dwh.f_pcsgateinfodetail
    ADD CONSTRAINT f_pcsgateinfodetail_pkey PRIMARY KEY (pcs_gtin_dtl_key);

ALTER TABLE ONLY dwh.f_pcsputawayplanlist
    ADD CONSTRAINT f_pcsputawayplanlist_pkey PRIMARY KEY (pcs_pway_pln_lst_key);

ALTER TABLE ONLY dwh.f_pcsputawayplanlist
    ADD CONSTRAINT f_pcsputawayplanlist_ukey UNIQUE (plan_no, putaway_emp_code, putaway_loc_code, putaway_euip_code);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pkey PRIMARY KEY (pick_emp_eqp_dtl_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_ukey UNIQUE (pick_loc_code, pick_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pkey PRIMARY KEY (pick_dtl_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_ukey UNIQUE (pick_loc_code, pick_exec_no, pick_exec_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickingheader
    ADD CONSTRAINT f_pickingheader_pkey PRIMARY KEY (pick_hdr_key);

ALTER TABLE ONLY dwh.f_pickingheader
    ADD CONSTRAINT f_pickingheader_ukey UNIQUE (pick_loc_code, pick_exec_no, pick_exec_ou);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pkey PRIMARY KEY (pick_pln_dtl_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_ukey UNIQUE (pick_loc_code, pick_pln_no, pick_pln_ou, pick_lineno);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_pkey PRIMARY KEY (pick_pln_hdr_key);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_ukey UNIQUE (pick_loc_code, pick_pln_no, pick_pln_ou);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_pkey PRIMARY KEY (pick_rule_key);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_ukey UNIQUE (pick_loc_code, pick_ou);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_pkey PRIMARY KEY (plph_dtl_key);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_ukey UNIQUE (plpd_ouinstance, plpd_plan_run_no, plpd_plan_unique_id);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_pkey PRIMARY KEY (plph_hdr_key);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_ukey UNIQUE (plph_ouinstance, plph_plan_run_no);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_pkey PRIMARY KEY (gr_itm_dtl_key);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_ukey UNIQUE (gr_loc_code, gr_pln_no, gr_pln_ou, gr_lineno);

ALTER TABLE ONLY dwh.f_poprcoverage
    ADD CONSTRAINT f_poprcoverage_pkey PRIMARY KEY (poprq_covg_dtl_key);

ALTER TABLE ONLY dwh.f_poprcoverage
    ADD CONSTRAINT f_poprcoverage_ukey UNIQUE (poprq_poou, poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_prno, poprq_posubscheduleno, poprq_prlineno, poprq_prou, poprq_pr_shdno, poprq_pr_subsceduleno);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_pkey PRIMARY KEY (po_dtl_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_ukey UNIQUE (poou, pono, poamendmentno, polineno);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_pkey PRIMARY KEY (po_hr_key);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_ukey UNIQUE (poou, pono, poamendmentno);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_pkey PRIMARY KEY (rcgh_receipt_key);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_ukey UNIQUE (rcgh_ouinstid, rcgh_receipt_no);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_pkey PRIMARY KEY (preqm_dtl_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_ukey UNIQUE (prqit_prou, prqit_prno, prqit_lineno);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_pkey PRIMARY KEY (preqm_hr_key);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_ukey UNIQUE (preqm_prou, preqm_prno);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pkey PRIMARY KEY (pway_bin_cap_key);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pkey PRIMARY KEY (pway_eqp_map_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_ukey UNIQUE (putaway_loc_code, putaway_ou, putaway_lineno);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pkey PRIMARY KEY (pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pkey PRIMARY KEY (pway_exec_serial_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pkey PRIMARY KEY (pway_itm_dtl_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_ukey UNIQUE (pway_loc_code, pway_exec_no, pway_exec_ou, pway_exec_lineno);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pkey PRIMARY KEY (pway_pln_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pkey PRIMARY KEY (pway_pln_itm_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_putawayserialdetail
    ADD CONSTRAINT f_putawayserialdetail_pkey PRIMARY KEY (pway_serial_dtl_key);

ALTER TABLE ONLY dwh.f_putawayserialdetail
    ADD CONSTRAINT f_putawayserialdetail_ukey UNIQUE (pway_loc_code, pway_pln_no, pway_pln_ou, pway_lineno);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_pkey PRIMARY KEY (rppostingsdtl_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_ukey UNIQUE (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_pkey PRIMARY KEY (rptacctinfodtl_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_ukey UNIQUE (ou_id, tran_no, fb_id, account_code, tran_type, drcr_flag, posting_line_no);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_pkey PRIMARY KEY (sadadjvcrdocdtl_key);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_no, term_no, cr_doc_type);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_pkey PRIMARY KEY (sadadjvdrdocdtl_key);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_ukey UNIQUE (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_pkey PRIMARY KEY (sadadjvoucherhdr_key);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_ukey UNIQUE (ou_id, adj_voucher_no, stimestamp);

ALTER TABLE ONLY dwh.f_scdnaccdtl
    ADD CONSTRAINT f_scdnaccdtl_pkey PRIMARY KEY (scdnaccdtl_key);

ALTER TABLE ONLY dwh.f_scdnaccdtl
    ADD CONSTRAINT f_scdnaccdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, stimestamp);

ALTER TABLE ONLY dwh.f_scdnappostingsdtl
    ADD CONSTRAINT f_scdnappostingsdtl_pkey PRIMARY KEY (f_scdnappostingsdtl_key);

ALTER TABLE ONLY dwh.f_scdnappostingsdtl
    ADD CONSTRAINT f_scdnappostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);

ALTER TABLE ONLY dwh.f_scdndcnotehdr
    ADD CONSTRAINT f_scdndcnotehdr_pkey PRIMARY KEY (f_scdndcnotehdr_key);

ALTER TABLE ONLY dwh.f_scdndcnotehdr
    ADD CONSTRAINT f_scdndcnotehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, ict_flag, ifb_flag);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_pkey PRIMARY KEY (f_sdinappostingsdtl_key);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, s_timestamp);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_pkey PRIMARY KEY (f_sdinexpensedtl_key);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, s_timestamp);

ALTER TABLE ONLY dwh.f_sdininvoicehdr
    ADD CONSTRAINT f_sdininvoicehdr_pkey PRIMARY KEY (sd_inv_key);

ALTER TABLE ONLY dwh.f_sdininvoicehdr
    ADD CONSTRAINT f_sdininvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, s_timestamp, payment_type, ict_flag, ales_flag, lgt_invoice, mail_sent, allow_auto_cap);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_pkey PRIMARY KEY (sidochdr_key);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_ukey UNIQUE (tran_ou, tran_type, tran_no);

ALTER TABLE ONLY dwh.f_silinedtl
    ADD CONSTRAINT f_silinedtl_pkey PRIMARY KEY (si_line_dtl_key);

ALTER TABLE ONLY dwh.f_silinedtl
    ADD CONSTRAINT f_silinedtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, row_type, ref_doc_no);

ALTER TABLE ONLY dwh.f_sinappostingsdtl
    ADD CONSTRAINT f_sinappostingsdtl_pkey PRIMARY KEY (si_sindtl_key);

ALTER TABLE ONLY dwh.f_sinappostingsdtl
    ADD CONSTRAINT f_sinappostingsdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, posting_line_no, a_timestamp);

ALTER TABLE ONLY dwh.f_sininvoicehdr
    ADD CONSTRAINT f_sininvoicehdr_pkey PRIMARY KEY (si_inv_key);

ALTER TABLE ONLY dwh.f_sininvoicehdr
    ADD CONSTRAINT f_sininvoicehdr_ukey UNIQUE (tran_type, tran_ou, tran_no, "timestamp", tms_flag, gen_from_mntfrght);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_pkey PRIMARY KEY (si_sinitm_key);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_ukey UNIQUE (tran_type, tran_ou, tran_no, line_no, ipv_flag, epv_flag);

ALTER TABLE ONLY dwh.f_snpfbpostingdtl
    ADD CONSTRAINT f_snpfbpostingdtl_pkey PRIMARY KEY (snfb_pos_key);

ALTER TABLE ONLY dwh.f_snpfbpostingdtl
    ADD CONSTRAINT f_snpfbpostingdtl_ukey UNIQUE (batch_id, ou_id, document_no, account_lineno, account_code, "timestamp");

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_pkey PRIMARY KEY (voucher_dtl_key);

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_ukey UNIQUE (ou_id, voucher_no, voucher_type, account_lineno, tran_type, vtimestamp);

ALTER TABLE ONLY dwh.f_snpvoucherhdr
    ADD CONSTRAINT f_snpvoucherhdr_pkey PRIMARY KEY (voucher_hdr_key);

ALTER TABLE ONLY dwh.f_snpvoucherhdr
    ADD CONSTRAINT f_snpvoucherhdr_ukey UNIQUE (ou_id, voucher_no, voucher_type, tran_type, vtimestamp, ifb_flag);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_pkey PRIMARY KEY (paybatch_dtl_key);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_ukey UNIQUE (ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type, ptimestamp);

ALTER TABLE ONLY dwh.f_spypaybatchhdr
    ADD CONSTRAINT f_spypaybatchhdr_pkey PRIMARY KEY (paybatch_hdr_key);

ALTER TABLE ONLY dwh.f_spypaybatchhdr
    ADD CONSTRAINT f_spypaybatchhdr_ukey UNIQUE (ou_id, paybatch_no, ptimestamp, ict_flag);

ALTER TABLE ONLY dwh.f_spyprepayvchhdr
    ADD CONSTRAINT f_spyprepayvchhdr_pkey PRIMARY KEY (prepay_vch_hdr_key);

ALTER TABLE ONLY dwh.f_spyprepayvchhdr
    ADD CONSTRAINT f_spyprepayvchhdr_ukey UNIQUE (ou_id, voucher_no, tran_type, ptimestamp, lgt_invoice_flag);

ALTER TABLE ONLY dwh.f_spyvoucherhdr
    ADD CONSTRAINT f_spyvoucherhdr_pkey PRIMARY KEY (spy_vcr_hdr_key);

ALTER TABLE ONLY dwh.f_spyvoucherhdr
    ADD CONSTRAINT f_spyvoucherhdr_ukey UNIQUE (ou_id, paybatch_no, voucher_no, "timestamp", line_no, ict_flag);

ALTER TABLE ONLY dwh.f_stock_lottrackingdaywise_detail
    ADD CONSTRAINT f_stock_lottrackingdaywise_detail_pkey PRIMARY KEY (stk_lottrack_dtl_key);

ALTER TABLE ONLY dwh.f_stock_lottrackingdaywise_detail
    ADD CONSTRAINT f_stock_lottrackingdaywise_detail_ukey UNIQUE (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_lot_no, stk_stock_status);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_pkey PRIMARY KEY (sbs_level_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_ukey UNIQUE (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_pkey PRIMARY KEY (sbl_lot_level_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_ukey UNIQUE (sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_stock_status, sbl_su_serial_no, sbl_thu_serial_no, sbl_su_serial_no2);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitseriallevel
    ADD CONSTRAINT f_stockbalancestorageunitseriallevel_pkey PRIMARY KEY (sbs_blc_usl_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitseriallevel
    ADD CONSTRAINT f_stockbalancestorageunitseriallevel_ukey UNIQUE (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_su_serial_no, sbs_thu_serial_no);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_pkey PRIMARY KEY (stock_bin_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_ukey UNIQUE (stock_ou, stock_date, stock_location, stock_zone, stock_bin, stock_item, stock_thu_id, stock_su);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_pkey PRIMARY KEY (stk_con_dtl_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_ukey UNIQUE (stk_con_loc_code, stk_con_proposal_no, stk_con_proposal_ou, stk_con_lineno);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_pkey PRIMARY KEY (stk_con_hdr_key);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_ukey UNIQUE (stk_con_loc_code, stk_con_proposal_no, stk_con_proposal_ou);

ALTER TABLE ONLY dwh.f_stockrejecteddetail
    ADD CONSTRAINT f_stockrejecteddetail_pkey PRIMARY KEY (rejstk_dtl_key);

ALTER TABLE ONLY dwh.f_stockrejecteddetail
    ADD CONSTRAINT f_stockrejecteddetail_ukey UNIQUE (rejstk_line_no);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_pkey PRIMARY KEY (stk_su_dtl_key);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_ukey UNIQUE (stk_ou, stk_location, stk_customer, stk_date, stk_su);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_pkey PRIMARY KEY (stk_itm_dtl_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_ukey UNIQUE (stk_ou, stk_location, stk_item, stk_customer, stk_date, stk_uid_serial_no, stk_lot_no);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_pkey PRIMARY KEY (stk_trc_dtl_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_ukey UNIQUE (stk_location, stk_zone, stk_bin, stk_bin_type, stk_staging_id, stk_stage, stk_customer, stk_uid_serial_no, stk_thu_id, stk_su, stk_from_date);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_pkey PRIMARY KEY (surf_dtl_key);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_ukey UNIQUE (ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno, "timestamp");

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_pkey PRIMARY KEY (surreceiptdtl_key);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_ukey UNIQUE (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type, stimestamp);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_pkey PRIMARY KEY (surreceipthdr_key);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_ukey UNIQUE (ou_id, receipt_no, receipt_type, tran_type, stimestamp, ifb_flag);

ALTER TABLE ONLY dwh.f_tariffrevcostdetail
    ADD CONSTRAINT f_tariffrevcostdetail_pkey PRIMARY KEY (tarcd_dtl_key);

ALTER TABLE ONLY dwh.f_tariffrevcostdetail
    ADD CONSTRAINT f_tariffrevcostdetail_ukey UNIQUE (tarcd_ouinstance, tarcd_trip_plan_id, tarcd_booking_request, tarcd_unique_id, tarcd_stage_of_derivation, tarcd_buy_sell_type);

ALTER TABLE ONLY dwh.f_tariffrevcostheader
    ADD CONSTRAINT f_tariffrevcostheader_pkey PRIMARY KEY (tarch_hdr_key);

ALTER TABLE ONLY dwh.f_tariffrevcostheader
    ADD CONSTRAINT f_tariffrevcostheader_ukey UNIQUE (tarch_ouinstance, tarch_trip_plan_id, tarch_unique_id, tarch_buy_sell_type, tarch_stage_of_derivation);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_pkey PRIMARY KEY (tbpvoucherhdr_key);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_ukey UNIQUE (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_pkey PRIMARY KEY (f_tcaltranhdr_key);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_ukey UNIQUE (tran_no, tax_type, tran_type, tran_ou);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_pkey PRIMARY KEY (trd_dtl_key);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_ukey UNIQUE (trd_ouinstance, trd_tender_req_no, trd_tender_req_line_no, trd_ref_doc_no);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_pkey PRIMARY KEY (trh_hdr_key);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_ukey UNIQUE (trh_ouinstance, trh_tender_req_no);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_pkey PRIMARY KEY (plepd_trip_exe_pln_dtl_key);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_ukey UNIQUE (plepd_ouinstance, plepd_execution_plan_id, plepd_line_no);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_pkey PRIMARY KEY (tlad_log_agent_dtl_key);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_ukey UNIQUE (tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_pkey PRIMARY KEY (tled_trip_log_dtl_key);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_ukey UNIQUE (tled_ouinstance, tled_trip_plan_id, tled_trip_plan_unique_id);

ALTER TABLE ONLY dwh.f_triplogexpensedetail
    ADD CONSTRAINT f_triplogexpensedetail_pkey PRIMARY KEY (tled_key);

ALTER TABLE ONLY dwh.f_triplogexpensedocdetail
    ADD CONSTRAINT f_triplogexpensedocdetail_pkey PRIMARY KEY (tledd_key);

ALTER TABLE ONLY dwh.f_triplogexpensedocdetail
    ADD CONSTRAINT f_triplogexpensedocdetail_ukey UNIQUE (tledd_ouinstance, tledd_doc_guid);

ALTER TABLE ONLY dwh.f_triplogexpenseheader
    ADD CONSTRAINT f_triplogexpenseheader_pkey PRIMARY KEY (tleh_key);

ALTER TABLE ONLY dwh.f_triplogexpenseheader
    ADD CONSTRAINT f_triplogexpenseheader_ukey UNIQUE (tleh_ouinstance, tleh_report_no, tleh_trip_id, tleh_report_creation_date);

ALTER TABLE ONLY dwh.f_triplogresourceintransitdetail
    ADD CONSTRAINT f_triplogresourceintransitdetail_pkey PRIMARY KEY (in_tran_dtl_key);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_pkey PRIMARY KEY (tltd_tpthd_key);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_pkey PRIMARY KEY (plpto_trp_odo_dtl_key);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_ukey UNIQUE (plpto_ouinstance, plpto_guid);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_pkey PRIMARY KEY (plptd_dtl_key);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_ukey UNIQUE (plptd_ouinstance, plptd_plan_run_no, plptd_trip_plan_id, plptd_trip_plan_seq, plptd_bk_req_id, plptd_trip_plan_unique_id);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_pkey PRIMARY KEY (plpth_hdr_key);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_ukey UNIQUE (plpth_ouinstance, plpth_trip_plan_id);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_pkey PRIMARY KEY (tpad_dtl_key);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_ukey UNIQUE (tpad_line_no);

ALTER TABLE ONLY dwh.f_tripresourcescheduledetail
    ADD CONSTRAINT f_tripresourcescheduledetail_pkey PRIMARY KEY (trsd_trip_sdl_dtl_key);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_pkey PRIMARY KEY (plttd_trip_thu_key);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_ukey UNIQUE (plttd_ouinstance, plttd_trip_plan_id, plttd_trip_plan_line_no, plttd_thu_line_no, plttd_dispatch_doc_no);

ALTER TABLE ONLY dwh.f_tripthuserialdetail
    ADD CONSTRAINT f_tripthuserialdetail_pkey PRIMARY KEY (plttsd_srl_dtl_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_pkey PRIMARY KEY (tvtrcd_dtl_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_ukey UNIQUE (tvtrcd_ouinstance, tvtrcd_trip_plan_id, tvtrcd_booking_request, tvtrcd_unique_id);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_pkey PRIMARY KEY (tvtrch_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_ukey UNIQUE (tvtrch_ouinstance, tvtrch_trip_plan_id, tvtrch_unique_id, tvtrch_stage_of_derivation);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_pkey PRIMARY KEY (vrvel_vhl_eqp_dtl_key);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_ukey UNIQUE (vrvel_ouinstance, vrvel_tend_req_no, vrvel_line_no, vrvel_resp_line_no);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_pkey PRIMARY KEY (vrve_vhl_dtl_key);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_ukey UNIQUE (vrve_ouinstance, vrve_tend_req_no, vrve_line_no);

ALTER TABLE ONLY dwh.f_vehiclerequirements
    ADD CONSTRAINT f_vehiclerequirements_pkey PRIMARY KEY (trvr_vhl_req_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_pkey PRIMARY KEY (wave_dtl_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_ukey UNIQUE (wave_lineno, wave_no, wave_ou, wave_loc_code);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_pkey PRIMARY KEY (wave_hdr_key);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_ukey UNIQUE (wave_loc_code, wave_no, wave_ou);

ALTER TABLE ONLY ods.audit
    ADD CONSTRAINT audit_pkey PRIMARY KEY (id);

ALTER TABLE ONLY ods.controldetail
    ADD CONSTRAINT controldetail_pkey PRIMARY KEY (id);

ALTER TABLE ONLY ods.controlheader
    ADD CONSTRAINT controlheader_pkey PRIMARY KEY (id);

ALTER TABLE ONLY ods.datavalidation_scriptgenerator
    ADD CONSTRAINT datavalidation_scriptgenerator_pkey PRIMARY KEY (row_id);

ALTER TABLE ONLY ods.error
    ADD CONSTRAINT error_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);

ALTER TABLE ONLY raw.raw_emod_ou_bu_map
    ADD CONSTRAINT emod_ou_bu_map_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_ou_mst
    ADD CONSTRAINT emod_ou_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_erate_exrate_mst
    ADD CONSTRAINT erate_exrate_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_abb_account_budget_dtl
    ADD CONSTRAINT raw_abb_account_budget_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_acap_asset_hdr
    ADD CONSTRAINT raw_acap_asset_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_adep_depr_rate_hdr
    ADD CONSTRAINT raw_adep_depr_rate_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_adepp_process_hdr
    ADD CONSTRAINT raw_adepp_process_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ainq_cwip_accounting_info
    ADD CONSTRAINT raw_ainq_cwip_accounting_info_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_aplan_acq_proposal_hdr
    ADD CONSTRAINT raw_aplan_acq_proposal_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_aplan_proposal_bal_dtl
    ADD CONSTRAINT raw_aplan_proposal_bal_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ard_addn_account_mst
    ADD CONSTRAINT raw_ard_addn_account_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ard_asset_account_mst
    ADD CONSTRAINT raw_ard_asset_account_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ard_bnkcsh_account_mst
    ADD CONSTRAINT raw_ard_bnkcsh_account_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_as_opaccount_dtl
    ADD CONSTRAINT raw_as_opaccount_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_as_taxyear_hdr
    ADD CONSTRAINT raw_as_taxyear_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_at_wms_asn_header
    ADD CONSTRAINT raw_at_wms_asn_header_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_bnkdef_acc_mst
    ADD CONSTRAINT raw_bnkdef_acc_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cbadj_adjv_crdoc_dtl
    ADD CONSTRAINT raw_cbadj_adjv_crdoc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cbadj_adjv_drdoc_dtl
    ADD CONSTRAINT raw_cbadj_adjv_drdoc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cbadj_adjvoucher_hdr
    ADD CONSTRAINT raw_cbadj_adjvoucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdcn_acc_dtl
    ADD CONSTRAINT raw_cdcn_acc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdcn_ar_postings_dtl
    ADD CONSTRAINT raw_cdcn_ar_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdcn_dcnote_hdr
    ADD CONSTRAINT raw_cdcn_dcnote_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdcn_item_dtl
    ADD CONSTRAINT raw_cdcn_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdi_ar_postings_dtl
    ADD CONSTRAINT raw_cdi_ar_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdi_invoice_hdr
    ADD CONSTRAINT raw_cdi_invoice_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cdi_item_dtl
    ADD CONSTRAINT raw_cdi_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ci_doc_hdr
    ADD CONSTRAINT raw_ci_doc_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_client_master
    ADD CONSTRAINT raw_client_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_client_onboard_mapping
    ADD CONSTRAINT raw_client_onboard_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_client_service_log
    ADD CONSTRAINT raw_client_service_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_client_service_manual
    ADD CONSTRAINT raw_client_service_manual_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_co_module_mst
    ADD CONSTRAINT raw_co_module_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_co_parent_mst
    ADD CONSTRAINT raw_co_parent_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_co_user_mst
    ADD CONSTRAINT raw_co_user_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_co_useracess
    ADD CONSTRAINT raw_co_useracess_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_co_userscreen_mapping
    ADD CONSTRAINT raw_co_userscreen_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_component_metadata_table
    ADD CONSTRAINT raw_component_metadata_table_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_con_child_master
    ADD CONSTRAINT raw_con_child_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_con_module_master
    ADD CONSTRAINT raw_con_module_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_con_parent_master
    ADD CONSTRAINT raw_con_parent_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_con_userscreen_mapping
    ADD CONSTRAINT raw_con_userscreen_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cust_group_hdr
    ADD CONSTRAINT raw_cust_group_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cust_lo_info
    ADD CONSTRAINT raw_cust_lo_info_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cust_ou_info
    ADD CONSTRAINT raw_cust_ou_info_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_cust_prospect_info
    ADD CONSTRAINT raw_cust_prospect_info_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_del_note_tbl
    ADD CONSTRAINT raw_del_note_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_dim_inbound_tat
    ADD CONSTRAINT raw_dim_inbound_tat_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_dim_outbound_tat
    ADD CONSTRAINT raw_dim_outbound_tat_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_eam_amc_hdr
    ADD CONSTRAINT raw_eam_amc_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_addr_mst
    ADD CONSTRAINT raw_emod_addr_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_bank_ref_mst
    ADD CONSTRAINT raw_emod_bank_ref_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_bu_mst
    ADD CONSTRAINT raw_emod_bu_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_company_currency_map
    ADD CONSTRAINT raw_emod_company_currency_map_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_company_mst
    ADD CONSTRAINT raw_emod_company_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_currency_mst
    ADD CONSTRAINT raw_emod_currency_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_finbook_mst
    ADD CONSTRAINT raw_emod_finbook_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_emod_lo_bu_map
    ADD CONSTRAINT raw_emod_lo_bu_map_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_inbound_asn
    ADD CONSTRAINT raw_fact_inbound_asn_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_inbound_grn
    ADD CONSTRAINT raw_fact_inbound_grn_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_inbound_putaway
    ADD CONSTRAINT raw_fact_inbound_putaway_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_br
    ADD CONSTRAINT raw_fact_outbound_br_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_disp
    ADD CONSTRAINT raw_fact_outbound_disp_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_load
    ADD CONSTRAINT raw_fact_outbound_load_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_obd
    ADD CONSTRAINT raw_fact_outbound_obd_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_packexec
    ADD CONSTRAINT raw_fact_outbound_packexec_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_pickexec
    ADD CONSTRAINT raw_fact_outbound_pickexec_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_tripagent
    ADD CONSTRAINT raw_fact_outbound_tripagent_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_tripevent
    ADD CONSTRAINT raw_fact_outbound_tripevent_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_triphdr
    ADD CONSTRAINT raw_fact_outbound_triphdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_outbound_wave
    ADD CONSTRAINT raw_fact_outbound_wave_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_inbound
    ADD CONSTRAINT raw_fact_report_inbound_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_inbound_tat
    ADD CONSTRAINT raw_fact_report_inbound_tat_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_inboundsla
    ADD CONSTRAINT raw_fact_report_inboundsla_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_outbound
    ADD CONSTRAINT raw_fact_report_outbound_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_outbound_tat
    ADD CONSTRAINT raw_fact_report_outbound_tat_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fact_report_outboundsla
    ADD CONSTRAINT raw_fact_report_outboundsla_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fbp_account_balance
    ADD CONSTRAINT raw_fbp_account_balance_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fbp_posted_trn_dtl
    ADD CONSTRAINT raw_fbp_posted_trn_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fbp_voucher_dtl
    ADD CONSTRAINT raw_fbp_voucher_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fbp_voucher_hdr
    ADD CONSTRAINT raw_fbp_voucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_file_upload_master
    ADD CONSTRAINT raw_file_upload_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_fin_quick_code_met
    ADD CONSTRAINT raw_fin_quick_code_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_gr_hdr_grmain
    ADD CONSTRAINT raw_gr_hdr_grmain_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_item_group_type
    ADD CONSTRAINT raw_item_group_type_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_jv_voucher_trn_dtl
    ADD CONSTRAINT raw_jv_voucher_trn_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_jv_voucher_trn_hdr
    ADD CONSTRAINT raw_jv_voucher_trn_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_kdx_lead_header
    ADD CONSTRAINT raw_kdx_lead_header_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag
    ADD CONSTRAINT raw_lbc_offline_wms_stock_uid_tracking_gi_dtl_stag_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_lbc_offline_wms_stock_uid_tracking_load_stag
    ADD CONSTRAINT raw_lbc_offline_wms_stock_uid_tracking_load_stag_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_lgt_clr_doc_gen_logs
    ADD CONSTRAINT raw_lgt_clr_doc_gen_logs_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_mast_ramco_service_types
    ADD CONSTRAINT raw_mast_ramco_service_types_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_mast_sku_class
    ADD CONSTRAINT raw_mast_sku_class_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_mast_type
    ADD CONSTRAINT raw_mast_type_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_menu_mapping
    ADD CONSTRAINT raw_menu_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_menu_master
    ADD CONSTRAINT raw_menu_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_not_notes_attachdoc
    ADD CONSTRAINT raw_not_notes_attachdoc_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_not_notes_dtl
    ADD CONSTRAINT raw_not_notes_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_not_notes_hdr
    ADD CONSTRAINT raw_not_notes_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_not_trantype_met
    ADD CONSTRAINT raw_not_trantype_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_outbound_servicecall_log
    ADD CONSTRAINT raw_outbound_servicecall_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_param_mapping
    ADD CONSTRAINT raw_param_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_param_register
    ADD CONSTRAINT raw_param_register_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcs_integrationtask_log
    ADD CONSTRAINT raw_pcs_integrationtask_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcs_putaway_planlist
    ADD CONSTRAINT raw_pcs_putaway_planlist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcs_track_registereddockets_tbl_onetime
    ADD CONSTRAINT raw_pcs_track_registereddockets_tbl_onetime_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_alert_inbound
    ADD CONSTRAINT raw_pcsit_alert_inbound_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_alert_stock
    ADD CONSTRAINT raw_pcsit_alert_stock_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_bin_unitconversion
    ADD CONSTRAINT raw_pcsit_bin_unitconversion_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_crm_mail_master
    ADD CONSTRAINT raw_pcsit_crm_mail_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_dash_ibd_detail
    ADD CONSTRAINT raw_pcsit_dash_ibd_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_delivery_sap_dtl
    ADD CONSTRAINT raw_pcsit_delivery_sap_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_dispatch_sap_dtl
    ADD CONSTRAINT raw_pcsit_dispatch_sap_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_dwh_metatable
    ADD CONSTRAINT raw_pcsit_dwh_metatable_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_epod_invoices
    ADD CONSTRAINT raw_pcsit_epod_invoices_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_epod_sap_dtl
    ADD CONSTRAINT raw_pcsit_epod_sap_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_eshipz_courier_master
    ADD CONSTRAINT raw_pcsit_eshipz_courier_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_eshipz_invdup
    ADD CONSTRAINT raw_pcsit_eshipz_invdup_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_ext_item_master
    ADD CONSTRAINT raw_pcsit_ext_item_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_gate_invoice
    ADD CONSTRAINT raw_pcsit_gate_invoice_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_gateinfo_dtl
    ADD CONSTRAINT raw_pcsit_gateinfo_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_import_po_isn_dtl
    ADD CONSTRAINT raw_pcsit_import_po_isn_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_inbound_location_shift_dtl
    ADD CONSTRAINT raw_pcsit_inbound_location_shift_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_int_mw_tbl
    ADD CONSTRAINT raw_pcsit_int_mw_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_lbh_weight_validation_tbl
    ADD CONSTRAINT raw_pcsit_lbh_weight_validation_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_loc_holiday_mst
    ADD CONSTRAINT raw_pcsit_loc_holiday_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_loc_sp_mapping_rcs
    ADD CONSTRAINT raw_pcsit_loc_sp_mapping_rcs_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_location_shift_dtl
    ADD CONSTRAINT raw_pcsit_location_shift_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_mast_key_value
    ADD CONSTRAINT raw_pcsit_mast_key_value_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_merchant_pan_mapping
    ADD CONSTRAINT raw_pcsit_merchant_pan_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_mis_warehouse_sla_details_ibd
    ADD CONSTRAINT raw_pcsit_mis_warehouse_sla_details_ibd_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_mis_warehouse_sla_summary_ibd
    ADD CONSTRAINT raw_pcsit_mis_warehouse_sla_summary_ibd_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_mp_log
    ADD CONSTRAINT raw_pcsit_mp_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_multicarrier_res_tbl
    ADD CONSTRAINT raw_pcsit_multicarrier_res_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_multicarrier_tbl
    ADD CONSTRAINT raw_pcsit_multicarrier_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_nethrapro_pod
    ADD CONSTRAINT raw_pcsit_nethrapro_pod_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_obd_sadsap_dtl
    ADD CONSTRAINT raw_pcsit_obd_sadsap_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_outbound_location_shift_dtl
    ADD CONSTRAINT raw_pcsit_outbound_location_shift_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_pod_saved_dtl
    ADD CONSTRAINT raw_pcsit_pod_saved_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_pre_mailalert
    ADD CONSTRAINT raw_pcsit_pre_mailalert_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_prepared_shipment
    ADD CONSTRAINT raw_pcsit_prepared_shipment_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_ramco_stk
    ADD CONSTRAINT raw_pcsit_ramco_stk_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_rdil_invoice_holding_tbl
    ADD CONSTRAINT raw_pcsit_rdil_invoice_holding_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_rdil_uncontrollable_tbl
    ADD CONSTRAINT raw_pcsit_rdil_uncontrollable_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_rt_bin_details
    ADD CONSTRAINT raw_pcsit_rt_bin_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_rt_grn_reasoncode_mst
    ADD CONSTRAINT raw_pcsit_rt_grn_reasoncode_mst_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_serviceprovider_rcs
    ADD CONSTRAINT raw_pcsit_serviceprovider_rcs_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_viritem_unitprice
    ADD CONSTRAINT raw_pcsit_viritem_unitprice_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pcsit_wh_cons_rcs
    ADD CONSTRAINT raw_pcsit_wh_cons_rcs_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_po_poitm_item_detail
    ADD CONSTRAINT raw_po_poitm_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_po_pomas_pur_order_hdr
    ADD CONSTRAINT raw_po_pomas_pur_order_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_po_poprq_poprcovg_detail
    ADD CONSTRAINT raw_po_poprq_poprcovg_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_pps_feature_list
    ADD CONSTRAINT raw_pps_feature_list_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_prq_preqm_pur_reqst_hdr
    ADD CONSTRAINT raw_prq_preqm_pur_reqst_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_prq_prqit_item_detail
    ADD CONSTRAINT raw_prq_prqit_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ramco_location_mapping
    ADD CONSTRAINT raw_ramco_location_mapping_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_ramco_service_master
    ADD CONSTRAINT raw_ramco_service_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rct_purchase_hdr
    ADD CONSTRAINT raw_rct_purchase_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rp_postings_dtl
    ADD CONSTRAINT raw_rp_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rpt_acct_info_dtl
    ADD CONSTRAINT raw_rpt_acct_info_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rpt_receipt_dtl
    ADD CONSTRAINT raw_rpt_receipt_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rpt_receipt_hdr
    ADD CONSTRAINT raw_rpt_receipt_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_rt_courier_code
    ADD CONSTRAINT raw_rt_courier_code_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sa_wm_warehouse_master
    ADD CONSTRAINT raw_sa_wm_warehouse_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sad_adjv_crdoc_dtl
    ADD CONSTRAINT raw_sad_adjv_crdoc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sad_adjv_drdoc_dtl
    ADD CONSTRAINT raw_sad_adjv_drdoc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sad_adjvoucher_hdr
    ADD CONSTRAINT raw_sad_adjvoucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_scdn_acc_dtl
    ADD CONSTRAINT raw_scdn_acc_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_scdn_ap_postings_dtl
    ADD CONSTRAINT raw_scdn_ap_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_scdn_dcnote_hdr
    ADD CONSTRAINT raw_scdn_dcnote_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_scheduler_service_call
    ADD CONSTRAINT raw_scheduler_service_call_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sdin_ap_postings_dtl
    ADD CONSTRAINT raw_sdin_ap_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sdin_expense_dtl
    ADD CONSTRAINT raw_sdin_expense_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sdin_invoice_hdr
    ADD CONSTRAINT raw_sdin_invoice_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_si_doc_hdr
    ADD CONSTRAINT raw_si_doc_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_si_line_dtl
    ADD CONSTRAINT raw_si_line_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sin_ap_postings_dtl
    ADD CONSTRAINT raw_sin_ap_postings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sin_invoice_hdr
    ADD CONSTRAINT raw_sin_invoice_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sin_item_dtl
    ADD CONSTRAINT raw_sin_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sng_automail_pcklist
    ADD CONSTRAINT raw_sng_automail_pcklist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_snp_fbposting_dtl
    ADD CONSTRAINT raw_snp_fbposting_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_snp_voucher_dtl
    ADD CONSTRAINT raw_snp_voucher_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_snp_voucher_hdr
    ADD CONSTRAINT raw_snp_voucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sophos_ack_tbl
    ADD CONSTRAINT raw_sophos_ack_tbl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_spy_paybatch_dtl
    ADD CONSTRAINT raw_spy_paybatch_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_spy_paybatch_hdr
    ADD CONSTRAINT raw_spy_paybatch_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_spy_prepay_vch_hdr
    ADD CONSTRAINT raw_spy_prepay_vch_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_spy_voucher_dtl
    ADD CONSTRAINT raw_spy_voucher_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_spy_voucher_hdr
    ADD CONSTRAINT raw_spy_voucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sur_fbpostings_dtl
    ADD CONSTRAINT raw_sur_fbpostings_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sur_receipt_dtl
    ADD CONSTRAINT raw_sur_receipt_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_sur_receipt_hdr
    ADD CONSTRAINT raw_sur_receipt_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tbp_voucher_hdr
    ADD CONSTRAINT raw_tbp_voucher_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tcal_tran_hdr
    ADD CONSTRAINT raw_tcal_tran_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_br_booking_request_hdr
    ADD CONSTRAINT raw_tms_br_booking_request_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_br_booking_request_reason_hist
    ADD CONSTRAINT raw_tms_br_booking_request_reason_hist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_br_ewaybill_details
    ADD CONSTRAINT raw_tms_br_ewaybill_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brccd_consgt_consignee_details
    ADD CONSTRAINT raw_tms_brccd_consgt_consignee_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brcd_consgt_details
    ADD CONSTRAINT raw_tms_brcd_consgt_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brcsd_consgt_sku_details
    ADD CONSTRAINT raw_tms_brcsd_consgt_sku_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brctd_br_thu_wise_contract_tariff_dtls
    ADD CONSTRAINT raw_tms_brctd_br_thu_wise_contract_tariff_dtls_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brctd_consgt_thu_serial_details
    ADD CONSTRAINT raw_tms_brctd_consgt_thu_serial_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brppd_planning_profile_dtl
    ADD CONSTRAINT raw_tms_brppd_planning_profile_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_brsd_shipment_details
    ADD CONSTRAINT raw_tms_brsd_shipment_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_component_met
    ADD CONSTRAINT raw_tms_component_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_ddh_dispatch_document_hdr
    ADD CONSTRAINT raw_tms_ddh_dispatch_document_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_dds_dispatch_document_signature
    ADD CONSTRAINT raw_tms_dds_dispatch_document_signature_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_ddtcd_dispatch_document_thu_serial_dtl
    ADD CONSTRAINT raw_tms_ddtcd_dispatch_document_thu_serial_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_ddtd_dispatch_document_thu_dtl
    ADD CONSTRAINT raw_tms_ddtd_dispatch_document_thu_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_ddtsd_dispatch_document_thu_sku_dtl
    ADD CONSTRAINT raw_tms_ddtsd_dispatch_document_thu_sku_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_ittnt_triplog_resource_in_transit_details
    ADD CONSTRAINT raw_tms_ittnt_triplog_resource_in_transit_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_plepd_execution_plan_details
    ADD CONSTRAINT raw_tms_plepd_execution_plan_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_pletd_exec_thu_details
    ADD CONSTRAINT raw_tms_pletd_exec_thu_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_pletsd_exec_thu_serial_details
    ADD CONSTRAINT raw_tms_pletsd_exec_thu_serial_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_plpd_planning_details
    ADD CONSTRAINT raw_tms_plpd_planning_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_plph_planning_hdr
    ADD CONSTRAINT raw_tms_plph_planning_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_pltpd_trip_planning_details
    ADD CONSTRAINT raw_tms_pltpd_trip_planning_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_pltph_trip_plan_hdr
    ADD CONSTRAINT raw_tms_pltph_trip_plan_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_pltpo_trip_odo_details
    ADD CONSTRAINT raw_tms_pltpo_trip_odo_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_plttd_trip_thu_details
    ADD CONSTRAINT raw_tms_plttd_trip_thu_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_plttsd_trip_thu_serial_details
    ADD CONSTRAINT raw_tms_plttsd_trip_thu_serial_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_resource_schedule_dtl
    ADD CONSTRAINT raw_tms_resource_schedule_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tarcd_tariff_rev_cost_dtl
    ADD CONSTRAINT raw_tms_tarcd_tariff_rev_cost_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tarch_tariff_rev_cost_hdr
    ADD CONSTRAINT raw_tms_tarch_tariff_rev_cost_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tlad_trip_log_agent_details
    ADD CONSTRAINT raw_tms_tlad_trip_log_agent_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tled_trip_log_event_details
    ADD CONSTRAINT raw_tms_tled_trip_log_event_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tled_trip_log_expense_details
    ADD CONSTRAINT raw_tms_tled_trip_log_expense_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tledd_trip_log_expense_document_details
    ADD CONSTRAINT raw_tms_tledd_trip_log_expense_document_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tleh_trip_log_expence_hdr
    ADD CONSTRAINT raw_tms_tleh_trip_log_expence_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tltd_trip_log_thu_details
    ADD CONSTRAINT raw_tms_tltd_trip_log_thu_details_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tpad_pod_attachment_dtl
    ADD CONSTRAINT raw_tms_tpad_pod_attachment_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl
    ADD CONSTRAINT raw_tms_tvtrcd_trip_vendor_tariff_rev_cost_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr
    ADD CONSTRAINT raw_tms_tvtrch_trip_vendor_tariff_rev_cost_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_uom_con_indconversion
    ADD CONSTRAINT raw_uom_con_indconversion_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_uom_mas_uommaster
    ADD CONSTRAINT raw_uom_mas_uommaster_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_uom_set_fn_param_dtl
    ADD CONSTRAINT raw_uom_set_fn_param_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_alloc_item_detail_hist
    ADD CONSTRAINT raw_wms_alloc_item_detail_hist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_alloc_item_detail
    ADD CONSTRAINT raw_wms_alloc_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_asn_add_dtl
    ADD CONSTRAINT raw_wms_asn_add_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_asn_detail_h
    ADD CONSTRAINT raw_wms_asn_detail_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_asn_detail
    ADD CONSTRAINT raw_wms_asn_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_asn_header_h
    ADD CONSTRAINT raw_wms_asn_header_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_asn_header
    ADD CONSTRAINT raw_wms_asn_header_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_dtl
    ADD CONSTRAINT raw_wms_bin_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_exec_hdr
    ADD CONSTRAINT raw_wms_bin_exec_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_exec_item_detail
    ADD CONSTRAINT raw_wms_bin_exec_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_exec_item_dtl
    ADD CONSTRAINT raw_wms_bin_exec_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_plan_hdr
    ADD CONSTRAINT raw_wms_bin_plan_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_plan_item_dtl
    ADD CONSTRAINT raw_wms_bin_plan_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_search_log
    ADD CONSTRAINT raw_wms_bin_search_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_type_hdr
    ADD CONSTRAINT raw_wms_bin_type_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_bin_type_storage_dtl
    ADD CONSTRAINT raw_wms_bin_type_storage_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_component_met
    ADD CONSTRAINT raw_wms_component_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_consignee_hdr
    ADD CONSTRAINT raw_wms_consignee_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_consignor_hdr
    ADD CONSTRAINT raw_wms_consignor_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_dtl_h
    ADD CONSTRAINT raw_wms_contract_dtl_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_dtl
    ADD CONSTRAINT raw_wms_contract_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_hdr_h
    ADD CONSTRAINT raw_wms_contract_hdr_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_hdr
    ADD CONSTRAINT raw_wms_contract_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_rev_leak_dtl
    ADD CONSTRAINT raw_wms_contract_rev_leak_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_transfer_inv_dtl
    ADD CONSTRAINT raw_wms_contract_transfer_inv_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_contract_transfer_inv_hdr
    ADD CONSTRAINT raw_wms_contract_transfer_inv_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_cust_attribute_dtl
    ADD CONSTRAINT raw_wms_cust_attribute_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_customer_hdr
    ADD CONSTRAINT raw_wms_customer_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_customer_location_division_dtl
    ADD CONSTRAINT raw_wms_customer_location_division_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_customer_portal_user_dtl
    ADD CONSTRAINT raw_wms_customer_portal_user_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_disp_cons_dtl
    ADD CONSTRAINT raw_wms_disp_cons_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_disp_load_dtl
    ADD CONSTRAINT raw_wms_disp_load_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_disp_rules_hdr
    ADD CONSTRAINT raw_wms_disp_rules_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_dispatch_dtl
    ADD CONSTRAINT raw_wms_dispatch_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_dispatch_hdr
    ADD CONSTRAINT raw_wms_dispatch_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_div_division_hdr
    ADD CONSTRAINT raw_wms_div_division_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_div_location_list_dtl
    ADD CONSTRAINT raw_wms_div_location_list_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_div_prop_hdr
    ADD CONSTRAINT raw_wms_div_prop_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_draft_bill_acc_tariff_dtl
    ADD CONSTRAINT raw_wms_draft_bill_acc_tariff_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_draft_bill_dtl
    ADD CONSTRAINT raw_wms_draft_bill_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_draft_bill_exec_dtl
    ADD CONSTRAINT raw_wms_draft_bill_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_draft_bill_hdr
    ADD CONSTRAINT raw_wms_draft_bill_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_draft_bill_supplier_contract_dtl
    ADD CONSTRAINT raw_wms_draft_bill_supplier_contract_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_hdr
    ADD CONSTRAINT raw_wms_employee_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_license_dtl
    ADD CONSTRAINT raw_wms_employee_license_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_location_dtl
    ADD CONSTRAINT raw_wms_employee_location_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_skills_dtl
    ADD CONSTRAINT raw_wms_employee_skills_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_type_dtl
    ADD CONSTRAINT raw_wms_employee_type_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_employee_unav_dates_dtl
    ADD CONSTRAINT raw_wms_employee_unav_dates_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_eqp_grp_dtl
    ADD CONSTRAINT raw_wms_eqp_grp_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_eqp_grp_hdr
    ADD CONSTRAINT raw_wms_eqp_grp_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_equipment_geo_info_dtl
    ADD CONSTRAINT raw_wms_equipment_geo_info_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_equipment_hdr
    ADD CONSTRAINT raw_wms_equipment_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_ex_item_hdr
    ADD CONSTRAINT raw_wms_ex_item_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_ex_itm_fix_bin_dtl
    ADD CONSTRAINT raw_wms_ex_itm_fix_bin_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_ex_itm_su_conversion_dtl
    ADD CONSTRAINT raw_wms_ex_itm_su_conversion_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_ex_itm_vas_dtl
    ADD CONSTRAINT raw_wms_ex_itm_vas_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_ex_itm_zone_check_dtl
    ADD CONSTRAINT raw_wms_ex_itm_zone_check_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_financial_dimension_odo_dtl
    ADD CONSTRAINT raw_wms_financial_dimension_odo_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gate_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_gate_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gate_exception_dtl
    ADD CONSTRAINT raw_wms_gate_exception_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gate_exec_dtl
    ADD CONSTRAINT raw_wms_gate_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gate_operation_dtl
    ADD CONSTRAINT raw_wms_gate_operation_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gate_plan_dtl
    ADD CONSTRAINT raw_wms_gate_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_city_dtl
    ADD CONSTRAINT raw_wms_geo_city_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_country_dtl
    ADD CONSTRAINT raw_wms_geo_country_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_postal_dtl
    ADD CONSTRAINT raw_wms_geo_postal_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_region_hdr
    ADD CONSTRAINT raw_wms_geo_region_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_state_dtl
    ADD CONSTRAINT raw_wms_geo_state_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_sub_zone_hdr
    ADD CONSTRAINT raw_wms_geo_sub_zone_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_suburb_dtl
    ADD CONSTRAINT raw_wms_geo_suburb_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_zone_dtl
    ADD CONSTRAINT raw_wms_geo_zone_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_geo_zone_hdr
    ADD CONSTRAINT raw_wms_geo_zone_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_goods_issue_dtl
    ADD CONSTRAINT raw_wms_goods_issue_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_goodsreceipt_plan_checklist_dtl
    ADD CONSTRAINT raw_wms_goodsreceipt_plan_checklist_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_goodsreceipt_rules_checklist_dtl
    ADD CONSTRAINT raw_wms_goodsreceipt_rules_checklist_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_gr_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_dtl
    ADD CONSTRAINT raw_wms_gr_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_item_dtl
    ADD CONSTRAINT raw_wms_gr_exec_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_reset_dtl
    ADD CONSTRAINT raw_wms_gr_exec_reset_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_serial_dtl
    ADD CONSTRAINT raw_wms_gr_exec_serial_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_thu_hdr
    ADD CONSTRAINT raw_wms_gr_exec_thu_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_exec_thu_lot_dtl
    ADD CONSTRAINT raw_wms_gr_exec_thu_lot_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_plan_dtl
    ADD CONSTRAINT raw_wms_gr_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_po_item_dtl
    ADD CONSTRAINT raw_wms_gr_po_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_rule_hdr
    ADD CONSTRAINT raw_wms_gr_rule_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_gr_thu_dtl
    ADD CONSTRAINT raw_wms_gr_thu_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_hr_internal_order_hdr
    ADD CONSTRAINT raw_wms_hr_internal_order_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_header_h
    ADD CONSTRAINT raw_wms_inbound_header_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_header
    ADD CONSTRAINT raw_wms_inbound_header_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_item_detail_h
    ADD CONSTRAINT raw_wms_inbound_item_detail_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_item_detail
    ADD CONSTRAINT raw_wms_inbound_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_pln_track_dtl
    ADD CONSTRAINT raw_wms_inbound_pln_track_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_sch_item_detail_h
    ADD CONSTRAINT raw_wms_inbound_sch_item_detail_h_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inbound_sch_item_detail
    ADD CONSTRAINT raw_wms_inbound_sch_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_int_ord_bin_dtl
    ADD CONSTRAINT raw_wms_int_ord_bin_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_int_ord_stk_accuracy_dtl
    ADD CONSTRAINT raw_wms_int_ord_stk_accuracy_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_int_ord_stk_con_quantity_dtl
    ADD CONSTRAINT raw_wms_int_ord_stk_con_quantity_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_int_ord_stk_con_status_dtl
    ADD CONSTRAINT raw_wms_int_ord_stk_con_status_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_internal_order_hdr
    ADD CONSTRAINT raw_wms_internal_order_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_inv_profile_dtl
    ADD CONSTRAINT raw_wms_inv_profile_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_item_hdr
    ADD CONSTRAINT raw_wms_item_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_item_supplier_dtl
    ADD CONSTRAINT raw_wms_item_supplier_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_itm_apmg
    ADD CONSTRAINT raw_wms_itm_apmg_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_lnm_lh_lotnohistory
    ADD CONSTRAINT raw_wms_lnm_lh_lotnohistory_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_lnm_lm_lotmaster
    ADD CONSTRAINT raw_wms_lnm_lm_lotmaster_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_load_rule_hdr
    ADD CONSTRAINT raw_wms_load_rule_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loading_exec_dtl
    ADD CONSTRAINT raw_wms_loading_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loading_exec_hdr
    ADD CONSTRAINT raw_wms_loading_exec_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loading_plan_dtl
    ADD CONSTRAINT raw_wms_loading_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_attribute_dtl
    ADD CONSTRAINT raw_wms_loc_attribute_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_customer_mapping_dtl
    ADD CONSTRAINT raw_wms_loc_customer_mapping_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_exception_dtl
    ADD CONSTRAINT raw_wms_loc_exception_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_location_geo_dtl
    ADD CONSTRAINT raw_wms_loc_location_geo_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_location_hdr
    ADD CONSTRAINT raw_wms_loc_location_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_location_shift_dtl
    ADD CONSTRAINT raw_wms_loc_location_shift_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_operation_dtl
    ADD CONSTRAINT raw_wms_loc_operation_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_prop_hdr
    ADD CONSTRAINT raw_wms_loc_prop_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_loc_user_mapping_dtl
    ADD CONSTRAINT raw_wms_loc_user_mapping_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_mapnt_mapnotypeno
    ADD CONSTRAINT raw_wms_mapnt_mapnotypeno_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_doc_detail
    ADD CONSTRAINT raw_wms_outbound_doc_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_header
    ADD CONSTRAINT raw_wms_outbound_header_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_item_detail
    ADD CONSTRAINT raw_wms_outbound_item_detail_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_lot_ser_dtl
    ADD CONSTRAINT raw_wms_outbound_lot_ser_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_sch_dtl
    ADD CONSTRAINT raw_wms_outbound_sch_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_outbound_vas_hdr
    ADD CONSTRAINT raw_wms_outbound_vas_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_pack_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_exec_hdr
    ADD CONSTRAINT raw_wms_pack_exec_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_exec_thu_dtl_hist
    ADD CONSTRAINT raw_wms_pack_exec_thu_dtl_hist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_exec_thu_dtl
    ADD CONSTRAINT raw_wms_pack_exec_thu_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_exec_thu_hdr
    ADD CONSTRAINT raw_wms_pack_exec_thu_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_hdr
    ADD CONSTRAINT raw_wms_pack_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_item_sr_dtl
    ADD CONSTRAINT raw_wms_pack_item_sr_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_plan_dtl
    ADD CONSTRAINT raw_wms_pack_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_plan_hdr
    ADD CONSTRAINT raw_wms_pack_plan_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pack_storage_dtl
    ADD CONSTRAINT raw_wms_pack_storage_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_pick_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_exec_dtl
    ADD CONSTRAINT raw_wms_pick_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_exec_hdr
    ADD CONSTRAINT raw_wms_pick_exec_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_plan_dtl
    ADD CONSTRAINT raw_wms_pick_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_plan_hdr
    ADD CONSTRAINT raw_wms_pick_plan_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_pick_rules_hdr
    ADD CONSTRAINT raw_wms_pick_rules_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_put_exec_item_dtl
    ADD CONSTRAINT raw_wms_put_exec_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_put_exec_serial_dtl
    ADD CONSTRAINT raw_wms_put_exec_serial_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_put_plan_item_dtl
    ADD CONSTRAINT raw_wms_put_plan_item_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_put_serial_dtl
    ADD CONSTRAINT raw_wms_put_serial_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_bin_capacity_dtl
    ADD CONSTRAINT raw_wms_putaway_bin_capacity_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_condition_grp_dtl
    ADD CONSTRAINT raw_wms_putaway_condition_grp_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_conditions_dtl
    ADD CONSTRAINT raw_wms_putaway_conditions_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_emp_equip_map_dtl
    ADD CONSTRAINT raw_wms_putaway_emp_equip_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_error_log
    ADD CONSTRAINT raw_wms_putaway_error_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_exec_dtl
    ADD CONSTRAINT raw_wms_putaway_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_mhe_dtl
    ADD CONSTRAINT raw_wms_putaway_mhe_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_plan_dtl
    ADD CONSTRAINT raw_wms_putaway_plan_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_profile_dtl
    ADD CONSTRAINT raw_wms_putaway_profile_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_rule_hdr
    ADD CONSTRAINT raw_wms_putaway_rule_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_putaway_zone_dtl
    ADD CONSTRAINT raw_wms_putaway_zone_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_quick_code_master_met
    ADD CONSTRAINT raw_wms_quick_code_master_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_quick_code_master
    ADD CONSTRAINT raw_wms_quick_code_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_route_hdr
    ADD CONSTRAINT raw_wms_route_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_shp_point_cusmap_dtl
    ADD CONSTRAINT raw_wms_shp_point_cusmap_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_shp_point_hdr
    ADD CONSTRAINT raw_wms_shp_point_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_skill_dtl
    ADD CONSTRAINT raw_wms_skill_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_spprocess_log
    ADD CONSTRAINT raw_wms_spprocess_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_src_strat_bts_pway_dtl
    ADD CONSTRAINT raw_wms_src_strat_bts_pway_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_src_strategy_picking_dtl
    ADD CONSTRAINT raw_wms_src_strategy_picking_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_sst_trans_map_dtl
    ADD CONSTRAINT raw_wms_sst_trans_map_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_def_mas
    ADD CONSTRAINT raw_wms_stage_def_mas_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_mas_dtl
    ADD CONSTRAINT raw_wms_stage_mas_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_mas_hdr
    ADD CONSTRAINT raw_wms_stage_mas_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_profile_hdr
    ADD CONSTRAINT raw_wms_stage_profile_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_profile_inbound_dtl
    ADD CONSTRAINT raw_wms_stage_profile_inbound_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_profile_outbound_dtl
    ADD CONSTRAINT raw_wms_stage_profile_outbound_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stage_transfer_aisle_dtl
    ADD CONSTRAINT raw_wms_stage_transfer_aisle_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_acc_assign_hdr
    ADD CONSTRAINT raw_wms_stock_acc_assign_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_acc_exec_dtl
    ADD CONSTRAINT raw_wms_stock_acc_exec_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_acc_exec_hdr
    ADD CONSTRAINT raw_wms_stock_acc_exec_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_bin_history_dtl
    ADD CONSTRAINT raw_wms_stock_bin_history_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_conversion_dtl
    ADD CONSTRAINT raw_wms_stock_conversion_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_conversion_hdr
    ADD CONSTRAINT raw_wms_stock_conversion_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_inprocess_tracking_dtl_hist
    ADD CONSTRAINT raw_wms_stock_inprocess_tracking_dtl_hist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_inprocess_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_inprocess_tracking_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_inprocess_tracking_serial_dtl_hist
    ADD CONSTRAINT raw_wms_stock_inprocess_tracking_serial_dtl_hist_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_inprocess_tracking_serial_dtl
    ADD CONSTRAINT raw_wms_stock_inprocess_tracking_serial_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_item_tracking_gr_load_dtl
    ADD CONSTRAINT raw_wms_stock_item_tracking_gr_load_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_ledger_dtl
    ADD CONSTRAINT raw_wms_stock_ledger_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_lot_tracking_daywise_dtl
    ADD CONSTRAINT raw_wms_stock_lot_tracking_daywise_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_lot_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_lot_tracking_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_rejected_dtl
    ADD CONSTRAINT raw_wms_stock_rejected_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_su_bal_dtl
    ADD CONSTRAINT raw_wms_stock_su_bal_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_uid_item_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_uid_item_tracking_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stock_uid_tracking_dtl
    ADD CONSTRAINT raw_wms_stock_uid_tracking_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stockbal_lot
    ADD CONSTRAINT raw_wms_stockbal_lot_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stockbal_serial
    ADD CONSTRAINT raw_wms_stockbal_serial_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stockbal_su_lot
    ADD CONSTRAINT raw_wms_stockbal_su_lot_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_stockbal_su_serial
    ADD CONSTRAINT raw_wms_stockbal_su_serial_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tariff_service_hdr
    ADD CONSTRAINT raw_wms_tariff_service_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tariff_transport_hdr
    ADD CONSTRAINT raw_wms_tariff_transport_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tariff_type_master
    ADD CONSTRAINT raw_wms_tariff_type_master_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tariff_type_met
    ADD CONSTRAINT raw_wms_tariff_type_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_thu_hdr
    ADD CONSTRAINT raw_wms_thu_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_thu_item_mapping_dtl
    ADD CONSTRAINT raw_wms_thu_item_mapping_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_timezone_details_met
    ADD CONSTRAINT raw_wms_timezone_details_met_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tran_perf_log_grput
    ADD CONSTRAINT raw_wms_tran_perf_log_grput_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_tran_perf_log_pac_cmp
    ADD CONSTRAINT raw_wms_tran_perf_log_pac_cmp_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_transaction_debug_dtl
    ADD CONSTRAINT raw_wms_transaction_debug_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_transient_thu_log
    ADD CONSTRAINT raw_wms_transient_thu_log_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_veh_mas_hdr
    ADD CONSTRAINT raw_wms_veh_mas_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_veh_registration_dtl
    ADD CONSTRAINT raw_wms_veh_registration_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_vendor_hdr
    ADD CONSTRAINT raw_wms_vendor_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_vendor_location_division_dtl
    ADD CONSTRAINT raw_wms_vendor_location_division_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_virtual_stockbal_lot
    ADD CONSTRAINT raw_wms_virtual_stockbal_lot_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_virtual_stockbal_su_lot
    ADD CONSTRAINT raw_wms_virtual_stockbal_su_lot_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_wave_dtl
    ADD CONSTRAINT raw_wms_wave_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_wave_hdr
    ADD CONSTRAINT raw_wms_wave_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_wave_location_control
    ADD CONSTRAINT raw_wms_wave_location_control_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_wave_operation_dtl
    ADD CONSTRAINT raw_wms_wave_operation_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_wave_rule_hdr
    ADD CONSTRAINT raw_wms_wave_rule_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_yard_dtl
    ADD CONSTRAINT raw_wms_yard_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_yard_hdr
    ADD CONSTRAINT raw_wms_yard_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_zone_hdr
    ADD CONSTRAINT raw_wms_zone_hdr_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY raw.raw_wms_zone_profile_dtl
    ADD CONSTRAINT raw_wms_zone_profile_dtl_pkey PRIMARY KEY (raw_id);

ALTER TABLE ONLY stg.stg_abb_account_budget_dtl
    ADD CONSTRAINT abb_account_budget_dtl_pkey PRIMARY KEY (company_code, fb_id, fin_year_code, fin_period_code, account_code);

ALTER TABLE ONLY stg.stg_acap_asset_hdr
    ADD CONSTRAINT acap_asset_hdr_pkey PRIMARY KEY (ou_id, cap_number, asset_number);

ALTER TABLE ONLY stg.stg_adep_depr_rate_hdr
    ADD CONSTRAINT adep_depr_rate_hdr_pkey PRIMARY KEY (ou_id, asset_class, depr_rate_id);

ALTER TABLE ONLY stg.stg_adepp_process_hdr
    ADD CONSTRAINT adepp_process_hdr_pkey PRIMARY KEY (ou_id, depr_proc_runno, depr_book);

ALTER TABLE ONLY stg.stg_aplan_acq_proposal_hdr
    ADD CONSTRAINT aplan_acq_proposal_hdr_pkey PRIMARY KEY (ou_id, fb_id, financial_year, asset_class_code, currency_code, proposal_number);

ALTER TABLE ONLY stg.stg_ard_addn_account_mst
    ADD CONSTRAINT ard_addn_account_mst_pkey PRIMARY KEY (company_code, fb_id, usage_id, effective_from, currency_code, drcr_flag, dest_fbid, child_company, dest_company, sequence_no);

ALTER TABLE ONLY stg.stg_ard_asset_account_mst
    ADD CONSTRAINT ard_asset_account_mst_pkey PRIMARY KEY (company_code, fb_id, asset_class, asset_usage, effective_from, sequence_no);

ALTER TABLE ONLY stg.stg_ard_bnkcsh_account_mst
    ADD CONSTRAINT ard_bnkcsh_account_mst_pkey PRIMARY KEY (company_code, fb_id, bank_ptt_code, effective_from, sequence_no);

ALTER TABLE ONLY stg.stg_ard_tax_addn_acct_mst
    ADD CONSTRAINT ard_tax_addn_acct_mst_pk PRIMARY KEY (company_code, tax_type, tax_community, usage_id, effective_from, sequence_no);

ALTER TABLE ONLY stg.stg_as_opaccount_dtl
    ADD CONSTRAINT as_opaccount_dtl_pkey PRIMARY KEY (opcoa_id, account_code);

ALTER TABLE ONLY stg.stg_as_opaccountfb_map
    ADD CONSTRAINT as_opaccountfb_map_pkey PRIMARY KEY (opcoa_id, account_code, company_code, fb_id);

ALTER TABLE ONLY stg.stg_as_taxyear_hdr
    ADD CONSTRAINT as_taxyear_hdr_pkey PRIMARY KEY (taxyr_code);

ALTER TABLE ONLY stg.stg_bnkdef_acc_mst
    ADD CONSTRAINT bnkdef_acc_mst_pkey PRIMARY KEY (company_code, bank_ref_no, bank_acc_no, serial_no);

ALTER TABLE ONLY stg.stg_bnkdef_code_mst
    ADD CONSTRAINT bnkdef_code_mst_pkey PRIMARY KEY (company_code, bank_ref_no, bank_acc_no, bank_code, serial_no);

ALTER TABLE ONLY stg.stg_cbadj_adjv_crdoc_dtl
    ADD CONSTRAINT cbadj_adjv_crdoc_dtl_pkey PRIMARY KEY (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_type, cr_doc_no, term_no, voucher_tran_type);

ALTER TABLE ONLY stg.stg_cbadj_adjv_drdoc_dtl
    ADD CONSTRAINT cbadj_adjv_drdoc_dtl_pkey PRIMARY KEY (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no, voucher_tran_type);

ALTER TABLE ONLY stg.stg_cbadj_adjvoucher_hdr
    ADD CONSTRAINT cbadj_adjvoucher_hdr_pkey PRIMARY KEY (ou_id, adj_voucher_no, voucher_tran_type);

ALTER TABLE ONLY stg.stg_cdcn_acc_dtl
    ADD CONSTRAINT cdcn_acc_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_cdcn_ar_postings_dtl
    ADD CONSTRAINT cdcn_ar_postings_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY stg.stg_cdcn_dcnote_hdr
    ADD CONSTRAINT cdcn_dcnote_hdr_pkey PRIMARY KEY (tran_type, tran_ou, tran_no);

ALTER TABLE ONLY stg.stg_cdcn_item_dtl
    ADD CONSTRAINT cdcn_item_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_cdi_ar_postings_dtl
    ADD CONSTRAINT cdi_ar_postings_dtl_pk1 PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY stg.stg_ci_doc_hdr
    ADD CONSTRAINT ci_doc_hdr_pkey PRIMARY KEY (tran_ou, tran_type, tran_no);

ALTER TABLE ONLY stg.stg_cm_creditterm_hdr
    ADD CONSTRAINT cm_creditterm_hdr_pkey PRIMARY KEY (companybu_code, type_flag, creditterm_code);

ALTER TABLE ONLY stg.stg_cps_processparam_sys
    ADD CONSTRAINT cps_processparam_sys_pkey PRIMARY KEY (company_code, ou_id, parameter_type, parameter_category, parameter_code, language_id);

ALTER TABLE ONLY stg.stg_cust_comp_info
    ADD CONSTRAINT cust_comp_info_pk PRIMARY KEY (comp_lo, comp_cust_code, comp_comp_code);

ALTER TABLE ONLY stg.stg_cust_group_hdr
    ADD CONSTRAINT cust_group_hdr_pk PRIMARY KEY (cgh_lo, cgh_cust_group_code, cgh_control_group_flag, cgh_group_type_code);

ALTER TABLE ONLY stg.stg_cust_lo_info
    ADD CONSTRAINT cust_lo_info_pk PRIMARY KEY (clo_lo, clo_cust_code);

ALTER TABLE ONLY stg.stg_cust_ou_info
    ADD CONSTRAINT cust_ou_info_pk PRIMARY KEY (cou_lo, cou_bu, cou_ou, cou_cust_code);

ALTER TABLE ONLY stg.stg_cust_prospect_info
    ADD CONSTRAINT cust_prospect_info_pk PRIMARY KEY (cpr_lo, cpr_prosp_cust_code);

ALTER TABLE ONLY stg.stg_eam_amc_hdr
    ADD CONSTRAINT eam_amc_hdr_pkey PRIMARY KEY (amc_amcno, amc_amcou);

ALTER TABLE ONLY stg.stg_emod_addr_mst
    ADD CONSTRAINT emod_addr_mst_pkey PRIMARY KEY (address_id);

ALTER TABLE ONLY stg.stg_emod_bank_ref_mst
    ADD CONSTRAINT emod_bank_ref_mst_pkey PRIMARY KEY (bank_ref_no, bank_status);

ALTER TABLE ONLY stg.stg_emod_bfg_component_met
    ADD CONSTRAINT emod_bfg_component_met_pkey PRIMARY KEY (bfg_code, component_id);

ALTER TABLE ONLY stg.stg_emod_bu_mst
    ADD CONSTRAINT emod_bu_mst_pkey PRIMARY KEY (company_code, bu_id, serial_no);

ALTER TABLE ONLY stg.stg_emod_company_currency_map
    ADD CONSTRAINT emod_company_currency_map_pkey PRIMARY KEY (serial_no, company_code, currency_code);

ALTER TABLE ONLY stg.stg_emod_company_mst
    ADD CONSTRAINT emod_company_mst_pkey PRIMARY KEY (company_code, serial_no);

ALTER TABLE ONLY stg.stg_emod_currency_mst
    ADD CONSTRAINT emod_currency_mst_pkey PRIMARY KEY (iso_curr_code, serial_no);

ALTER TABLE ONLY stg.stg_emod_finbook_mst
    ADD CONSTRAINT emod_finbook_mst_pkey PRIMARY KEY (fb_id, company_code, serial_no, fb_type);

ALTER TABLE ONLY stg.stg_emod_lo_bu_map
    ADD CONSTRAINT emod_lo_bu_map_pkey PRIMARY KEY (lo_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY stg.stg_emod_ou_bu_map
    ADD CONSTRAINT emod_ou_bu_map_pkey PRIMARY KEY (ou_id, bu_id, company_code, serial_no);

ALTER TABLE ONLY stg.stg_emod_ou_mst
    ADD CONSTRAINT emod_ou_mst_pkey PRIMARY KEY (ou_id, bu_id, company_code, address_id, serial_no);

ALTER TABLE ONLY stg.stg_erate_exrate_mst
    ADD CONSTRAINT erate_exrate_mst_pkey PRIMARY KEY (ou_id, exchrate_type, from_currency, to_currency, inverse_typeno, start_date);

ALTER TABLE ONLY stg.stg_fbp_account_balance
    ADD CONSTRAINT fbp_account_balance_pkey PRIMARY KEY (ou_id, company_code, fb_id, fin_year, fin_period, account_code, currency_code);

ALTER TABLE ONLY stg.stg_fbp_voucher_dtl
    ADD CONSTRAINT fbp_voucher_dtl_pkey PRIMARY KEY (parent_key, current_key, company_code, ou_id, fb_id, fb_voucher_no, serial_no);

ALTER TABLE ONLY stg.stg_fbp_voucher_hdr
    ADD CONSTRAINT fbp_voucher_hdr_pkey PRIMARY KEY (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);

ALTER TABLE ONLY stg.stg_jv_voucher_trn_dtl
    ADD CONSTRAINT jv_voucher_trn_dtl_pkey PRIMARY KEY (ou_id, voucher_no, voucher_serial_no);

ALTER TABLE ONLY stg.stg_jv_voucher_trn_hdr
    ADD CONSTRAINT jv_voucher_trn_hdr_pkey PRIMARY KEY (ou_id, voucher_no);

ALTER TABLE ONLY stg.stg_ops_processparam_sys
    ADD CONSTRAINT ops_processparam_sys_pkey PRIMARY KEY (ou_id, parameter_type, parameter_category, parameter_code, language_id);

ALTER TABLE ONLY stg.stg_menu_master
    ADD CONSTRAINT pcs_mobility_menu_master_tbl_pk PRIMARY KEY (menuid);

ALTER TABLE ONLY stg.stg_cdi_invoice_hdr
    ADD CONSTRAINT pk__cdi_invoice_hdr__3e9958de PRIMARY KEY (tran_type, tran_ou, tran_no);

ALTER TABLE ONLY stg.stg_cdi_item_dtl
    ADD CONSTRAINT pk__cdi_item_dtl__77b1daa9 PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_dim_dest_tran_dtl
    ADD CONSTRAINT pk__dim_dest__12c9edbd320367e1 PRIMARY KEY (tran_no, tran_ou, tran_type, line_no);

ALTER TABLE ONLY stg.stg_dim_dest_tran_hdr
    ADD CONSTRAINT pk__dim_dest__12c9edbda023e94e PRIMARY KEY (tran_no, tran_ou, tran_type, line_no);

ALTER TABLE ONLY stg.stg_dim_maintain_dtls
    ADD CONSTRAINT pk__dim_main__8dedaafb7dd35e4a PRIMARY KEY (company_code, dim_name);

ALTER TABLE ONLY stg.stg_fact_inbound_grn
    ADD CONSTRAINT pk__fact_inb__b48ae12d31f2418c PRIMARY KEY (reference_no);

ALTER TABLE ONLY stg.stg_fact_inbound_asn
    ADD CONSTRAINT pk__fact_inb__b48ae12d4b0b8b08 PRIMARY KEY (reference_no);

ALTER TABLE ONLY stg.stg_fact_outbound_wave
    ADD CONSTRAINT pk__fact_out__4cd9458e13a853f2 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_br
    ADD CONSTRAINT pk__fact_out__4cd9458e3e7f8556 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_pickexec
    ADD CONSTRAINT pk__fact_out__4cd9458e837df774 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_packexec
    ADD CONSTRAINT pk__fact_out__4cd9458e9c430327 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_obd
    ADD CONSTRAINT pk__fact_out__4cd9458ea53ab33a PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_disp
    ADD CONSTRAINT pk__fact_out__4cd9458eb107b1b9 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_load
    ADD CONSTRAINT pk__fact_out__4cd9458eb13accba PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_triphdr
    ADD CONSTRAINT pk__fact_out__4e83131435d1dbc0 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_fact_outbound_tripagent
    ADD CONSTRAINT pk__fact_out__4e831314f65e5f64 PRIMARY KEY (refkey);

ALTER TABLE ONLY stg.stg_kdx_lead_header
    ADD CONSTRAINT pk__kdx_lead_header__6e6bcae6 PRIMARY KEY (kdx_ou, kdx_projectno);

ALTER TABLE ONLY stg.stg_lbc_offline_wms_stock_uid_tracking_load_stag
    ADD CONSTRAINT pk__lbc_offl__7171e4ff54a9e818 PRIMARY KEY (running_no);

ALTER TABLE ONLY stg.stg_not_notes_attachdoc
    ADD CONSTRAINT pk__not_note__61fd609002277387 PRIMARY KEY (sequence_no, notes_compkey, line_no, line_entity);

ALTER TABLE ONLY stg.stg_not_notes_dtl
    ADD CONSTRAINT pk__not_notes_dtl__409e6f85 PRIMARY KEY (notes_compkey, line_no, line_entity);

ALTER TABLE ONLY stg.stg_not_notes_hdr
    ADD CONSTRAINT pk__not_notes_hdr__437adc30 PRIMARY KEY (notes_compkey);

ALTER TABLE ONLY stg.stg_not_trantype_met
    ADD CONSTRAINT pk__not_trantype_met__483f914d PRIMARY KEY (tran_type, tran_desc, lang_id);

ALTER TABLE ONLY stg.stg_tms_tpad_pod_attachment_dtl
    ADD CONSTRAINT pk__tms_tpad__d1314a7beb620e7e PRIMARY KEY (tpad_line_no);

ALTER TABLE ONLY stg.stg_client_service_log
    ADD CONSTRAINT pk_client_1 PRIMARY KEY (cust_id);

ALTER TABLE ONLY stg.stg_client_master
    ADD CONSTRAINT pk_client_master PRIMARY KEY (rowid);

ALTER TABLE ONLY stg.stg_con_child_master
    ADD CONSTRAINT pk_con_child_master_1 PRIMARY KEY (childid);

ALTER TABLE ONLY stg.stg_con_module_master
    ADD CONSTRAINT pk_con_module_master_1 PRIMARY KEY (moduleid);

ALTER TABLE ONLY stg.stg_con_parent_master
    ADD CONSTRAINT pk_con_parent_master_1 PRIMARY KEY (parentid);

ALTER TABLE ONLY stg.stg_file_upload_master
    ADD CONSTRAINT pk_file_upload_master PRIMARY KEY (upload_id);

ALTER TABLE ONLY stg.stg_gr_hdr_grmain
    ADD CONSTRAINT pk_grmain PRIMARY KEY (gr_hdr_grno, gr_hdr_ouinstid);

ALTER TABLE ONLY stg.stg_param_register
    ADD CONSTRAINT pk_param_mappings PRIMARY KEY (param_id);

ALTER TABLE ONLY stg.stg_param_mapping
    ADD CONSTRAINT pk_param_mappings_1 PRIMARY KEY (param_map_id);

ALTER TABLE ONLY stg.stg_pcsit_gate_invoice
    ADD CONSTRAINT pk_pcsit_gate_invoice PRIMARY KEY (gate_loc_code, gate_exec_no, gate_ou, invoice_number);

ALTER TABLE ONLY stg.stg_pcsit_loc_sp_mapping_rcs
    ADD CONSTRAINT pk_pcsit_loc_sp_mapping_rcs PRIMARY KEY (rowid);

ALTER TABLE ONLY stg.stg_pcsit_mp_log
    ADD CONSTRAINT pk_pcsit_mp_log PRIMARY KEY (shipmentid);

ALTER TABLE ONLY stg.stg_pcsit_prepared_shipment
    ADD CONSTRAINT pk_pcsit_prepared_shipment PRIMARY KEY (ou, type, locationcode, doc_no, thu_id, status);

ALTER TABLE ONLY stg.stg_pcsit_rt_bin_details
    ADD CONSTRAINT pk_pcsit_rt_bin_details PRIMARY KEY (bin_ou, bin_code, bin_loc_code);

ALTER TABLE ONLY stg.stg_pcsit_wh_cons_rcs
    ADD CONSTRAINT pk_pcsit_wh_cons_rcs PRIMARY KEY (wh_cong_id);

ALTER TABLE ONLY stg.stg_pcsit_bin_unitconversion
    ADD CONSTRAINT pk_pcsitd_bin_unitconversion PRIMARY KEY (rowid);

ALTER TABLE ONLY stg.stg_ramco_service_master
    ADD CONSTRAINT pk_ramco_service_master PRIMARY KEY (rowid);

ALTER TABLE ONLY stg.stg_scheduler_service_call
    ADD CONSTRAINT pk_service_1 PRIMARY KEY (scheduler_id);

ALTER TABLE ONLY stg.stg_sng_automail_pcklist
    ADD CONSTRAINT pk_sng_automail_pcklist PRIMARY KEY (execid);

ALTER TABLE ONLY stg.stg_client_onboard_mapping
    ADD CONSTRAINT pk_table_1 PRIMARY KEY (mapping_id);

ALTER TABLE ONLY stg.stg_tms_brccd_consgt_consignee_details
    ADD CONSTRAINT pk_tms_brccd_consgt_consignee_details PRIMARY KEY (ccd_ouinstance, ccd_br_id);

ALTER TABLE ONLY stg.stg_tms_brcds_consgt_additional_services
    ADD CONSTRAINT pk_tms_brcds_consgt_additional_services PRIMARY KEY (cds_ouinstance, cds_br_id);

ALTER TABLE ONLY stg.stg_tms_brctcd_consgt_thu_child_details
    ADD CONSTRAINT pk_tms_brctcd_consgt_thu_child_details PRIMARY KEY (ctcd_ouinstance, ctcd_br_line_no, ctcd_child_thu_line_no);

ALTER TABLE ONLY stg.stg_tms_brctd_consgt_thu_serial_details
    ADD CONSTRAINT pk_tms_brctd_consgt_thu_serial_details PRIMARY KEY (ctsd_ouinstance, ctsd_thu_line_no, ctsd_thu_serial_line_no);

ALTER TABLE ONLY stg.stg_tms_brrd_br_recurring_details
    ADD CONSTRAINT pk_tms_brrd_br_recurring_details PRIMARY KEY (brrd_ouinstance, brrd_br_id);

ALTER TABLE ONLY stg.stg_tms_brsd_shipment_details
    ADD CONSTRAINT pk_tms_brsd_shipment_details PRIMARY KEY (brsd_ouinstance, brsd_br_id);

ALTER TABLE ONLY stg.stg_tms_ddh_dispatch_document_hdr
    ADD CONSTRAINT pk_tms_ddh_dispatch_document_hdr PRIMARY KEY (ddh_ouinstance, ddh_dispatch_doc_no);

ALTER TABLE ONLY stg.stg_tms_ddtcd_dispatch_document_thu_child_dtl
    ADD CONSTRAINT pk_tms_ddtcd_dispatch_document_thu_child_dtl PRIMARY KEY (ddtcd_ouinstance, ddtcd_dispatch_doc_no, ddtcd_thu_line_no, ddtcd_thu_child_line_no);

ALTER TABLE ONLY stg.stg_tms_ddtcd_dispatch_document_thu_serial_dtl
    ADD CONSTRAINT pk_tms_ddtcd_dispatch_document_thu_serial_dtl PRIMARY KEY (ddtsd_ouinstance, ddtsd_dispatch_doc_no, ddtsd_thu_line_no, ddtsd_thu_serial_line_no);

ALTER TABLE ONLY stg.stg_tms_ddtd_dispatch_document_thu_dtl
    ADD CONSTRAINT pk_tms_ddtd_dispatch_document_thu_dtl PRIMARY KEY (ddtd_ouinstance, ddtd_dispatch_doc_no, ddtd_thu_line_no);

ALTER TABLE ONLY stg.stg_tms_evccu_event_configuration_customer_dtl
    ADD CONSTRAINT pk_tms_evccu_event_configuration_customer_dtl PRIMARY KEY (evccu_ouinstance, evccu_guid);

ALTER TABLE ONLY stg.stg_tms_evcld_event_configuration_loc_div_dtl
    ADD CONSTRAINT pk_tms_evcld_event_configuration_loc_div_dtl PRIMARY KEY (evcld_ouinstance, evcld_guid);

ALTER TABLE ONLY stg.stg_tms_evcsd_event_configuration_setup_dtl
    ADD CONSTRAINT pk_tms_evcsd_event_configuration_setup_dtl PRIMARY KEY (evcsd_ouinstance, evcsd_guid);

ALTER TABLE ONLY stg.stg_tms_mvtbr_multiple_vendor_thu_br_dtls
    ADD CONSTRAINT pk_tms_mvtbr_multiple_vendor_thu_br_dtls PRIMARY KEY (mvtbr_ouinstance, mvtbr_guid);

ALTER TABLE ONLY stg.stg_tms_mvtdd_multiple_vendor_thu_dd_dtls
    ADD CONSTRAINT pk_tms_mvtdd_multiple_vendor_thu_dd_dtls PRIMARY KEY (mvtdd_ouinstance, mvtdd_dispatch_no, mvtdd_guid);

ALTER TABLE ONLY stg.stg_tms_plepd_execution_plan_details
    ADD CONSTRAINT pk_tms_plepd_execution_plan_details PRIMARY KEY (plepd_ouinstance, plepd_execution_plan_id, plepd_line_no);

ALTER TABLE ONLY stg.stg_tms_plpd_planning_details
    ADD CONSTRAINT pk_tms_plpd_planning_details PRIMARY KEY (plpd_ouinstance, plpd_plan_run_no, plpd_plan_unique_id);

ALTER TABLE ONLY stg.stg_tms_plph_planning_hdr
    ADD CONSTRAINT pk_tms_plph_planning_hdr PRIMARY KEY (plph_ouinstance, plph_plan_run_no);

ALTER TABLE ONLY stg.stg_tms_plppdd_division_details
    ADD CONSTRAINT pk_tms_plppdd_division_details PRIMARY KEY (plppdd_ouinstance, plppd_profile_id, plppd_line_no);

ALTER TABLE ONLY stg.stg_tms_plpph_planning_profile_hdr
    ADD CONSTRAINT pk_tms_plpph_planning_profile_hdr PRIMARY KEY (plpph_ouinstance, plpph_profile_id);

ALTER TABLE ONLY stg.stg_tms_pltph_trip_plan_hdr
    ADD CONSTRAINT pk_tms_pltph_trip_plan_hdr PRIMARY KEY (plpth_ouinstance, plpth_trip_plan_id);

ALTER TABLE ONLY stg.stg_tms_pltpo_trip_odo_details
    ADD CONSTRAINT pk_tms_pltpo_trip_odo_details PRIMARY KEY (plpto_ouinstance, plpto_guid);

ALTER TABLE ONLY stg.stg_tms_tlcd_trip_log_event_contact_details
    ADD CONSTRAINT pk_tms_tlcd_trip_log_event_contact_details PRIMARY KEY (tlecd_ouinstance, tlecd_con_guid);

ALTER TABLE ONLY stg.stg_tms_tled_trip_log_event_details
    ADD CONSTRAINT pk_tms_tled_trip_log_event_details PRIMARY KEY (tled_ouinstance, tled_trip_plan_id, tled_trip_plan_unique_id);

ALTER TABLE ONLY stg.stg_tms_tledd_trip_log_expense_document_details
    ADD CONSTRAINT pk_tms_tledd_trip_log_expense_document_details PRIMARY KEY (tledd_ouinstance, tledd_doc_guid);

ALTER TABLE ONLY stg.stg_tms_trh_tender_req_header
    ADD CONSTRAINT pk_tms_trh_tender_req_header PRIMARY KEY (trh_ouinstance, trh_tender_req_no);

ALTER TABLE ONLY stg.stg_uom_con_indconversion
    ADD CONSTRAINT pk_uom_ind_conversion PRIMARY KEY (con_fromuomcode, con_touomcode);

ALTER TABLE ONLY stg.stg_uom_mas_uommaster
    ADD CONSTRAINT pk_uom_mas_uommaster PRIMARY KEY (mas_uomcode);

ALTER TABLE ONLY stg.stg_wms_bin_dtl
    ADD CONSTRAINT pk_wms_bin_dtl PRIMARY KEY (wms_bin_ou, wms_bin_code, wms_bin_loc_code, wms_bin_zone, wms_bin_type);

ALTER TABLE ONLY stg.stg_wms_pick_exec_dtl
    ADD CONSTRAINT pk_wms_pick_exec_dtl PRIMARY KEY (wms_pick_loc_code, wms_pick_exec_no, wms_pick_exec_ou, wms_pick_lineno);

ALTER TABLE ONLY stg.stg_wms_pick_exec_hdr
    ADD CONSTRAINT pk_wms_pick_exec_hdr PRIMARY KEY (wms_pick_loc_code, wms_pick_exec_no, wms_pick_exec_ou);

ALTER TABLE ONLY stg.stg_wms_pick_plan_dtl
    ADD CONSTRAINT pk_wms_pick_plan_dtl PRIMARY KEY (wms_pick_loc_code, wms_pick_pln_no, wms_pick_pln_ou, wms_pick_lineno);

ALTER TABLE ONLY stg.stg_wms_pick_plan_hdr
    ADD CONSTRAINT pk_wms_pick_plan_hdr PRIMARY KEY (wms_pick_loc_code, wms_pick_pln_no, wms_pick_pln_ou);

ALTER TABLE ONLY stg.stg_wms_stock_ledger_dtl
    ADD CONSTRAINT pk_wms_stkled_guid PRIMARY KEY (wms_stkled_guid);

ALTER TABLE ONLY stg.stg_item_group_type
    ADD CONSTRAINT pkitem_group_type PRIMARY KEY (item_igt_grouptype, item_igt_lo);

ALTER TABLE ONLY stg.stg_po_poitm_item_detail
    ADD CONSTRAINT pkpo_poitm_item_detail PRIMARY KEY (poitm_pono, poitm_poamendmentno, poitm_polineno, poitm_poou);

ALTER TABLE ONLY stg.stg_po_pomas_pur_order_hdr
    ADD CONSTRAINT pkpo_pomas_pur_order_hdr PRIMARY KEY (pomas_pono, pomas_poamendmentno, pomas_poou);

ALTER TABLE ONLY stg.stg_po_poprq_poprcovg_detail
    ADD CONSTRAINT pkpo_poprq_poprcovg_detail PRIMARY KEY (poprq_pono, poprq_poamendmentno, poprq_polineno, poprq_scheduleno, poprq_posubscheduleno, poprq_prou, poprq_prno, poprq_prlineno, poprq_pr_shdno, poprq_pr_subsceduleno, poprq_poou);

ALTER TABLE ONLY stg.stg_prq_preqm_pur_reqst_hdr
    ADD CONSTRAINT pkprq_preqm_pur_reqst_hdr PRIMARY KEY (preqm_prno, preqm_prou);

ALTER TABLE ONLY stg.stg_prq_prqit_item_detail
    ADD CONSTRAINT pkprq_prqit_item_detail PRIMARY KEY (prqit_prno, prqit_lineno, prqit_prou);

ALTER TABLE ONLY stg.stg_rct_purchase_hdr
    ADD CONSTRAINT rct_purchase_hdr_pk PRIMARY KEY (rcgh_receipt_no, rcgh_ouinstid);

ALTER TABLE ONLY stg.stg_rp_postings_dtl
    ADD CONSTRAINT rp_postings_dtl_pkey PRIMARY KEY (ou_id, serial_no, unique_no, doc_type, tran_ou, document_no, account_code, tran_type);

ALTER TABLE ONLY stg.stg_rpt_acct_info_dtl
    ADD CONSTRAINT rpt_acct_info_dtl_pkey PRIMARY KEY (ou_id, tran_no, account_code, tran_type, drcr_flag, posting_line_no);

ALTER TABLE ONLY stg.stg_rpt_receipt_dtl
    ADD CONSTRAINT rpt_receipt_dtl_pkey PRIMARY KEY (ou_id, receipt_no, dr_doc_no, dr_doc_ou, term_no, dr_tran_type);

ALTER TABLE ONLY stg.stg_rpt_receipt_hdr
    ADD CONSTRAINT rpt_receipt_hdr_pkey PRIMARY KEY (ou_id, receipt_no);

ALTER TABLE ONLY stg.stg_sa_wm_warehouse_master
    ADD CONSTRAINT sa_wm_warehouse_master_pk PRIMARY KEY (wm_wh_code, wm_wh_ou);

ALTER TABLE ONLY stg.stg_sad_adjv_crdoc_dtl
    ADD CONSTRAINT sad_adjv_crdoc_dtl_pkey PRIMARY KEY (ou_id, adj_voucher_no, cr_doc_ou, cr_doc_no, term_no, cr_doc_type);

ALTER TABLE ONLY stg.stg_sad_adjv_drdoc_dtl
    ADD CONSTRAINT sad_adjv_drdoc_dtl_pkey PRIMARY KEY (ou_id, adj_voucher_no, dr_doc_ou, dr_doc_type, dr_doc_no, term_no);

ALTER TABLE ONLY stg.stg_sad_adjvoucher_hdr
    ADD CONSTRAINT sad_adjvoucher_hdr_pkey PRIMARY KEY (ou_id, adj_voucher_no);

ALTER TABLE ONLY stg.stg_scdn_acc_dtl
    ADD CONSTRAINT scdn_acc_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_scdn_ap_postings_dtl
    ADD CONSTRAINT scdn_ap_postings_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY stg.stg_scdn_dcnote_hdr
    ADD CONSTRAINT scdn_dcnote_hdr_pkey PRIMARY KEY (tran_type, tran_ou, tran_no);

ALTER TABLE ONLY stg.stg_menu_mapping
    ADD CONSTRAINT screen_user_mapping PRIMARY KEY (mappingid);

ALTER TABLE ONLY stg.stg_sdin_ap_postings_dtl
    ADD CONSTRAINT sdin_ap_postings_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY stg.stg_sdin_expense_dtl
    ADD CONSTRAINT sdin_expense_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_sdin_invoice_hdr
    ADD CONSTRAINT sdin_invoice_hdr_pkey PRIMARY KEY (tran_type, tran_ou, tran_no);

ALTER TABLE ONLY stg.stg_si_doc_hdr
    ADD CONSTRAINT si_doc_hdr_pkey PRIMARY KEY (tran_ou, tran_type, tran_no);

ALTER TABLE ONLY stg.stg_sin_ap_postings_dtl
    ADD CONSTRAINT sin_ap_postings_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, posting_line_no);

ALTER TABLE ONLY stg.stg_sin_invoice_hdr
    ADD CONSTRAINT sin_invoice_hdr_pkey PRIMARY KEY (tran_type, tran_ou, tran_no);

ALTER TABLE ONLY stg.stg_sin_item_dtl
    ADD CONSTRAINT sin_item_dtl_pkey PRIMARY KEY (tran_type, tran_ou, tran_no, line_no);

ALTER TABLE ONLY stg.stg_snp_fbposting_dtl
    ADD CONSTRAINT snp_fbposting_dtl_pkey PRIMARY KEY (batch_id, ou_id, document_no, account_lineno, account_code);

ALTER TABLE ONLY stg.stg_snp_voucher_dtl
    ADD CONSTRAINT snp_voucher_dtl_pkey PRIMARY KEY (ou_id, voucher_no, voucher_type, account_lineno, tran_type);

ALTER TABLE ONLY stg.stg_snp_voucher_hdr
    ADD CONSTRAINT snp_voucher_hdr_pkey PRIMARY KEY (ou_id, voucher_no, voucher_type, tran_type);

ALTER TABLE ONLY stg.stg_spy_paybatch_dtl
    ADD CONSTRAINT spy_paybatch_dtl_pkey PRIMARY KEY (ou_id, paybatch_no, cr_doc_ou, cr_doc_no, term_no, tran_type);

ALTER TABLE ONLY stg.stg_spy_paybatch_hdr
    ADD CONSTRAINT spy_paybatch_hdr_pkey PRIMARY KEY (ou_id, paybatch_no);

ALTER TABLE ONLY stg.stg_spy_prepay_vch_hdr
    ADD CONSTRAINT spy_prepay_vch_hdr_pkey PRIMARY KEY (ou_id, voucher_no, tran_type);

ALTER TABLE ONLY stg.stg_spy_voucher_dtl
    ADD CONSTRAINT spy_voucher_dtl_pkey PRIMARY KEY (ou_id, paybatch_no, voucher_no, cr_doc_ou, cr_doc_no, term_no, tran_type, cr_doc_type);

ALTER TABLE ONLY stg.stg_spy_voucher_hdr
    ADD CONSTRAINT spy_voucher_hdr_pkey PRIMARY KEY (ou_id, paybatch_no, voucher_no);

ALTER TABLE ONLY stg.stg_sur_fbpostings_dtl
    ADD CONSTRAINT sur_fbpostings_dtl_pkey PRIMARY KEY (ou_id, tran_type, fb_id, tran_no, account_code, drcr_flag, acct_lineno);

ALTER TABLE ONLY stg.stg_sur_receipt_dtl
    ADD CONSTRAINT sur_receipt_dtl_pkey PRIMARY KEY (ou_id, receipt_type, receipt_no, refdoc_lineno, tran_type);

ALTER TABLE ONLY stg.stg_sur_receipt_hdr
    ADD CONSTRAINT sur_receipt_hdr_pkey PRIMARY KEY (ou_id, receipt_no, receipt_type, tran_type);

ALTER TABLE ONLY stg.stg_tbp_voucher_hdr
    ADD CONSTRAINT tbp_voucher_hdr_pkey PRIMARY KEY (current_key, company_code, component_name, bu_id, fb_id, fb_voucher_no);

ALTER TABLE ONLY stg.stg_tcal_tran_hdr
    ADD CONSTRAINT tcal_tran_hdr_pkey PRIMARY KEY (tran_no, tax_type, tran_type, tran_ou);

ALTER TABLE ONLY stg.stg_tms_component_met
    ADD CONSTRAINT tms_component_met_pk PRIMARY KEY (tms_componentname, tms_paramcategory, tms_paramtype, tms_paramcode, tms_paramdesc, tms_langid);

ALTER TABLE ONLY stg.stg_tms_ofp_other_function_parameters
    ADD CONSTRAINT tms_ofp_other_function_parameters_pk PRIMARY KEY (ofp_ou, ofp_parameter_code);

ALTER TABLE ONLY stg.stg_tms_tlad_trip_log_agent_details
    ADD CONSTRAINT tms_tlad_trip_log_agent_details_pk PRIMARY KEY (tlad_ouinstance, tlad_trip_plan_id, tlad_dispatch_doc_no, tlad_thu_line_no);

ALTER TABLE ONLY stg.stg_tms_tlmvt_trip_log_multi_vendor_thu_dtls
    ADD CONSTRAINT tms_tlmvt_trip_log_mul_ven_thu_pk PRIMARY KEY (tlmvt_ouinstance, tlmvt_guid);

ALTER TABLE ONLY stg.stg_tms_trip_log_vas_details_hdr
    ADD CONSTRAINT tms_trip_log_vas_details_hdr_pk PRIMARY KEY (tlvd_ouinstance, tlvd_trip_no, tlvd_guid);

ALTER TABLE ONLY stg.stg_tset_tax_category
    ADD CONSTRAINT tset_tax_category_pkey PRIMARY KEY (tax_community, tax_type, company_code, tax_category, trade_type);

ALTER TABLE ONLY stg.stg_uom_set_fn_param_dtl
    ADD CONSTRAINT uom_set_fn_param_dtl_pk PRIMARY KEY (ufnd_lo, ufnd_ou, ufnd_lineno);

ALTER TABLE ONLY stg.stg_wms_alloc_item_detail
    ADD CONSTRAINT wms_alloc_item_detail_pk PRIMARY KEY (allc_doc_no, allc_doc_ou, allc_doc_line_no, allc_alloc_line_no);

ALTER TABLE ONLY stg.stg_wms_asn_add_dtl
    ADD CONSTRAINT wms_asn_add_dtl_pk PRIMARY KEY (wms_asn_pop_asn_no, wms_asn_pop_loc, wms_asn_pop_ou, wms_asn_pop_line_no);

ALTER TABLE ONLY stg.stg_wms_asn_detail_h
    ADD CONSTRAINT wms_asn_detail_h_pk PRIMARY KEY (wms_asn_ou, wms_asn_location, wms_asn_no, wms_asn_amendno, wms_asn_lineno);

ALTER TABLE ONLY stg.stg_wms_asn_detail
    ADD CONSTRAINT wms_asn_detail_pk PRIMARY KEY (wms_asn_ou, wms_asn_location, wms_asn_no, wms_asn_lineno);

ALTER TABLE ONLY stg.stg_wms_asn_header_h
    ADD CONSTRAINT wms_asn_header_h_pk PRIMARY KEY (wms_asn_ou, wms_asn_location, wms_asn_no, wms_asn_amendno);

ALTER TABLE ONLY stg.stg_wms_asn_header
    ADD CONSTRAINT wms_asn_header_pk PRIMARY KEY (wms_asn_ou, wms_asn_location, wms_asn_no);

ALTER TABLE ONLY stg.stg_wms_bay_hdr
    ADD CONSTRAINT wms_bay_hdr_pk PRIMARY KEY (wms_bay_id, wms_bay_ou);

ALTER TABLE ONLY stg.stg_wms_bin_exec_hdr
    ADD CONSTRAINT wms_bin_exec_hdr_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_exec_no, wms_bin_exec_ou);

ALTER TABLE ONLY stg.stg_wms_bin_exec_item_detail
    ADD CONSTRAINT wms_bin_exec_item_detail_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_exec_no, wms_bin_exec_lineno, wms_bin_ref_lineno, wms_bin_exec_ou);

ALTER TABLE ONLY stg.stg_wms_bin_exec_item_dtl
    ADD CONSTRAINT wms_bin_exec_item_dl_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_exec_no, wms_bin_exec_ou, wms_bin_pln_lineno);

ALTER TABLE ONLY stg.stg_wms_bin_plan_hdr
    ADD CONSTRAINT wms_bin_plan_hdr_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_pln_no, wms_bin_pln_ou);

ALTER TABLE ONLY stg.stg_wms_bin_plan_item_dtl
    ADD CONSTRAINT wms_bin_plan_item_dtl_pk PRIMARY KEY (wms_bin_loc_code, wms_bin_pln_no, wms_bin_pln_lineno, wms_bin_pln_ou);

ALTER TABLE ONLY stg.stg_wms_bin_type_hdr
    ADD CONSTRAINT wms_bin_type_hdr_pk PRIMARY KEY (wms_bin_typ_ou, wms_bin_typ_code, wms_bin_typ_loc_code);

ALTER TABLE ONLY stg.stg_wms_bin_type_storage_dtl
    ADD CONSTRAINT wms_bin_type_storage_dtl_pk PRIMARY KEY (wms_bin_typ_ou, wms_bin_typ_code, wms_bin_typ_loc_code, wms_bin_typ_lineno);

ALTER TABLE ONLY stg.stg_wms_component_met
    ADD CONSTRAINT wms_component_met_pk PRIMARY KEY (wms_componentname, wms_paramcategory, wms_paramtype, wms_paramcode, wms_paramdesc, wms_langid);

ALTER TABLE ONLY stg.stg_wms_consignee_hdr
    ADD CONSTRAINT wms_consignee_hdr_pk PRIMARY KEY (wms_consignee_id, wms_consignee_ou);

ALTER TABLE ONLY stg.stg_wms_consignor_hdr
    ADD CONSTRAINT wms_consignor_hdr_pk PRIMARY KEY (wms_consignor_id, wms_consignor_ou);

ALTER TABLE ONLY stg.stg_wms_contract_dtl_h
    ADD CONSTRAINT wms_contract_dtl_h_pk PRIMARY KEY (wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_amendno);

ALTER TABLE ONLY stg.stg_wms_contract_dtl
    ADD CONSTRAINT wms_contract_dtl_pk PRIMARY KEY (wms_cont_id, wms_cont_lineno, wms_cont_ou, wms_cont_tariff_id);

ALTER TABLE ONLY stg.stg_wms_contract_hdr_h
    ADD CONSTRAINT wms_contract_hdr_h_pk PRIMARY KEY (wms_cont_id, wms_cont_ou, wms_cont_amendno);

ALTER TABLE ONLY stg.stg_wms_contract_hdr
    ADD CONSTRAINT wms_contract_hdr_pk PRIMARY KEY (wms_cont_id, wms_cont_ou);

ALTER TABLE ONLY stg.stg_wms_contract_rev_leak_dtl
    ADD CONSTRAINT wms_contract_rev_leak_dtl_pk PRIMARY KEY (wms_cont_rev_lkge_ou, wms_cont_rev_lkge_line_no);

ALTER TABLE ONLY stg.stg_wms_contract_transfer_inv_dtl
    ADD CONSTRAINT wms_contract_transfer_inv_dtl_pk PRIMARY KEY (wms_cont_transfer_inv_no, wms_cont_transfer_lineno, wms_cont_transfer_inv_ou);

ALTER TABLE ONLY stg.stg_wms_contract_transfer_inv_hdr
    ADD CONSTRAINT wms_contract_transfer_inv_hdr_pk PRIMARY KEY (wms_cont_transfer_inv_no, wms_cont_transfer_inv_ou);

ALTER TABLE ONLY stg.stg_wms_cust_attribute_dtl
    ADD CONSTRAINT wms_cust_attribute_dtl_pk PRIMARY KEY (wms_cust_attr_cust_code, wms_cust_attr_lineno, wms_cust_attr_ou);

ALTER TABLE ONLY stg.stg_wms_customer_hdr
    ADD CONSTRAINT wms_customer_hdr_pk PRIMARY KEY (wms_customer_id, wms_customer_ou);

ALTER TABLE ONLY stg.stg_wms_customer_location_division_dtl
    ADD CONSTRAINT wms_customer_location_division_dtl_pk PRIMARY KEY (wms_customer_id, wms_customer_ou, wms_customer_lineno);

ALTER TABLE ONLY stg.stg_wms_customer_portal_user_dtl
    ADD CONSTRAINT wms_customer_portal_user_dtl_pk PRIMARY KEY (wms_customer_id, wms_customer_ou, wms_customer_lineno);

ALTER TABLE ONLY stg.stg_wms_disp_cons_dtl
    ADD CONSTRAINT wms_disp_cons_dtl_pk PRIMARY KEY (wms_disp_location, wms_disp_ou, wms_disp_lineno);

ALTER TABLE ONLY stg.stg_wms_disp_load_dtl
    ADD CONSTRAINT wms_disp_load_dtl_pk PRIMARY KEY (wms_disp_location, wms_disp_ou, wms_disp_lineno);

ALTER TABLE ONLY stg.stg_wms_disp_rules_hdr
    ADD CONSTRAINT wms_disp_rules_hdr_pk PRIMARY KEY (wms_disp_location, wms_disp_ou);

ALTER TABLE ONLY stg.stg_wms_dispatch_dtl
    ADD CONSTRAINT wms_dispatch_dtl_pk PRIMARY KEY (wms_dispatch_loc_code, wms_dispatch_ld_sheet_no, wms_dispatch_ld_sheet_ou, wms_dispatch_lineno);

ALTER TABLE ONLY stg.stg_wms_dispatch_hdr
    ADD CONSTRAINT wms_dispatch_hdr_pk PRIMARY KEY (wms_dispatch_loc_code, wms_dispatch_ld_sheet_no, wms_dispatch_ld_sheet_ou);

ALTER TABLE ONLY stg.stg_wms_div_division_hdr
    ADD CONSTRAINT wms_div_division_hdr_pk PRIMARY KEY (wms_div_ou, wms_div_code);

ALTER TABLE ONLY stg.stg_wms_div_location_list_dtl
    ADD CONSTRAINT wms_div_location_list_dtl_pk PRIMARY KEY (wms_div_ou, wms_div_code, wms_div_lineno);

ALTER TABLE ONLY stg.stg_wms_div_prop_hdr
    ADD CONSTRAINT wms_div_prop_hdr_pk PRIMARY KEY (wms_div_code, wms_div_ou);

ALTER TABLE ONLY stg.stg_wms_draft_bill_acc_tariff_dtl
    ADD CONSTRAINT wms_draft_bill_acc_tariff_dtl_pk PRIMARY KEY (wms_draft_bill_ou, wms_draft_bill_line_no, wms_draft_bill_tran_type);

ALTER TABLE ONLY stg.stg_wms_draft_bill_dtl
    ADD CONSTRAINT wms_draft_bill_dtl_pk PRIMARY KEY (wms_draft_bill_no, wms_draft_bill_ou, wms_draft_bill_lineno);

ALTER TABLE ONLY stg.stg_wms_draft_bill_exec_dtl
    ADD CONSTRAINT wms_draft_bill_exec_dtl_pk1 PRIMARY KEY (wms_exec_loc_code, wms_exec_ou, wms_exec_no, wms_exec_stage, wms_exec_line_no);

ALTER TABLE ONLY stg.stg_wms_draft_bill_hdr
    ADD CONSTRAINT wms_draft_bill_hdr_pk PRIMARY KEY (wms_draft_bill_no, wms_draft_bill_ou);

ALTER TABLE ONLY stg.stg_wms_draft_bill_supplier_contract_dtl
    ADD CONSTRAINT wms_draft_bill_supplier_contract_dtl_pk PRIMARY KEY (wms_draft_bill_ou, wms_draft_bill_location, wms_draft_bill_division, wms_draft_bill_tran_type, wms_draft_bill_ref_doc_no, wms_draft_bill_ref_doc_type, wms_draft_bill_vendor_id, wms_draft_bill_resource_type);

ALTER TABLE ONLY stg.stg_wms_employee_hdr
    ADD CONSTRAINT wms_employee_hdr_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou);

ALTER TABLE ONLY stg.stg_wms_employee_license_dtl
    ADD CONSTRAINT wms_employee_license_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);

ALTER TABLE ONLY stg.stg_wms_employee_location_dtl
    ADD CONSTRAINT wms_employee_location_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);

ALTER TABLE ONLY stg.stg_wms_employee_skills_dtl
    ADD CONSTRAINT wms_employee_skills_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);

ALTER TABLE ONLY stg.stg_wms_employee_type_dtl
    ADD CONSTRAINT wms_employee_type_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);

ALTER TABLE ONLY stg.stg_wms_employee_unav_dates_dtl
    ADD CONSTRAINT wms_employee_unav_dates_dtl_pk PRIMARY KEY (wms_emp_employee_code, wms_emp_ou, wms_emp_lineno);

ALTER TABLE ONLY stg.stg_wms_eqp_grp_dtl
    ADD CONSTRAINT wms_eqp_grp_dtl_pk PRIMARY KEY (wms_egrp_ou, wms_egrp_id, wms_egrp_lineno);

ALTER TABLE ONLY stg.stg_wms_eqp_grp_hdr
    ADD CONSTRAINT wms_eqp_grp_hdr_pk PRIMARY KEY (wms_egrp_ou, wms_egrp_id);

ALTER TABLE ONLY stg.stg_wms_equipment_geo_info_dtl
    ADD CONSTRAINT wms_equipment_geo_info_dtl_pk PRIMARY KEY (wms_eqp_ou, wms_eqp_equipment_id, wms_eqp_line_no);

ALTER TABLE ONLY stg.stg_wms_equipment_hdr
    ADD CONSTRAINT wms_equipment_hdr_pk PRIMARY KEY (wms_eqp_ou, wms_eqp_equipment_id);

ALTER TABLE ONLY stg.stg_wms_ex_item_hdr
    ADD CONSTRAINT wms_ex_item_hdr_pk PRIMARY KEY (wms_ex_itm_ou, wms_ex_itm_code, wms_ex_itm_loc_code);

ALTER TABLE ONLY stg.stg_wms_ex_itm_fix_bin_dtl
    ADD CONSTRAINT wms_ex_itm_fix_bin_dtl_pk PRIMARY KEY (wms_ex_itm_ou, wms_ex_itm_code, wms_ex_itm_loc_code, wms_ex_itm_line_no);

ALTER TABLE ONLY stg.stg_wms_ex_itm_vas_dtl
    ADD CONSTRAINT wms_ex_itm_vas_dtl_pk PRIMARY KEY (wms_ex_itm_ou, wms_ex_itm_code, wms_ex_itm_loc_code, wms_ex_itm_line_no);

ALTER TABLE ONLY stg.stg_wms_ex_itm_zone_check_dtl
    ADD CONSTRAINT wms_ex_itm_zone_check_dtl_pk PRIMARY KEY (wms_ex_zn_ou, wms_ex_zn_itm_code, wms_ex_zn_loc_code, wms_ex_zn_line_no);

ALTER TABLE ONLY stg.stg_wms_financial_dimension_odo_dtl
    ADD CONSTRAINT wms_financial_dimension_odo_dtl_pk PRIMARY KEY (wms_fin_dim_location, wms_fin_dim_order_no, wms_fin_dim_order_ou);

ALTER TABLE ONLY stg.stg_wms_gate_emp_equip_map_dtl
    ADD CONSTRAINT wms_gate_emp_equip_map_dtl_pk PRIMARY KEY (wms_gate_loc_code, wms_gate_ou, wms_gate_lineno);

ALTER TABLE ONLY stg.stg_wms_gate_exception_dtl
    ADD CONSTRAINT wms_gate_exception_dtl_pk PRIMARY KEY (wms_gate_exc_loc_code, wms_gate_exc_ou, wms_gate_exc_lineno, wms_gate_exc_shift_seqno);

ALTER TABLE ONLY stg.stg_wms_gate_exec_dtl
    ADD CONSTRAINT wms_gate_exec_dtl_pk PRIMARY KEY (wms_gate_loc_code, wms_gate_exec_no, wms_gate_exec_ou);

ALTER TABLE ONLY stg.stg_wms_gate_operation_dtl
    ADD CONSTRAINT wms_gate_operation_dtl_pk PRIMARY KEY (wms_gate_opr_loc_code, wms_gate_opr_ou, wms_gate_opr_lineno);

ALTER TABLE ONLY stg.stg_wms_gate_plan_dtl
    ADD CONSTRAINT wms_gate_plan_dtl_pk PRIMARY KEY (wms_gate_loc_code, wms_gate_pln_no, wms_gate_pln_ou);

ALTER TABLE ONLY stg.stg_wms_geo_postal_dtl
    ADD CONSTRAINT wms_geo_city_dt_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_postal_code, wms_geo_postal_ou, wms_geo_postal_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_city_dtl
    ADD CONSTRAINT wms_geo_city_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_city_ou, wms_geo_city_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_country_dtl
    ADD CONSTRAINT wms_geo_country_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_country_ou, wms_geo_country_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_region_dtl
    ADD CONSTRAINT wms_geo_region_dtl_pk PRIMARY KEY (wms_geo_reg, wms_geo_reg_ou, wms_geo_reg_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_region_hdr
    ADD CONSTRAINT wms_geo_region_hdr_pk PRIMARY KEY (wms_geo_reg, wms_geo_reg_ou);

ALTER TABLE ONLY stg.stg_wms_geo_state_dtl
    ADD CONSTRAINT wms_geo_state_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_state_ou, wms_geo_state_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_sub_zone_dtl
    ADD CONSTRAINT wms_geo_sub_zone_dtl_pk PRIMARY KEY (wms_geo_sub_zone, wms_geo_sub_zone_ou, wms_geo_sub_zone_lineno, wms_geo_sub_zone_postcode);

ALTER TABLE ONLY stg.stg_wms_geo_sub_zone_hdr
    ADD CONSTRAINT wms_geo_sub_zone_hdr_pk PRIMARY KEY (wms_geo_sub_zone, wms_geo_sub_zone_ou);

ALTER TABLE ONLY stg.stg_wms_geo_suburb_dtl
    ADD CONSTRAINT wms_geo_suburb_dtl_pk PRIMARY KEY (wms_geo_country_code, wms_geo_state_code, wms_geo_city_code, wms_geo_postal_code, wms_geo_suburb_code, wms_geo_suburb_ou, wms_geo_suburb_lineno);

ALTER TABLE ONLY stg.stg_wms_geo_zone_dtl
    ADD CONSTRAINT wms_geo_zone_dtl_pkey PRIMARY KEY (wms_geo_zone, wms_geo_zone_ou, wms_geo_zone_lineno, wms_geo_zone_type_code);

ALTER TABLE ONLY stg.stg_wms_geo_zone_hdr
    ADD CONSTRAINT wms_geo_zone_hdr_pkey PRIMARY KEY (wms_geo_zone, wms_geo_zone_ou);

ALTER TABLE ONLY stg.stg_wms_goods_issue_dtl
    ADD CONSTRAINT wms_goods_issue_dtl_pk PRIMARY KEY (wms_gi_no, wms_gi_ou, wms_gi_loc_code, wms_gi_outbound_ord_no, wms_gi_line_no);

ALTER TABLE ONLY stg.stg_wms_gr_emp_equip_map_dtl
    ADD CONSTRAINT wms_gr_emp_equip_map_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_ou, wms_gr_lineno);

ALTER TABLE ONLY stg.stg_wms_gr_exec_dtl
    ADD CONSTRAINT wms_gr_exec_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou);

ALTER TABLE ONLY stg.stg_wms_gr_exec_item_dtl
    ADD CONSTRAINT wms_gr_exec_item_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_lineno);

ALTER TABLE ONLY stg.stg_wms_gr_exec_reset_dtl
    ADD CONSTRAINT wms_gr_exec_reset_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_ou, wms_gr_exec_no, wms_gr_lineno);

ALTER TABLE ONLY stg.stg_wms_gr_exec_serial_dtl
    ADD CONSTRAINT wms_gr_exec_serial_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_lineno, wms_gr_serial_no);

ALTER TABLE ONLY stg.stg_wms_gr_exec_thu_hdr
    ADD CONSTRAINT wms_gr_exec_thu_hdr_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_thu_sno, wms_gr_thu_su, wms_gr_thu_uid_ser_no);

ALTER TABLE ONLY stg.stg_wms_gr_exec_thu_lot_dtl
    ADD CONSTRAINT wms_gr_exec_thu_lot_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_exec_no, wms_gr_exec_ou, wms_gr_thu_id, wms_gr_lot_thu_sno, wms_gr_line_no, wms_gr_thu_uid_sr_no, wms_gr_thu_lot_su);

ALTER TABLE ONLY stg.stg_wms_gr_plan_dtl
    ADD CONSTRAINT wms_gr_plan_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou);

ALTER TABLE ONLY stg.stg_wms_gr_po_item_dtl
    ADD CONSTRAINT wms_gr_po_item_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno);

ALTER TABLE ONLY stg.stg_wms_gr_rule_hdr
    ADD CONSTRAINT wms_gr_rule_hdr_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_ou);

ALTER TABLE ONLY stg.stg_wms_gr_thu_dtl
    ADD CONSTRAINT wms_gr_thu_dtl_pk PRIMARY KEY (wms_gr_loc_code, wms_gr_pln_no, wms_gr_pln_ou, wms_gr_lineno);

ALTER TABLE ONLY stg.stg_wms_hr_internal_order_dtl
    ADD CONSTRAINT wms_hr_internal_order_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_hr_internal_order_hdr
    ADD CONSTRAINT wms_hr_internal_order_hdr_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_inbound_header_h
    ADD CONSTRAINT wms_inbound_header_h_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_ou, wms_inb_amendno);

ALTER TABLE ONLY stg.stg_wms_inbound_header
    ADD CONSTRAINT wms_inbound_header_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_ou);

ALTER TABLE ONLY stg.stg_wms_inbound_item_detail_h
    ADD CONSTRAINT wms_inbound_item_detail_h_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_amendno);

ALTER TABLE ONLY stg.stg_wms_inbound_item_detail
    ADD CONSTRAINT wms_inbound_item_detail_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou);

ALTER TABLE ONLY stg.stg_wms_inbound_pln_track_dtl
    ADD CONSTRAINT wms_inbound_pln_track_dtl_pk PRIMARY KEY (wms_pln_lineno, wms_pln_ou);

ALTER TABLE ONLY stg.stg_wms_inbound_sch_item_detail_h
    ADD CONSTRAINT wms_inbound_sch_item_detail_h_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou, wms_inb_amendno);

ALTER TABLE ONLY stg.stg_wms_inbound_sch_item_detail
    ADD CONSTRAINT wms_inbound_sch_item_detail_pk PRIMARY KEY (wms_inb_loc_code, wms_inb_orderno, wms_inb_lineno, wms_inb_ou);

ALTER TABLE ONLY stg.stg_wms_int_ord_bin_dtl
    ADD CONSTRAINT wms_int_ord_bin_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_int_ord_stk_accuracy_dtl
    ADD CONSTRAINT wms_int_ord_stk_accuracy_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_int_ord_stk_con_quantity_dtl
    ADD CONSTRAINT wms_int_ord_stk_con_quantity_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_int_ord_stk_con_status_dtl
    ADD CONSTRAINT wms_int_ord_stk_con_status_dtl_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_lineno, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_internal_order_hdr
    ADD CONSTRAINT wms_internal_order_hdr_pk PRIMARY KEY (wms_in_ord_location, wms_in_ord_no, wms_in_ord_ou);

ALTER TABLE ONLY stg.stg_wms_inv_profile_dtl
    ADD CONSTRAINT wms_inv_profile_dtl_pk PRIMARY KEY (wms_inv_prof_loc_code, wms_inv_prof_ou, wms_inv_prof_lineno);

ALTER TABLE ONLY stg.stg_wms_item_hdr
    ADD CONSTRAINT wms_item_hdr_pk PRIMARY KEY (wms_itm_ou, wms_itm_code);

ALTER TABLE ONLY stg.stg_wms_item_supplier_dtl
    ADD CONSTRAINT wms_item_supplier_dtl_pk PRIMARY KEY (wms_itm_ou, wms_itm_code, wms_itm_lineno);

ALTER TABLE ONLY stg.stg_wms_leg_hdr
    ADD CONSTRAINT wms_leg_mst_hdr_pk PRIMARY KEY (wms_leg_leg_id, wms_leg_ou);

ALTER TABLE ONLY stg.stg_wms_lnm_lh_lotnohistory
    ADD CONSTRAINT wms_lnm_lh_lotnohistory_pk PRIMARY KEY (lh_seqno_unique);

ALTER TABLE ONLY stg.stg_wms_lnm_lm_lotmaster
    ADD CONSTRAINT wms_lnm_lm_lotmaster_pk PRIMARY KEY (lm_lotno_ou, lm_wh_code, lm_item_code, lm_lot_no, lm_serial_no, lm_trans_no);

ALTER TABLE ONLY stg.stg_wms_load_rule_hdr
    ADD CONSTRAINT wms_load_rule_hdr_pk PRIMARY KEY (wms_load_rule_ou, wms_load_rule_location);

ALTER TABLE ONLY stg.stg_wms_loading_exec_dtl
    ADD CONSTRAINT wms_loading_exec_dtl_pk PRIMARY KEY (wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou, wms_loading_lineno);

ALTER TABLE ONLY stg.stg_wms_loading_exec_hdr
    ADD CONSTRAINT wms_loading_exec_hdr_pk PRIMARY KEY (wms_loading_loc_code, wms_loading_exec_no, wms_loading_exec_ou);

ALTER TABLE ONLY stg.stg_wms_loading_plan_dtl
    ADD CONSTRAINT wms_loading_plan_dtl_pk PRIMARY KEY (wms_loading_loc_code, wms_loading_ld_sheet_no, wms_loading_ld_sheet_ou, wms_loading_ld_sheet_lineno);

ALTER TABLE ONLY stg.stg_wms_loc_customer_mapping_dtl
    ADD CONSTRAINT wms_loc_customer_mapping_dtl_pk PRIMARY KEY (wms_loc_ou, wms_loc_code, wms_loc_lineno);

ALTER TABLE ONLY stg.stg_wms_loc_exception_dtl
    ADD CONSTRAINT wms_loc_exception_dtl_pk PRIMARY KEY (wms_loc_exc_loc_code, wms_loc_exc_ou, wms_loc_exc_lineno, wms_loc_exc_shift_seqno);

ALTER TABLE ONLY stg.stg_wms_loc_location_geo_dtl
    ADD CONSTRAINT wms_loc_location_geo_dtl_pk PRIMARY KEY (wms_loc_ou, wms_loc_code, wms_loc_geo_lineno);

ALTER TABLE ONLY stg.stg_wms_loc_location_shift_dtl
    ADD CONSTRAINT wms_loc_location_shift_dtl_pk PRIMARY KEY (wms_loc_ou, wms_loc_code, wms_loc_shft_lineno);

ALTER TABLE ONLY stg.stg_wms_loc_operation_dtl
    ADD CONSTRAINT wms_loc_operation_dtl_pk PRIMARY KEY (wms_loc_opr_loc_code, wms_loc_opr_ou, wms_loc_opr_lineno);

ALTER TABLE ONLY stg.stg_wms_loc_prop_hdr
    ADD CONSTRAINT wms_loc_prop_hdr_pk PRIMARY KEY (wms_loc_pop_code, wms_loc_pop_ou);

ALTER TABLE ONLY stg.stg_wms_loc_user_mapping_dtl
    ADD CONSTRAINT wms_loc_user_mapping_dtl_pk PRIMARY KEY (wms_loc_ou, wms_loc_code, wms_loc_lineno);

ALTER TABLE ONLY stg.stg_wms_mapnt_mapnotypeno
    ADD CONSTRAINT wms_mapnt_mapnotypeno_pk PRIMARY KEY (wms_mapnt_notypeno, wms_mapnt_function, wms_mapnt_transaction, wms_mapnt_tran_type, wms_mapnt_line_no, wms_mapnt_ou);

ALTER TABLE ONLY stg.stg_wms_outbound_doc_detail
    ADD CONSTRAINT wms_oubound_doc_detail_pk PRIMARY KEY (wms_oub_doc_loc_code, wms_oub_outbound_ord, wms_oub_doc_lineno, wms_oub_doc_ou);

ALTER TABLE ONLY stg.stg_wms_outbound_header
    ADD CONSTRAINT wms_outbound_header_pkey PRIMARY KEY (wms_oub_ou, wms_oub_loc_code, wms_oub_outbound_ord);

ALTER TABLE ONLY stg.stg_wms_outbound_item_detail
    ADD CONSTRAINT wms_outbound_item_detail_pkey PRIMARY KEY (wms_oub_itm_loc_code, wms_oub_itm_ou, wms_oub_outbound_ord, wms_oub_itm_lineno);

ALTER TABLE ONLY stg.stg_wms_outbound_lot_ser_dtl
    ADD CONSTRAINT wms_outbound_lot_ser_dtl_pkey PRIMARY KEY (wms_oub_lotsl_loc_code, wms_oub_lotsl_ou, wms_oub_outbound_ord, wms_oub_lotsl_lineno);

ALTER TABLE ONLY stg.stg_wms_outbound_sch_dtl
    ADD CONSTRAINT wms_outbound_sch_dtl_pkey PRIMARY KEY (wms_oub_sch_loc_code, wms_oub_sch_ou, wms_oub_outbound_ord, wms_oub_sch_lineno, wms_oub_item_lineno);

ALTER TABLE ONLY stg.stg_wms_outbound_vas_hdr
    ADD CONSTRAINT wms_outbound_vas_hdr_pk PRIMARY KEY (wms_oub_loc_code, wms_oub_ou, wms_oub_outbound_ord, wms_oub_lineno);

ALTER TABLE ONLY stg.stg_wms_pack_emp_equip_map_dtl
    ADD CONSTRAINT wms_pack_emp_equip_map_dtl_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_ou, wms_pack_lineno);

ALTER TABLE ONLY stg.stg_wms_pack_exec_hdr
    ADD CONSTRAINT wms_pack_exec_hdr_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou);

ALTER TABLE ONLY stg.stg_wms_pack_exec_thu_hdr
    ADD CONSTRAINT wms_pack_exec_thu_hdr_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_exec_no, wms_pack_exec_ou, wms_pack_thu_id, wms_pack_thu_sr_no);

ALTER TABLE ONLY stg.stg_wms_pack_hdr
    ADD CONSTRAINT wms_pack_hdr_pk PRIMARY KEY (wms_pack_location, wms_pack_ou);

ALTER TABLE ONLY stg.stg_wms_pack_plan_dtl
    ADD CONSTRAINT wms_pack_plan_dtl_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_pln_no, wms_pack_pln_ou, wms_pack_lineno);

ALTER TABLE ONLY stg.stg_wms_pack_plan_hdr
    ADD CONSTRAINT wms_pack_plan_hdr_pk PRIMARY KEY (wms_pack_loc_code, wms_pack_pln_no, wms_pack_pln_ou);

ALTER TABLE ONLY stg.stg_wms_pack_storage_dtl
    ADD CONSTRAINT wms_pack_storage_dtl_pk PRIMARY KEY (wms_pack_location, wms_pack_ou, wms_pack_lineno);

ALTER TABLE ONLY stg.stg_wms_pick_emp_equip_map_dtl
    ADD CONSTRAINT wms_pick_emp_equip_map_dtl_pkey PRIMARY KEY (wms_pick_loc_code, wms_pick_ou, wms_pick_lineno);

ALTER TABLE ONLY stg.stg_wms_pick_rules_hdr
    ADD CONSTRAINT wms_pick_rules_hdr_pkey PRIMARY KEY (wms_pick_loc_code, wms_pick_ou);

ALTER TABLE ONLY stg.stg_wms_put_exec_item_dtl
    ADD CONSTRAINT wms_put_exec_item_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou, wms_pway_exec_lineno);

ALTER TABLE ONLY stg.stg_wms_put_exec_serial_dtl
    ADD CONSTRAINT wms_put_exec_serial_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou, wms_pway_lineno);

ALTER TABLE ONLY stg.stg_wms_put_plan_item_dtl
    ADD CONSTRAINT wms_put_plan_item_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);

ALTER TABLE ONLY stg.stg_wms_put_serial_dtl
    ADD CONSTRAINT wms_put_serial_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);

ALTER TABLE ONLY stg.stg_wms_putaway_bin_capacity_dtl
    ADD CONSTRAINT wms_putaway_bin_capacity_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou, wms_pway_lineno);

ALTER TABLE ONLY stg.stg_wms_putaway_condition_grp_dtl
    ADD CONSTRAINT wms_putaway_condition_grp_dtl_pk PRIMARY KEY (wms_pway_ou, wms_pway_loc_code, wms_pway_line_no);

ALTER TABLE ONLY stg.stg_wms_putaway_conditions_dtl
    ADD CONSTRAINT wms_putaway_conditions_dtl_pk PRIMARY KEY (wms_pway_ou, wms_pway_loc_code, wms_pway_line_no);

ALTER TABLE ONLY stg.stg_wms_putaway_emp_equip_map_dtl
    ADD CONSTRAINT wms_putaway_emp_equip_map_dtl_pk PRIMARY KEY (wms_putaway_loc_code, wms_putaway_ou, wms_putaway_lineno);

ALTER TABLE ONLY stg.stg_wms_putaway_exec_dtl
    ADD CONSTRAINT wms_putaway_exec_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_exec_no, wms_pway_exec_ou);

ALTER TABLE ONLY stg.stg_wms_putaway_mhe_dtl
    ADD CONSTRAINT wms_putaway_mhe_dtl_pk PRIMARY KEY (wms_putaway_mhe_loc_code, wms_putaway_mhe_ou, wms_putaway_mhe_lineno);

ALTER TABLE ONLY stg.stg_wms_putaway_plan_dtl
    ADD CONSTRAINT wms_putaway_plan_dtl_pk PRIMARY KEY (wms_pway_loc_code, wms_pway_pln_no, wms_pway_pln_ou);

ALTER TABLE ONLY stg.stg_wms_putaway_profile_dtl
    ADD CONSTRAINT wms_putaway_profile_dtl_pk PRIMARY KEY (wms_pway_ou, wms_pway_loc_code, wms_pway_line_no, wms_pway_congrp_seq_no);

ALTER TABLE ONLY stg.stg_wms_putaway_rule_hdr
    ADD CONSTRAINT wms_putaway_rule_hdr_pk PRIMARY KEY (wms_putaway_loc_code, wms_putaway_ou);

ALTER TABLE ONLY stg.stg_wms_putaway_zone_dtl
    ADD CONSTRAINT wms_putaway_zone_dtl_pk PRIMARY KEY (wms_putaway_zn_loc_code, wms_putaway_zn_ou, wms_putaway_zn_lineno);

ALTER TABLE ONLY stg.stg_wms_quick_code_master_met
    ADD CONSTRAINT wms_quick_code_master_met_pk PRIMARY KEY (wms_code_type, wms_code);

ALTER TABLE ONLY stg.stg_wms_quick_code_master
    ADD CONSTRAINT wms_quick_code_master_pk PRIMARY KEY (wms_code_ou, wms_code_type, wms_code);

ALTER TABLE ONLY stg.stg_wms_route_attribute_dtl
    ADD CONSTRAINT wms_route_attribute_dtl_pk PRIMARY KEY (wms_route_attr_route_id, wms_route_attr_ou, wms_route_attr_lineno);

ALTER TABLE ONLY stg.stg_wms_route_customer_prefernce_dtl
    ADD CONSTRAINT wms_route_customer_prefernce_dtl_pk PRIMARY KEY (wms_rou_route_id, wms_rou_custprf_ou, wms_rou_custprf_lineno);

ALTER TABLE ONLY stg.stg_wms_route_hdr
    ADD CONSTRAINT wms_route_hdr_pk PRIMARY KEY (wms_rou_route_id, wms_rou_ou);

ALTER TABLE ONLY stg.stg_wms_route_info_dtl
    ADD CONSTRAINT wms_route_info_dtl_pk PRIMARY KEY (wms_rou_route_id, wms_rou_info_ou, wms_rou_info_lineno);

ALTER TABLE ONLY stg.stg_wms_shp_point_cusmap_dtl
    ADD CONSTRAINT wms_shp_point_cusmap_dtl_pk PRIMARY KEY (wms_shp_pt_ou, wms_shp_pt_id, wms_shp_pt_lineno);

ALTER TABLE ONLY stg.stg_wms_shp_point_hdr
    ADD CONSTRAINT wms_shp_point_hdr_pk PRIMARY KEY (wms_shp_pt_ou, wms_shp_pt_id);

ALTER TABLE ONLY stg.stg_wms_shp_point_loc_div_dtl
    ADD CONSTRAINT wms_shp_point_loc_div_dtl_pk PRIMARY KEY (wms_shp_pt_ou, wms_shp_pt_id, wms_shp_pt_lineno);

ALTER TABLE ONLY stg.stg_wms_skill_dtl
    ADD CONSTRAINT wms_skill_dtl_pk PRIMARY KEY (wms_skl_ou, wms_skl_code, wms_skl_type);

ALTER TABLE ONLY stg.stg_wms_src_strat_bts_pway_dtl
    ADD CONSTRAINT wms_src_strat_bts_pway_dtl_pk PRIMARY KEY (wms_bts_ou, wms_bts_loc_code, wms_bts_lineno, wms_bts_bin_seqno);

ALTER TABLE ONLY stg.stg_wms_src_strategy_picking_dtl
    ADD CONSTRAINT wms_src_strategy_picking_dtl_pk PRIMARY KEY (wms_pic_ou, wms_pic_loc_code, wms_pic_lineno, wms_pic_su_seqno);

ALTER TABLE ONLY stg.stg_wms_sst_trans_map_dtl
    ADD CONSTRAINT wms_sst_trans_map_dtl_pk PRIMARY KEY (wms_stkstatus_code, wms_stkstatus_lineno, wms_stkstatus_ou);

ALTER TABLE ONLY stg.stg_wms_stage_def_mas
    ADD CONSTRAINT wms_stage_def_mas_pkey PRIMARY KEY (wms_stg_ou, wms_stg_code, wms_stg_location);

ALTER TABLE ONLY stg.stg_wms_stage_mas_dtl
    ADD CONSTRAINT wms_stage_mas_dtl_pk PRIMARY KEY (wms_stg_mas_ou, wms_stg_mas_id, wms_stg_mas_loc, wms_stg_line_no);

ALTER TABLE ONLY stg.stg_wms_stage_mas_hdr
    ADD CONSTRAINT wms_stage_mas_hdr_pk PRIMARY KEY (wms_stg_mas_ou, wms_stg_mas_id, wms_stg_mas_loc);

ALTER TABLE ONLY stg.stg_wms_stage_profile_hdr
    ADD CONSTRAINT wms_stage_profile_hdr_pk PRIMARY KEY (wms_stg_prof_code, wms_stg_prof_loc_code, wms_stg_prof_ou);

ALTER TABLE ONLY stg.stg_wms_stage_profile_inbound_dtl
    ADD CONSTRAINT wms_stage_profile_inbound_dtl_pk PRIMARY KEY (wms_stg_prof_code, wms_stg_prof_loc_code, wms_stg_prof_ou, wms_stg_prof_lineno);

ALTER TABLE ONLY stg.stg_wms_stage_profile_outbound_dtl
    ADD CONSTRAINT wms_stage_profile_outbound_dtl_pk PRIMARY KEY (wms_stg_prof_code, wms_stg_prof_loc_code, wms_stg_prof_ou, wms_stg_prof_lineno);

ALTER TABLE ONLY stg.stg_wms_stock_acc_assign_hdr
    ADD CONSTRAINT wms_stock_acc_assign_hdr_pk PRIMARY KEY (wms_stk_acc_loc_code, wms_stk_acc_exec_pln_no, wms_stk_acc_exec_pln_ou);

ALTER TABLE ONLY stg.stg_wms_stock_acc_exec_dtl
    ADD CONSTRAINT wms_stock_acc_exec_dtl_pk PRIMARY KEY (wms_stk_acc_loc_code, wms_stk_acc_exec_no, wms_stk_acc_exec_pln_ou, wms_stk_acc_lineno);

ALTER TABLE ONLY stg.stg_wms_stock_acc_exec_hdr
    ADD CONSTRAINT wms_stock_acc_exec_hdr_pk PRIMARY KEY (wms_stk_acc_loc_code, wms_stk_acc_exec_no, wms_stk_acc_exec_ou);

ALTER TABLE ONLY stg.stg_wms_stock_bin_history_dtl
    ADD CONSTRAINT wms_stock_bin_history_dtl_pk PRIMARY KEY (wms_stock_ou, wms_stock_date, wms_stock_location, wms_stock_zone, wms_stock_bin, wms_stock_item, wms_stock_thu_id, wms_stock_su);

ALTER TABLE ONLY stg.stg_wms_stock_conversion_dtl
    ADD CONSTRAINT wms_stock_conversion_dtl_pk PRIMARY KEY (wms_stk_con_loc_code, wms_stk_con_proposal_no, wms_stk_con_proposal_ou, wms_stk_con_lineno);

ALTER TABLE ONLY stg.stg_wms_stock_conversion_hdr
    ADD CONSTRAINT wms_stock_conversion_hdr_pk PRIMARY KEY (wms_stk_con_loc_code, wms_stk_con_proposal_no, wms_stk_con_proposal_ou);

ALTER TABLE ONLY stg.stg_wms_stock_inprocess_tracking_serial_dtl
    ADD CONSTRAINT wms_stock_inprocess_tracking_serial_dtl_pk PRIMARY KEY (wms_stk_loc_code, wms_stk_ou, wms_stk_serial_line_no);

ALTER TABLE ONLY stg.stg_wms_stock_item_tracking_gr_load_dtl
    ADD CONSTRAINT wms_stock_item_tracking_gr_load_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_customer, wms_stk_date, wms_stk_uid_serial_no, wms_stk_lot_no, wms_stk_pack_thu_serial_no);

ALTER TABLE ONLY stg.stg_wms_stock_lot_tracking_daywise_dtl
    ADD CONSTRAINT wms_stock_lot_tracking_daywise_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_item, wms_stk_customer, wms_stk_date, wms_stk_lot_no, wms_stk_stock_status);

ALTER TABLE ONLY stg.stg_wms_stock_lot_tracking_dtl
    ADD CONSTRAINT wms_stock_lot_tracking_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_item, wms_stk_customer, wms_stk_date, wms_stk_lot_no);

ALTER TABLE ONLY stg.stg_wms_stock_rejected_dtl
    ADD CONSTRAINT wms_stock_rejected_dtl_pk PRIMARY KEY (wms_rejstk_line_no);

ALTER TABLE ONLY stg.stg_wms_stock_su_bal_dtl
    ADD CONSTRAINT wms_stock_su_bal_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_customer, wms_stk_date, wms_stk_su);

ALTER TABLE ONLY stg.stg_wms_stock_uid_item_tracking_dtl
    ADD CONSTRAINT wms_stock_uid_item_tracking_dtl_pk PRIMARY KEY (wms_stk_ou, wms_stk_location, wms_stk_item, wms_stk_customer, wms_stk_date, wms_stk_uid_serial_no, wms_stk_lot_no);

ALTER TABLE ONLY stg.stg_wms_stock_uid_tracking_dtl
    ADD CONSTRAINT wms_stock_uid_tracking_dtl_pk PRIMARY KEY (wms_stk_location, wms_stk_zone, wms_stk_bin, wms_stk_bin_type, wms_stk_staging_id, wms_stk_stage, wms_stk_customer, wms_stk_uid_serial_no, wms_stk_thu_id, wms_stk_su, wms_stk_from_date);

ALTER TABLE ONLY stg.stg_wms_stockbal_lot
    ADD CONSTRAINT wms_stockbal_lot_pk PRIMARY KEY (sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_stock_status);

ALTER TABLE ONLY stg.stg_wms_stockbal_serial
    ADD CONSTRAINT wms_stockbal_serial_pk PRIMARY KEY (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no);

ALTER TABLE ONLY stg.stg_wms_stockbal_su_lot
    ADD CONSTRAINT wms_stockbal_su_lot_pk PRIMARY KEY (sbl_wh_code, sbl_ouinstid, sbl_item_code, sbl_lot_no, sbl_zone, sbl_bin, sbl_su, sbl_stock_status, sbl_su_serial_no, sbl_thu_serial_no, sbl_su_serial_no2);

ALTER TABLE ONLY stg.stg_wms_stockbal_su_serial
    ADD CONSTRAINT wms_stockbal_su_serial_pk PRIMARY KEY (sbs_wh_code, sbs_ouinstid, sbs_item_code, sbs_sr_no, sbs_zone, sbs_bin, sbs_stock_status, sbs_lot_no, sbs_su_serial_no, sbs_thu_serial_no);

ALTER TABLE ONLY stg.stg_wms_tariff_geo_hdr
    ADD CONSTRAINT wms_tariff_geo_hdr_pk PRIMARY KEY (wms_tr_geo_id, wms_tr_geo_ou);

ALTER TABLE ONLY stg.stg_wms_tariff_revision_hdr
    ADD CONSTRAINT wms_tariff_revision_hdr_pk PRIMARY KEY (wms_tf_rev_validity_id, wms_tf_rev_ou);

ALTER TABLE ONLY stg.stg_wms_tariff_service_hdr
    ADD CONSTRAINT wms_tariff_service_hdr_pk PRIMARY KEY (wms_tf_ser_id, wms_tf_ser_ou);

ALTER TABLE ONLY stg.stg_wms_tariff_transport_hdr
    ADD CONSTRAINT wms_tariff_transport_hdr_pk PRIMARY KEY (wms_tf_tp_id, wms_tf_tp_ou);

ALTER TABLE ONLY stg.stg_wms_tariff_transport_rule_dtl
    ADD CONSTRAINT wms_tariff_transport_rule_dtl_pk PRIMARY KEY (wms_tf_tp_id, wms_tf_tp_ou, wms_tf_tp_lineno);

ALTER TABLE ONLY stg.stg_wms_tariff_type_master
    ADD CONSTRAINT wms_tariff_type_master_pk PRIMARY KEY (wms_tar_lineno, wms_tar_ou);

ALTER TABLE ONLY stg.stg_wms_tariff_type_met
    ADD CONSTRAINT wms_tariff_type_met_pk PRIMARY KEY (wms_tf_grp_code, wms_tf_type_code);

ALTER TABLE ONLY stg.stg_wms_thu_hdr
    ADD CONSTRAINT wms_thu_hdr_pk PRIMARY KEY (wms_thu_id, wms_thu_ou);

ALTER TABLE ONLY stg.stg_wms_thu_item_mapping_dtl
    ADD CONSTRAINT wms_thu_item_mapping_dtl_pk PRIMARY KEY (wms_thu_loc_code, wms_thu_ou, wms_thu_serial_no, wms_thu_id, wms_thu_item, wms_thu_lot_no, wms_thu_itm_serial_no);

ALTER TABLE ONLY stg.stg_wms_timezone_details_met
    ADD CONSTRAINT wms_timezone_details_met_pk PRIMARY KEY (wms_time_zone_id, wms_time_zone_display_name);

ALTER TABLE ONLY stg.stg_wms_transient_thu_log
    ADD CONSTRAINT wms_trans_thu_dtl_pk PRIMARY KEY (wms_trans_thu_loc_code, wms_trans_thu_ou, wms_trans_thu_lineno);

ALTER TABLE ONLY stg.stg_wms_veh_emp_dtl
    ADD CONSTRAINT wms_veh_emp_dtl_pk PRIMARY KEY (wms_veh_ou, wms_veh_id, wms_veh_line_no);

ALTER TABLE ONLY stg.stg_wms_veh_maint_dtl
    ADD CONSTRAINT wms_veh_maint_dtl_pk PRIMARY KEY (wms_veh_maint_ou, wms_veh_maint_id, wms_veh_maint_line);

ALTER TABLE ONLY stg.stg_wms_veh_mas_hdr
    ADD CONSTRAINT wms_veh_mas_hdr_pk PRIMARY KEY (wms_veh_ou, wms_veh_id);

ALTER TABLE ONLY stg.stg_wms_veh_thucapmap_dtl
    ADD CONSTRAINT wms_veh_thucapmap_dtl_pk PRIMARY KEY (wms_veh_ou, wms_veh_id, wms_veh_line_no);

ALTER TABLE ONLY stg.stg_wms_vendor_attribute_dtl
    ADD CONSTRAINT wms_vendor_attribute_dtl_pk PRIMARY KEY (wms_vendor_id, wms_vendor_ou, wms_vendor_lineno);

ALTER TABLE ONLY stg.stg_wms_vendor_hdr
    ADD CONSTRAINT wms_vendor_hdr_pk PRIMARY KEY (wms_vendor_id, wms_vendor_ou);

ALTER TABLE ONLY stg.stg_wms_vendor_holidays_dtl
    ADD CONSTRAINT wms_vendor_holidays_dtl_pk PRIMARY KEY (wms_vendor_id, wms_vendor_ou, wms_vendor_lineno);

ALTER TABLE ONLY stg.stg_wms_vendor_location_division_dtl
    ADD CONSTRAINT wms_vendor_location_division_dtl_pk PRIMARY KEY (wms_vendor_id, wms_vendor_ou, wms_vendor_lineno);

ALTER TABLE ONLY stg.stg_wms_virtual_stockbal_lot
    ADD CONSTRAINT wms_virtual_stockbal_lot_pk PRIMARY KEY (sbl_wh_code, sbl_ouinstid, sbl_line_no);

ALTER TABLE ONLY stg.stg_wms_virtual_stockbal_su_lot
    ADD CONSTRAINT wms_virtual_stockbal_su_lot_pk PRIMARY KEY (sbl_wh_code, sbl_ouinstid, sbl_line_no);

ALTER TABLE ONLY stg.stg_wms_wave_hdr
    ADD CONSTRAINT wms_wave_hdr_pk PRIMARY KEY (wms_wave_loc_code, wms_wave_no, wms_wave_ou);

ALTER TABLE ONLY stg.stg_wms_wave_location_control
    ADD CONSTRAINT wms_wave_location_control_pk PRIMARY KEY (wms_wave_ou, wms_wave_loc_code);

ALTER TABLE ONLY stg.stg_wms_wave_operation_dtl
    ADD CONSTRAINT wms_wave_operation_dtl_pk PRIMARY KEY (wms_wave_opr_loc_code, wms_wave_opr_ou, wms_wave_opr_lineno);

ALTER TABLE ONLY stg.stg_wms_wave_rule_hdr
    ADD CONSTRAINT wms_wave_rule_hdr_pk PRIMARY KEY (wms_wave_loc_code, wms_wave_ou);

ALTER TABLE ONLY stg.stg_wms_yard_dtl
    ADD CONSTRAINT wms_yard_dtl_pk PRIMARY KEY (wms_yard_id, wms_yard_loc_code, wms_yard_ou, wms_yard_lineno);

ALTER TABLE ONLY stg.stg_wms_yard_hdr
    ADD CONSTRAINT wms_yard_hdr_pk PRIMARY KEY (wms_yard_id, wms_yard_loc_code, wms_yard_ou);

ALTER TABLE ONLY stg.stg_wms_zone_hdr
    ADD CONSTRAINT wms_zone_hdr_pk PRIMARY KEY (wms_zone_code, wms_zone_ou, wms_zone_loc_code);

ALTER TABLE ONLY stg.stg_wms_zone_profile_dtl
    ADD CONSTRAINT wms_zone_profile_dtl_pk PRIMARY KEY (wms_zone_prof_code, wms_zone_prof_loc_code, wms_zone_prof_ou, wms_zone_prof_lineno, wms_zone_prof_stor_seq);
ALTER TABLE ONLY dwh.d_hht_master
    ADD CONSTRAINT d_hht_master_hht_loc_key_fkey FOREIGN KEY (hht_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.d_outboundlocshiftdetail
    ADD CONSTRAINT d_outboundlocshiftdetail_obd_loc_sht_key_fkey FOREIGN KEY (obd_loc_sht_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.d_wmsoutboundtat
    ADD CONSTRAINT d_wmsoutboundtat_wms_loc_key_fkey FOREIGN KEY (wms_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_allc_itm_hdr_key_fkey FOREIGN KEY (allc_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_allc_thu_key_fkey FOREIGN KEY (allc_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_allc_wh_key_fkey FOREIGN KEY (allc_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_allocitemdetailshistory
    ADD CONSTRAINT f_allocitemdetailshistory_allc_zone_key_fkey FOREIGN KEY (allc_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_aplanacqproposalhdr
    ADD CONSTRAINT f_aplanacqproposalhdr_pln_pro_curr_key_fkey FOREIGN KEY (pln_pro_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_asnadditionaldetail
    ADD CONSTRAINT f_asnadditionaldetail_asn_pop_loc_key_fkey FOREIGN KEY (asn_pop_loc_key) REFERENCES dwh.d_location(loc_key) DEFERRABLE INITIALLY DEFERRED;

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_itm_hdr_key_fkey FOREIGN KEY (asn_dtl_hst_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_loc_key_fkey FOREIGN KEY (asn_dtl_hst_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asndetailhistory
    ADD CONSTRAINT f_asndetailhistory_asn_dtl_hst_thu_key_fkey FOREIGN KEY (asn_dtl_hst_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_itm_hdr_key_fkey FOREIGN KEY (asn_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_loc_key_fkey FOREIGN KEY (asn_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_thu_key_fkey FOREIGN KEY (asn_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_asndetails
    ADD CONSTRAINT f_asndetails_asn_dtl_uom_key_fkey FOREIGN KEY (asn_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_cust_key_fkey FOREIGN KEY (asn_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_date_key_fkey FOREIGN KEY (asn_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_loc_key_fkey FOREIGN KEY (asn_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_asnheader
    ADD CONSTRAINT f_asnheader_asn_supp_key_fkey FOREIGN KEY (asn_supp_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_customer_key_fkey FOREIGN KEY (asn_hdr_hst_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_datekey_fkey FOREIGN KEY (asn_hdr_hst_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_asnheaderhistory
    ADD CONSTRAINT f_asnheaderhistory_asn_hdr_hst_loc_key_fkey FOREIGN KEY (asn_hdr_hst_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bindetails
    ADD CONSTRAINT f_bindetails_bin_zone_key_fkey FOREIGN KEY (bin_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_hdr_key_fkey FOREIGN KEY (bin_exec_hdr_key) REFERENCES dwh.f_binexechdr(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_itm_hdr_key_fkey FOREIGN KEY (bin_exec_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_loc_key_fkey FOREIGN KEY (bin_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binexecdetail
    ADD CONSTRAINT f_binexecdetail_bin_exec_thu_key_fkey FOREIGN KEY (bin_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_date_key_fkey FOREIGN KEY (bin_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_emp_hdr_key_fkey FOREIGN KEY (bin_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_binexechdr
    ADD CONSTRAINT f_binexechdr_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_hdr_key_fkey FOREIGN KEY (bin_hdr_key) REFERENCES dwh.f_binexechdr(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_itm_hdr_key_fkey FOREIGN KEY (bin_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binexecitemdetail
    ADD CONSTRAINT f_binexecitemdetail_bin_thu_key_fkey FOREIGN KEY (bin_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_bin_hdr_key_fkey FOREIGN KEY (bin_hdr_key) REFERENCES dwh.f_binplanheader(bin_hdr_key);

ALTER TABLE ONLY dwh.f_binplandetails
    ADD CONSTRAINT f_binplandetails_bin_loc_dl_key_fkey FOREIGN KEY (bin_loc_dl_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_binplanheader
    ADD CONSTRAINT f_binplanheader_bin_loc_key_fkey FOREIGN KEY (bin_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_curr_key_fkey FOREIGN KEY (br_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_customer_key_fkey FOREIGN KEY (br_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_loc_key_fkey FOREIGN KEY (br_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_bookingrequest
    ADD CONSTRAINT f_bookingrequest_br_rou_key_fkey FOREIGN KEY (br_rou_key) REFERENCES dwh.d_route(rou_key);

ALTER TABLE ONLY dwh.f_bookingrequestreasonhistory
    ADD CONSTRAINT f_bookingrequestreasonhistory_br_hdr_key_fkey FOREIGN KEY (br_hdr_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentconsigneedetail
    ADD CONSTRAINT f_brconsignmentconsigneedetail_brccd_consignee_hdr_key_fkey FOREIGN KEY (brccd_consignee_hdr_key) REFERENCES dwh.d_consignee(consignee_hdr_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_brcd_curr_key_fkey FOREIGN KEY (brcd_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_brconsignmentdetail
    ADD CONSTRAINT f_brconsignmentdetail_brcd_thu_key_fkey FOREIGN KEY (brcd_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_brconsignmentskudetail
    ADD CONSTRAINT f_brconsignmentskudetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brconsignmentthuserialdetail
    ADD CONSTRAINT f_brconsignmentthuserialdetail_ctsd_br_key_fkey FOREIGN KEY (ctsd_br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brewaybilldetail
    ADD CONSTRAINT f_brewaybilldetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_brppd_cust_key_fkey FOREIGN KEY (brppd_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_brplanningprofiledetail
    ADD CONSTRAINT f_brplanningprofiledetail_brppd_loc_key_fkey FOREIGN KEY (brppd_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_brshipmentdetail
    ADD CONSTRAINT f_brshipmentdetail_brsd_br_key_fkey FOREIGN KEY (brsd_br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_brthucontractdetail
    ADD CONSTRAINT f_brthucontractdetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_cdcnarpostingsdtl
    ADD CONSTRAINT f_cdcnarpostingsdtl_cdcnarpostingsdtl_customer_key_fkey FOREIGN KEY (cdcnarpostingsdtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_customer_key_fkey FOREIGN KEY (cont_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_date_key_fkey FOREIGN KEY (cont_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_location_key_fkey FOREIGN KEY (cont_location_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_contractheader
    ADD CONSTRAINT f_contractheader_cont_vendor_key_fkey FOREIGN KEY (cont_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_curr_key_fkey FOREIGN KEY (cont_hdr_hst_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_customer_key_fkey FOREIGN KEY (cont_hdr_hst_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_datekey_fkey FOREIGN KEY (cont_hdr_hst_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_loc_key_fkey FOREIGN KEY (cont_hdr_hst_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_contractheaderhistory
    ADD CONSTRAINT f_contractheaderhistory_cont_hdr_hst_vendor_key_fkey FOREIGN KEY (cont_hdr_hst_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_contracttransferinvoicedetail
    ADD CONSTRAINT f_contracttransferinvoicedetail_cont_inv_hdr_key_fkey FOREIGN KEY (cont_inv_hdr_key) REFERENCES dwh.f_contracttransferinvoiceheader(cont_hdr_key);

ALTER TABLE ONLY dwh.f_deliverydelayreason
    ADD CONSTRAINT f_deliverydelayreason_wms_loc_key_fkey FOREIGN KEY (wms_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_con_customer_key_fkey FOREIGN KEY (disp_con_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchconsdetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_con_loc_key_fkey FOREIGN KEY (disp_con_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_load_customer_key_fkey FOREIGN KEY (disp_load_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchloaddetail
    ADD CONSTRAINT f_dispatchconsdetail_disp_load_loc_key_fkey FOREIGN KEY (disp_load_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_customer_key_fkey FOREIGN KEY (dispatch_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_loc_key_fkey FOREIGN KEY (dispatch_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_shp_pt_key_fkey FOREIGN KEY (dispatch_dtl_shp_pt_key) REFERENCES dwh.d_shippingpoint(shp_pt_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_dtl_thu_key_fkey FOREIGN KEY (dispatch_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_dispatchdetail
    ADD CONSTRAINT f_dispatchdetail_dispatch_hdr_key_fkey FOREIGN KEY (dispatch_hdr_key) REFERENCES dwh.f_dispatchheader(dispatch_hdr_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_consignee_hdr_key_fkey FOREIGN KEY (ddh_consignee_hdr_key) REFERENCES dwh.d_consignee(consignee_hdr_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_curr_key_fkey FOREIGN KEY (ddh_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_customer_key_fkey FOREIGN KEY (ddh_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_dispatchdocheader
    ADD CONSTRAINT f_dispatchdocheader_ddh_loc_key_fkey FOREIGN KEY (ddh_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchdocsignature
    ADD CONSTRAINT f_dispatchdocsignature_ddh_key_fkey FOREIGN KEY (ddh_key) REFERENCES dwh.f_dispatchdocheader(ddh_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuchilddetail
    ADD CONSTRAINT f_dispatchdocthuchilddetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ddh_key_fkey FOREIGN KEY (ddh_key) REFERENCES dwh.f_dispatchdocheader(ddh_key);

ALTER TABLE ONLY dwh.f_dispatchdocthudetail
    ADD CONSTRAINT f_dispatchdocthudetail_ddh_thu_key_fkey FOREIGN KEY (ddh_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuserialdetail
    ADD CONSTRAINT f_dispatchdocthuserialdetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

ALTER TABLE ONLY dwh.f_dispatchdocthuskudetail
    ADD CONSTRAINT f_dispatchdocthuskudetail_ddtd_key_fkey FOREIGN KEY (ddtd_key) REFERENCES dwh.f_dispatchdocthudetail(ddtd_key);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_dispatch_hdr_loc_key_fkey FOREIGN KEY (dispatch_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_dispatchheader
    ADD CONSTRAINT f_dispatchheader_dispatch_hdr_veh_key_fkey FOREIGN KEY (dispatch_hdr_veh_key) REFERENCES dwh.d_vehicle(veh_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_customer_key_fkey FOREIGN KEY (draft_bill_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_itm_hdr_key_fkey FOREIGN KEY (draft_bill_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_loc_key_fkey FOREIGN KEY (draft_bill_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_stg_mas_key_fkey FOREIGN KEY (draft_bill_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_draftbillexecdetail
    ADD CONSTRAINT f_draftbillexecdetail_draft_bill_thu_key_fkey FOREIGN KEY (draft_bill_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_curr_key_fkey FOREIGN KEY (draft_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_cust_key_fkey FOREIGN KEY (draft_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_draftbillheader
    ADD CONSTRAINT f_draftbillheader_draft_loc_key_fkey FOREIGN KEY (draft_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_draftbillsuppliercontractdetail
    ADD CONSTRAINT f_draftbillsuppliercontractdetail_draft_bill_location_key_fkey FOREIGN KEY (draft_bill_location_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_execthudetail
    ADD CONSTRAINT f_execthudetail_plepd_trip_exe_pln_dtl_key_fkey FOREIGN KEY (plepd_trip_exe_pln_dtl_key) REFERENCES dwh.f_tripexecutionplandetail(plepd_trip_exe_pln_dtl_key);

ALTER TABLE ONLY dwh.f_execthuserialdetail
    ADD CONSTRAINT f_execthuserialdetail_plepd_trip_exe_pln_dtl_key_fkey FOREIGN KEY (plepd_trip_exe_pln_dtl_key) REFERENCES dwh.f_tripexecutionplandetail(plepd_trip_exe_pln_dtl_key);

ALTER TABLE ONLY dwh.f_fbpaccountbalance
    ADD CONSTRAINT f_fbpaccountbalance_fbp_act_curr_key_fkey FOREIGN KEY (fbp_act_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_fbppostedtrndtl
    ADD CONSTRAINT f_fbppostedtrndtl_fbp_trn_company_key_fkey FOREIGN KEY (fbp_trn_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_fbppostedtrndtl
    ADD CONSTRAINT f_fbppostedtrndtl_fbp_trn_curr_key_fkey FOREIGN KEY (fbp_trn_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_fbpvoucherdtl
    ADD CONSTRAINT f_fbpvoucherdtl_fbp_company_key_fkey FOREIGN KEY (fbp_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_fbpvoucherhdr
    ADD CONSTRAINT f_fbpvoucherhdr_fbp_company_key_fkey FOREIGN KEY (fbp_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_emp_hdr_key_fkey FOREIGN KEY (gate_exec_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_eqp_key_fkey FOREIGN KEY (gate_exec_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_loc_key_fkey FOREIGN KEY (gate_exec_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_gateexecdetail
    ADD CONSTRAINT f_gateexecdetail_gate_exec_dtl_veh_key_fkey FOREIGN KEY (gate_exec_dtl_veh_key) REFERENCES dwh.d_vehicle(veh_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_eqp_key_fkey FOREIGN KEY (gate_pln_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_loc_key_fkey FOREIGN KEY (gate_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_gateplandetail
    ADD CONSTRAINT f_gateplandetail_gate_pln_dtl_veh_key_fkey FOREIGN KEY (gate_pln_dtl_veh_key) REFERENCES dwh.d_vehicle(veh_key);

ALTER TABLE ONLY dwh.f_goodsempequipmap
    ADD CONSTRAINT f_goodsempequipmap_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsissuedetails
    ADD CONSTRAINT f_goodsissuedetails_gi_loc_key_fkey FOREIGN KEY (gi_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_emp_hdr_key_fkey FOREIGN KEY (gr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsreceiptdetails
    ADD CONSTRAINT f_goodsreceiptdetails_gr_stg_mas_key_fkey FOREIGN KEY (gr_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_dtl_key_fkey FOREIGN KEY (gr_dtl_key) REFERENCES dwh.f_goodsreceiptdetails(gr_dtl_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (gr_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_loc_key_fkey FOREIGN KEY (gr_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_stg_mas_key_fkey FOREIGN KEY (gr_itm_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_thu_key_fkey FOREIGN KEY (gr_itm_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_goodsreceiptitemdetails
    ADD CONSTRAINT f_goodsreceiptitemdetails_gr_itm_dtl_uom_key_fkey FOREIGN KEY (gr_itm_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_cur_key_fkey FOREIGN KEY (gr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_emp_hdr_key_fkey FOREIGN KEY (gr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_grheader
    ADD CONSTRAINT f_grheader_gr_vendor_key_fkey FOREIGN KEY (gr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_gritemtrackingdetail
    ADD CONSTRAINT f_gritemtrackingdetail_gr_itm_tk_dtl_customer_keyfkey FOREIGN KEY (gr_itm_tk_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_gritemtrackingdetail
    ADD CONSTRAINT f_gritemtrackingdetail_gr_itm_tk_dtl_itm_hdr_key_fkey FOREIGN KEY (gr_itm_tk_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_gritemtrackingdetail
    ADD CONSTRAINT f_gritemtrackingdetail_gr_itm_tk_dtl_loc_key_fkey FOREIGN KEY (gr_itm_tk_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_date_key_fkey FOREIGN KEY (gr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_emp_key_fkey FOREIGN KEY (gr_emp_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_grplandetail
    ADD CONSTRAINT f_grplandetail_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grserialinfo
    ADD CONSTRAINT f_grserialinfo_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthudetail
    ADD CONSTRAINT f_grthudetail_gr_pln_key_fkey FOREIGN KEY (gr_pln_key) REFERENCES dwh.f_grplandetail(gr_pln_key);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_gr_loc_key_fkey FOREIGN KEY (gr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthuheader
    ADD CONSTRAINT f_grthuheader_gr_thu_key_fkey FOREIGN KEY (gr_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_loc_key_fkey FOREIGN KEY (gr_lot_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_thu_item_key_fkey FOREIGN KEY (gr_lot_thu_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_grthulotdetail
    ADD CONSTRAINT f_grthulotdetail_gr_lot_thu_key_fkey FOREIGN KEY (gr_lot_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_inboundamendheader
    ADD CONSTRAINT f_inboundamendheader_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_hdr_key_fkey FOREIGN KEY (inb_hdr_key) REFERENCES dwh.f_inboundheader(inb_hdr_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (inb_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inbounddetail
    ADD CONSTRAINT f_inbounddetail_inb_itm_dtl_loc_key_fkey FOREIGN KEY (inb_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inboundheader
    ADD CONSTRAINT f_inboundheader_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inbounditemamenddetail
    ADD CONSTRAINT f_inbounditemamenddetail_inb_amh_key_fkey FOREIGN KEY (inb_amh_key) REFERENCES dwh.f_inboundamendheader(inb_amh_key);

ALTER TABLE ONLY dwh.f_inbounditemamenddetail
    ADD CONSTRAINT f_inbounditemamenddetail_inb_itm_key_fkey FOREIGN KEY (inb_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inbounditemamenddetail
    ADD CONSTRAINT f_inbounditemamenddetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_in_ord_hdr_key_fkey FOREIGN KEY (in_ord_hdr_key) REFERENCES dwh.f_internalorderheader(in_ord_hdr_key);

ALTER TABLE ONLY dwh.f_inboundorderbindetail
    ADD CONSTRAINT f_inboundorderbindetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inboundplantracking
    ADD CONSTRAINT f_inboundplantracking_pln_date_key_fkey FOREIGN KEY (pln_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_inboundscheduleitemamenddetail
    ADD CONSTRAINT f_inboundscheduleitemamenddetail_inb_itm_key_fkey FOREIGN KEY (inb_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemamenddetail
    ADD CONSTRAINT f_inboundscheduleitemamenddetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_hdr_key_fkey FOREIGN KEY (inb_hdr_key) REFERENCES dwh.f_inboundheader(inb_hdr_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_itm_key_fkey FOREIGN KEY (inb_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_inboundscheduleitemdetail
    ADD CONSTRAINT f_inboundscheduleitemdetail_inb_loc_key_fkey FOREIGN KEY (inb_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_in_ord_hdr_customer_key_fkey FOREIGN KEY (in_ord_hdr_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_internalorderheader
    ADD CONSTRAINT f_internalorderheader_in_ord_hdr_loc_key_fkey FOREIGN KEY (in_ord_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_itm_hdr_key_fkey FOREIGN KEY (allc_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_stg_mas_key_fkey FOREIGN KEY (allc_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_thu_key_fkey FOREIGN KEY (allc_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_uom_key_fkey FOREIGN KEY (allc_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_wh_key_fkey FOREIGN KEY (allc_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_itemallocdetail
    ADD CONSTRAINT f_itemallocdetail_allc_zone_key_fkey FOREIGN KEY (allc_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_loc_key_fkey FOREIGN KEY (loading_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_shp_pt_key_fkey FOREIGN KEY (loading_dtl_shp_pt_key) REFERENCES dwh.d_shippingpoint(shp_pt_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_stg_mas_key_fkey FOREIGN KEY (loading_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_dtl_thu_key_fkey FOREIGN KEY (loading_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_loadingdetail
    ADD CONSTRAINT f_loadingdetail_loading_hdr_key_fkey FOREIGN KEY (loading_hdr_key) REFERENCES dwh.f_loadingheader(loading_hdr_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_emp_hdr_key_fkey FOREIGN KEY (loading_hdr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_eqp_key_fkey FOREIGN KEY (loading_hdr_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_loc_key_fkey FOREIGN KEY (loading_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_loadingheader
    ADD CONSTRAINT f_loadingheader_loading_hdr_veh_key_fkey FOREIGN KEY (loading_hdr_veh_key) REFERENCES dwh.d_vehicle(veh_key);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_lot_mst_dtl_itm_hdr_key_fkey FOREIGN KEY (lot_mst_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_lotmasterdetail
    ADD CONSTRAINT f_lotmasterdetail_lot_mst_dtl_wh_key_fkey FOREIGN KEY (lot_mst_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_customer_key_fkey FOREIGN KEY (stk_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_item_key_fkey FOREIGN KEY (stk_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_lottrackingdetail
    ADD CONSTRAINT f_lottrackingdetail_stk_loc_key_fkey FOREIGN KEY (stk_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outbounddocdetail
    ADD CONSTRAINT f_outbounddocdetail_obd_loc_key_fkey FOREIGN KEY (obd_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_obh_cust_key_fkey FOREIGN KEY (obh_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_obh_loc_key_fkey FOREIGN KEY (obh_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundheader
    ADD CONSTRAINT f_outboundheader_oub_orderdatekey_fkey FOREIGN KEY (oub_orderdatekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_obh_cust_key_fkey FOREIGN KEY (obh_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_obh_loc_key_fkey FOREIGN KEY (obh_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundheaderhistory
    ADD CONSTRAINT f_outboundheaderhistory_oub_orderdatekey_fkey FOREIGN KEY (oub_orderdatekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_outbounditemdetail
    ADD CONSTRAINT f_outbounditemdetail_obd_itm_key_fkey FOREIGN KEY (obd_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outbounditemdetail
    ADD CONSTRAINT f_outbounditemdetail_obd_loc_key_fkey FOREIGN KEY (obd_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_obd_itm_key_fkey FOREIGN KEY (obd_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outbounditemdetailhistory
    ADD CONSTRAINT f_outbounditemdetailhistory_obd_loc_key_fkey FOREIGN KEY (obd_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_oub_item_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetail
    ADD CONSTRAINT f_outboundlotsrldetail_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetailhistory
    ADD CONSTRAINT f_outboundlotsrldetailhistory_oub_itm_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundlotsrldetailhistory
    ADD CONSTRAINT f_outboundlotsrldetailhistory_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_oub_item_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundschdetail
    ADD CONSTRAINT f_outboundschdetail_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_oub_itm_key_fkey FOREIGN KEY (oub_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_outboundschdetailhistory
    ADD CONSTRAINT f_outboundschdetailhistory_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_outboundvasheader
    ADD CONSTRAINT f_outboundvasheader_oub_loc_key_fkey FOREIGN KEY (oub_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecheader
    ADD CONSTRAINT f_packexecheader_pack_loc_key_fkey FOREIGN KEY (pack_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_itm_hdr_key_fkey FOREIGN KEY (pack_exec_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_thu_hdr_key_fkey FOREIGN KEY (pack_exec_thu_hdr_key) REFERENCES dwh.f_packexecthuheader(pack_exec_thu_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthudetail
    ADD CONSTRAINT f_packexecthudetail_pack_hdr_key_fkey FOREIGN KEY (pack_exec_hdr_key) REFERENCES dwh.f_packexecheader(pack_exe_hdr_key);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthudetailhistory
    ADD CONSTRAINT f_packexecthudetailhistory_pack_exec_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_loc_key_fkey FOREIGN KEY (pack_exec_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_thu_key_fkey FOREIGN KEY (pack_exec_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_exe_uom_key_fkey FOREIGN KEY (pack_exec_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_packexecthuheader
    ADD CONSTRAINT f_packexecthuheader_pack_hdr_key_fkey FOREIGN KEY (pack_exec_hdr_key) REFERENCES dwh.f_packexecheader(pack_exe_hdr_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_itm_hdr_key_fkey FOREIGN KEY (pack_itm_sl_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_loc_key_fkey FOREIGN KEY (pack_itm_sl_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packitemserialdetail
    ADD CONSTRAINT f_packitemserialdetail_pack_itm_sl_dtl_thu_key_fkey FOREIGN KEY (pack_itm_sl_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_itm_hdr_key_fkey FOREIGN KEY (pack_pln_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_loc_key_fkey FOREIGN KEY (pack_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_dtl_thu_key_fkey FOREIGN KEY (pack_pln_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_packplandetail
    ADD CONSTRAINT f_packplandetail_pack_pln_hdr_key_fkey FOREIGN KEY (pack_pln_hdr_key) REFERENCES dwh.f_packplanheader(pack_pln_hdr_key);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_date_key_fkey FOREIGN KEY (pack_pln_hdr_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_emp_hdr_key_fkey FOREIGN KEY (pack_pln_hdr_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_packplanheader
    ADD CONSTRAINT f_packplanheader_pack_pln_hdr_loc_key_fkey FOREIGN KEY (pack_pln_hdr_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_packstoragedetail
    ADD CONSTRAINT f_packstoragedetail_pack_storage_dtl_loc_key_fkey FOREIGN KEY (pack_storage_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_emp_hdr_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_eqp_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_loc_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickempequipmapdetail
    ADD CONSTRAINT f_pickempequipmapdetail_pick_emp_eqp_dtl_key_zone_key_fkey FOREIGN KEY (pick_emp_eqp_dtl_key_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_hdr_key_fkey FOREIGN KEY (pick_hdr_key) REFERENCES dwh.f_pickingheader(pick_hdr_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_itm_key_fkey FOREIGN KEY (pick_itm_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_pickingdetail
    ADD CONSTRAINT f_pickingdetail_pick_loc_key_fkey FOREIGN KEY (pick_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickingheader
    ADD CONSTRAINT f_pickingheader_pick_loc_key_fkey FOREIGN KEY (pick_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_hdr_key_fkey FOREIGN KEY (pick_pln_hdr_key) REFERENCES dwh.f_pickplanheader(pick_pln_hdr_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_item_key_fkey FOREIGN KEY (pick_pln_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_loc_key_fkey FOREIGN KEY (pick_pln_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickplandetails
    ADD CONSTRAINT f_pickplandetails_pick_pln_thu_key_fkey FOREIGN KEY (pick_pln_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_pickplanheader
    ADD CONSTRAINT f_pickplanheader_pick_pln_loc_key_fkey FOREIGN KEY (pick_pln_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pickrulesheader
    ADD CONSTRAINT f_pickrulesheader_pick_loc_key_fkey FOREIGN KEY (pick_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_plpd_cust_key_fkey FOREIGN KEY (plpd_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_planningdetail
    ADD CONSTRAINT f_planningdetail_plph_hdr_key_fkey FOREIGN KEY (plph_hdr_key) REFERENCES dwh.f_planningheader(plph_hdr_key);

ALTER TABLE ONLY dwh.f_planningheader
    ADD CONSTRAINT f_planningheader_plph_loc_key_fkey FOREIGN KEY (plph_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_gr_pln_key_fkey FOREIGN KEY (gr_pln_key) REFERENCES dwh.f_grplandetail(gr_pln_key);

ALTER TABLE ONLY dwh.f_pogritemdetail
    ADD CONSTRAINT f_pogritemdetail_gr_po_loc_key_fkey FOREIGN KEY (gr_po_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_cust_key_fkey FOREIGN KEY (po_dtl_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_loc_key_fkey FOREIGN KEY (po_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_uom_key_fkey FOREIGN KEY (po_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_dtl_wh_key_fkey FOREIGN KEY (po_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_purchasedetails
    ADD CONSTRAINT f_purchasedetails_po_hr_key_fkey FOREIGN KEY (po_hr_key) REFERENCES dwh.f_purchaseheader(po_hr_key);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_po_cur_key_fkey FOREIGN KEY (po_cur_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_po_date_key_fkey FOREIGN KEY (po_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_po_loc_key_fkey FOREIGN KEY (po_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchaseheader
    ADD CONSTRAINT f_purchaseheader_po_supp_key_fkey FOREIGN KEY (po_supp_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_purchasereceiptheader
    ADD CONSTRAINT f_purchasereceiptheader_rcgh_date_key_fkey FOREIGN KEY (rcgh_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_customer_key_fkey FOREIGN KEY (preqm_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_loc_key_fkey FOREIGN KEY (preqm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_uom_key_fkey FOREIGN KEY (preqm_dtl_uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_vendor_key_fkey FOREIGN KEY (preqm_dtl_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_dtl_wh_key_fkey FOREIGN KEY (preqm_dtl_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_purchasereqdetail
    ADD CONSTRAINT f_purchasereqdetail_preqm_hr_key_fkey FOREIGN KEY (preqm_hr_key) REFERENCES dwh.f_purchasereqheader(preqm_hr_key);

ALTER TABLE ONLY dwh.f_purchasereqheader
    ADD CONSTRAINT f_purchasereqheader_preqm_hr_curr_key_fkey FOREIGN KEY (preqm_hr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pway_bin_cap_itm_hdr_key_fkey FOREIGN KEY (pway_bin_cap_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawaybincapacity
    ADD CONSTRAINT f_putawaybincapacity_pway_bin_cap_loc_key_fkey FOREIGN KEY (pway_bin_cap_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_emp_hdr_key_fkey FOREIGN KEY (pway_eqp_map_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_eqp_key_fkey FOREIGN KEY (pway_eqp_map_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_loc_key_fkey FOREIGN KEY (pway_eqp_map_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayempequipmap
    ADD CONSTRAINT f_putawayempequipmap_pway_eqp_map_zone_key_fkey FOREIGN KEY (pway_eqp_map_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_emp_hdr_key_fkey FOREIGN KEY (pway_exe_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_eqp_key_fkey FOREIGN KEY (pway_exe_dtl_eqp_key) REFERENCES dwh.d_equipment(eqp_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_loc_key_fkey FOREIGN KEY (pway_exe_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayexecdetail
    ADD CONSTRAINT f_putawayexecdetail_pway_exe_dtl_stg_mas_key_fkey FOREIGN KEY (pway_exe_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exe_dtl_key_fkey FOREIGN KEY (pway_exe_dtl_key) REFERENCES dwh.f_putawayexecdetail(pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exec_serial_dtl_loc_key_fkey FOREIGN KEY (pway_exec_serial_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayexecserialdetail
    ADD CONSTRAINT f_putawayexecserialdetail_pway_exec_serial_dtl_zone_key_fkey FOREIGN KEY (pway_exec_serial_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_exe_dtl_key_fkey FOREIGN KEY (pway_exe_dtl_key) REFERENCES dwh.f_putawayexecdetail(pway_exe_dtl_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (pway_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_loc_key_fkey FOREIGN KEY (pway_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayitemdetail
    ADD CONSTRAINT f_putawayitemdetail_pway_itm_dtl_zone_key_fkey FOREIGN KEY (pway_itm_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_date_key_fkey FOREIGN KEY (pway_pln_dtl_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_emp_hdr_key_fkey FOREIGN KEY (pway_pln_dtl_emp_hdr_key) REFERENCES dwh.d_employeeheader(emp_hdr_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_loc_key_fkey FOREIGN KEY (pway_pln_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayplandetail
    ADD CONSTRAINT f_putawayplandetail_pway_pln_dtl_stg_mas_key_fkey FOREIGN KEY (pway_pln_dtl_stg_mas_key) REFERENCES dwh.d_stage(stg_mas_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_dtl_key_fkey FOREIGN KEY (pway_pln_dtl_key) REFERENCES dwh.f_putawayplandetail(pway_pln_dtl_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (pway_pln_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_loc_key_fkey FOREIGN KEY (pway_pln_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayplanitemdetail
    ADD CONSTRAINT f_putawayplanitemdetail_pway_pln_itm_dtl_zone_key_fkey FOREIGN KEY (pway_pln_itm_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_putawayserialdetail
    ADD CONSTRAINT f_putawayserialdetail_pway_serial_dtl_loc_key_fkey FOREIGN KEY (pway_serial_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_putawayserialdetail
    ADD CONSTRAINT f_putawayserialdetail_pway_serial_dtl_zone_key_fkey FOREIGN KEY (pway_serial_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_company_key_fkey FOREIGN KEY (rppostingsdtl_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_curr_key_fkey FOREIGN KEY (rppostingsdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_datekey_fkey FOREIGN KEY (rppostingsdtl_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_rppostingsdtl
    ADD CONSTRAINT f_rppostingsdtl_rppostingsdtl_opcoa_key_fkey FOREIGN KEY (rppostingsdtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_company_key_fkey FOREIGN KEY (rptacctinfodtl_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_curr_key_fkey FOREIGN KEY (rptacctinfodtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_datekey_fkey FOREIGN KEY (rptacctinfodtl_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_rptacctinfodtl
    ADD CONSTRAINT f_rptacctinfodtl_rptacctinfodtl_opcoa_key_fkey FOREIGN KEY (rptacctinfodtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_sadadjvcrdocdtl
    ADD CONSTRAINT f_sadadjvcrdocdtl_sadadjvcrdocdtl_curr_key_fkey FOREIGN KEY (sadadjvcrdocdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sadadjvdrdocdtl
    ADD CONSTRAINT f_sadadjvdrdocdtl_sadadjvdrdocdtl_curr_key_fkey FOREIGN KEY (sadadjvdrdocdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_sadadjvoucherhdr_curr_key_fkey FOREIGN KEY (sadadjvoucherhdr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sadadjvoucherhdr
    ADD CONSTRAINT f_sadadjvoucherhdr_sadadjvoucherhdr_vendor_key_fkey FOREIGN KEY (sadadjvoucherhdr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_sdinappostingsdtl
    ADD CONSTRAINT f_sdinappostingsdtl_account_key_fkey FOREIGN KEY (account_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_account_key_fkey FOREIGN KEY (account_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_sdinexpensedtl
    ADD CONSTRAINT f_sdinexpensedtl_uom_key_fkey FOREIGN KEY (uom_key) REFERENCES dwh.d_uom(uom_key);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_sidochdr_currency_key_fkey FOREIGN KEY (sidochdr_currency_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_sidochdr
    ADD CONSTRAINT f_sidochdr_sidochdr_vendor_key_fkey FOREIGN KEY (sidochdr_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_sinitemdtl
    ADD CONSTRAINT f_sinitemdtl_si_sinitm_inv_key_fkey FOREIGN KEY (si_sinitm_inv_key) REFERENCES dwh.f_sininvoicehdr(si_inv_key);

ALTER TABLE ONLY dwh.f_snpvoucherdtl
    ADD CONSTRAINT f_snpvoucherdtl_curr_key_fkey FOREIGN KEY (curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_curr_key_fkey FOREIGN KEY (curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_spypaybatchdtl
    ADD CONSTRAINT f_spypaybatchdtl_vendor_key_fkey FOREIGN KEY (vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_stock_lottrackingdaywise_detail
    ADD CONSTRAINT f_stock_lottrackingdaywise_detail_stk_customer_key_fkey FOREIGN KEY (stk_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stock_lottrackingdaywise_detail
    ADD CONSTRAINT f_stock_lottrackingdaywise_detail_stk_item_key_fkey FOREIGN KEY (stk_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stock_lottrackingdaywise_detail
    ADD CONSTRAINT f_stock_lottrackingdaywise_detail_stk_loc_key_fkey FOREIGN KEY (stk_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_itm_hdr_key_fkey FOREIGN KEY (sbs_level_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_wh_key_fkey FOREIGN KEY (sbs_level_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_stockbalanceseriallevel
    ADD CONSTRAINT f_stockbalanceseriallevel_sbs_level_zone_key_fkey FOREIGN KEY (sbs_level_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_itm_hdr_key_fke FOREIGN KEY (sbl_lot_level_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_thu_key_fkey FOREIGN KEY (sbl_lot_level_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_wh_key_fkey FOREIGN KEY (sbl_lot_level_wh_key) REFERENCES dwh.d_warehouse(wh_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitlotlevel
    ADD CONSTRAINT f_stockbalancestorageunitlotlevel_sbl_lot_level_zone_key_fkey FOREIGN KEY (sbl_lot_level_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_stockbalancestorageunitseriallevel
    ADD CONSTRAINT f_stockbalancestorageunitseriallevel_sbs_hdr_key_fkey FOREIGN KEY (sbl_lot_level_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_cust_key_fkey FOREIGN KEY (stock_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_item_key_fkey FOREIGN KEY (stock_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_loc_key_fkey FOREIGN KEY (stock_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockbinhistorydetail
    ADD CONSTRAINT f_stockbinhistorydetail_stock_thu_key_fkey FOREIGN KEY (stock_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_customer_key_fkey FOREIGN KEY (stk_con_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_itm_hdr_key_fkey FOREIGN KEY (stk_con_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_loc_key_fkey FOREIGN KEY (stk_con_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_dtl_zone_key_fkey FOREIGN KEY (stk_con_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_stockconversiondetail
    ADD CONSTRAINT f_stockconversiondetail_stk_con_hdr_key_fkey FOREIGN KEY (stk_con_hdr_key) REFERENCES dwh.f_stockconversionheader(stk_con_hdr_key);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_stk_con_date_key_fkey FOREIGN KEY (stk_con_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_stockconversionheader
    ADD CONSTRAINT f_stockconversionheader_stk_con_loc_key_fkey FOREIGN KEY (stk_con_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockrejecteddetail
    ADD CONSTRAINT f_stockrejecteddetail_rejstk_dtl_itm_hdr_key_fkey FOREIGN KEY (rejstk_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockrejecteddetail
    ADD CONSTRAINT f_stockrejecteddetail_rejstk_dtl_loc_key_fkey FOREIGN KEY (rejstk_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockrejecteddetail
    ADD CONSTRAINT f_stockrejecteddetail_rejstk_dtl_thu_key_fkey FOREIGN KEY (rejstk_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_stk_su_customer_key_fkey FOREIGN KEY (stk_su_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockstoragebalancedetail
    ADD CONSTRAINT f_stockstoragebalancedetail_stk_su_loc_key_fkey FOREIGN KEY (stk_su_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_customer_key_fkey FOREIGN KEY (stk_itm_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_date_key_fkey FOREIGN KEY (stk_itm_dtl_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_itm_hdr_key_fkey FOREIGN KEY (stk_itm_dtl_itm_hdr_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_loc_key_fkey FOREIGN KEY (stk_itm_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockuiditemtrackingdetail
    ADD CONSTRAINT f_stockuiditemtrackingdetail_stk_itm_dtl_thu_key_fkey FOREIGN KEY (stk_itm_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_bin_type_key_fkey FOREIGN KEY (stk_trc_dtl_bin_type_key) REFERENCES dwh.d_bintypes(bin_typ_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_customer_key_fkey FOREIGN KEY (stk_trc_dtl_customer_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_loc_key_fkey FOREIGN KEY (stk_trc_dtl_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_thu_key_fkey FOREIGN KEY (stk_trc_dtl_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_stockuidtrackingdetail
    ADD CONSTRAINT f_stockuidtrackingdetail_stk_trc_dtl_zone_key_fkey FOREIGN KEY (stk_trc_dtl_zone_key) REFERENCES dwh.d_zone(zone_key);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_surf_trn_company_key_fkey FOREIGN KEY (surf_trn_company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_surfbpostingsdtl
    ADD CONSTRAINT f_surfbpostingsdtl_surf_trn_curr_key_fkey FOREIGN KEY (surf_trn_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_surreceiptdtl_curr_key_fkey FOREIGN KEY (surreceiptdtl_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_surreceiptdtl
    ADD CONSTRAINT f_surreceiptdtl_surreceiptdtl_opcoa_key_fkey FOREIGN KEY (surreceiptdtl_opcoa_key) REFERENCES dwh.d_operationalaccountdetail(opcoa_key);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_surreceipthdr_curr_key_fkey FOREIGN KEY (surreceipthdr_curr_key) REFERENCES dwh.d_currency(curr_key);

ALTER TABLE ONLY dwh.f_surreceipthdr
    ADD CONSTRAINT f_surreceipthdr_surreceipthdr_date_key_fkey FOREIGN KEY (surreceipthdr_datekey) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_tbpvoucherhdr
    ADD CONSTRAINT f_tbpvoucherhdr_company_key_fkey FOREIGN KEY (company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_tcaltranhdr
    ADD CONSTRAINT f_tcaltranhdr_company_key_fkey FOREIGN KEY (company_key) REFERENCES dwh.d_company(company_key);

ALTER TABLE ONLY dwh.f_tenderrequirementdetail
    ADD CONSTRAINT f_tenderrequirementdetail_trd_hdr_key_fkey FOREIGN KEY (trd_hdr_key) REFERENCES dwh.f_tenderrequirementheader(trh_hdr_key);

ALTER TABLE ONLY dwh.f_tenderrequirementheader
    ADD CONSTRAINT f_tenderrequirementheader_trh_date_key_fkey FOREIGN KEY (trh_date_key) REFERENCES dwh.d_date(datekey);

ALTER TABLE ONLY dwh.f_tripexecutionplandetail
    ADD CONSTRAINT f_tripexecutionplandetail_br_key_fkey FOREIGN KEY (br_key) REFERENCES dwh.f_bookingrequest(br_key);

ALTER TABLE ONLY dwh.f_triplogagentdetail
    ADD CONSTRAINT f_triplogagentdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_triplogeventdetail
    ADD CONSTRAINT f_triplogeventdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_triplogthudetail
    ADD CONSTRAINT f_triplogthudetail_tltd_vendor_key_fkey FOREIGN KEY (tltd_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_tripododetail
    ADD CONSTRAINT f_tripododetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_tripplanningdetail
    ADD CONSTRAINT f_tripplanningdetail_plpth_hdr_key_fkey FOREIGN KEY (plpth_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_tripplanningheader
    ADD CONSTRAINT f_tripplanningheader_plpth_vehicle_key_fkey FOREIGN KEY (plpth_vehicle_key) REFERENCES dwh.d_vehicle(veh_key);

ALTER TABLE ONLY dwh.f_trippodattachmentdetail
    ADD CONSTRAINT f_trippodattachmentdetail_tpad_trip_hdr_key_fkey FOREIGN KEY (tpad_trip_hdr_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_tripresourcescheduledetail
    ADD CONSTRAINT f_tripresourcescheduledetail_trsd_vendor_key_fkey FOREIGN KEY (trsd_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_tripthudetail
    ADD CONSTRAINT f_tripthudetail_plttd_thu_key_fkey FOREIGN KEY (plttd_thu_key) REFERENCES dwh.d_thu(thu_key);

ALTER TABLE ONLY dwh.f_tripthuserialdetail
    ADD CONSTRAINT f_tripthuserialdetail_plttd_trip_thu_key_fkey FOREIGN KEY (plttd_trip_thu_key) REFERENCES dwh.f_tripthudetail(plttd_trip_thu_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostdetail
    ADD CONSTRAINT f_tripvendortariffrevcostdetail_tvtrcd_hdr_key_fkey FOREIGN KEY (tvtrcd_hdr_key) REFERENCES dwh.f_tripvendortariffrevcostheader(tvtrch_key);

ALTER TABLE ONLY dwh.f_tripvendortariffrevcostheader
    ADD CONSTRAINT f_tripvendortariffrevcostheader_tvtrch_trip_plan_hrd_key_fkey FOREIGN KEY (tvtrch_trip_plan_hrd_key) REFERENCES dwh.f_tripplanningheader(plpth_hdr_key);

ALTER TABLE ONLY dwh.f_vehicleequiplicensedetail
    ADD CONSTRAINT f_vehicleequiplicensedetail_vrvel_vendor_key_fkey FOREIGN KEY (vrvel_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_vehicleequipresponsedetail
    ADD CONSTRAINT f_vehicleequipresponsedetail_vrve_vendor_key_fkey FOREIGN KEY (vrve_vendor_key) REFERENCES dwh.d_vendor(vendor_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_cust_key_fkey FOREIGN KEY (wave_cust_key) REFERENCES dwh.d_customer(customer_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_hdr_key_fkey FOREIGN KEY (wave_hdr_key) REFERENCES dwh.f_waveheader(wave_hdr_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_item_key_fkey FOREIGN KEY (wave_item_key) REFERENCES dwh.d_itemheader(itm_hdr_key);

ALTER TABLE ONLY dwh.f_wavedetail
    ADD CONSTRAINT f_wavedetail_wave_loc_key_fkey FOREIGN KEY (wave_loc_key) REFERENCES dwh.d_location(loc_key);

ALTER TABLE ONLY dwh.f_waveheader
    ADD CONSTRAINT f_waveheader_wave_loc_key_fkey FOREIGN KEY (wave_loc_key) REFERENCES dwh.d_location(loc_key);
