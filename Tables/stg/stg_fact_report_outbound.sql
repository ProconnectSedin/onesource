CREATE TABLE stg.stg_fact_report_outbound (
    surrogatekey character varying(100) COLLATE public.nocase,
    ou integer,
    locationcode character varying(30) COLLATE public.nocase,
    region character varying(30) COLLATE public.nocase,
    customercode character varying(20) COLLATE public.nocase,
    outbound_order_no character varying(50) COLLATE public.nocase,
    outbound_order_date timestamp without time zone,
    ordertype character varying(30) COLLATE public.nocase,
    invoiceno character varying(100) COLLATE public.nocase,
    invoicedate timestamp without time zone,
    order_status character varying(10) COLLATE public.nocase,
    request_type character varying(50) COLLATE public.nocase,
    order_priority character varying(10) COLLATE public.nocase,
    customerlinenumber character varying(40) COLLATE public.nocase,
    orderlinenumber integer,
    itemcode character varying(100) COLLATE public.nocase,
    order_qty numeric,
    item_uom character varying(30) COLLATE public.nocase,
    item_deliverydate timestamp without time zone,
    shipment_mode character varying(50) COLLATE public.nocase,
    shipment_type character varying(50) COLLATE public.nocase,
    subservice_type character varying(150) COLLATE public.nocase,
    consigneeaddress character varying(300) COLLATE public.nocase,
    pincode character varying(30) COLLATE public.nocase,
    created_by character varying(150) COLLATE public.nocase,
    created_date timestamp without time zone,
    modified_by character varying(150) COLLATE public.nocase,
    modified_date timestamp without time zone,
    operation_status character varying(100) COLLATE public.nocase,
    wave_qty numeric,
    wavedatetime timestamp without time zone,
    wave_status character varying(50) COLLATE public.nocase,
    pick_qty numeric,
    pickdatetime timestamp without time zone,
    pick_status character varying(50) COLLATE public.nocase,
    pack_thu_qty numeric,
    pack_qty numeric,
    packdatetime timestamp without time zone,
    pack_status character varying(50) COLLATE public.nocase,
    wms_loadingdatetime timestamp without time zone,
    loadstatus character varying(50) COLLATE public.nocase,
    wms_dispatchdatetime timestamp without time zone,
    dispstatus character varying(50) COLLATE public.nocase,
    wms_agent character varying(100) COLLATE public.nocase,
    br_no character varying(80) COLLATE public.nocase,
    brstatus character varying(50) COLLATE public.nocase,
    sender_ref_no character varying(100) COLLATE public.nocase,
    br_servicetype character varying(100) COLLATE public.nocase,
    br_subservicetype character varying(100) COLLATE public.nocase,
    transportmode character varying(100) COLLATE public.nocase,
    br_creation_date timestamp without time zone,
    from_postal_code character varying(50) COLLATE public.nocase,
    to_postal_code character varying(50) COLLATE public.nocase,
    trip_plan_id character varying(80) COLLATE public.nocase,
    trip_plan_status character varying(50) COLLATE public.nocase,
    agent_id character varying(100) COLLATE public.nocase,
    trip_plan_end_date timestamp without time zone,
    dispatchdocnumber character varying(80) COLLATE public.nocase,
    agentweight numeric,
    agentdocno character varying(100) COLLATE public.nocase,
    agentdocdate timestamp without time zone,
    leg_behaviour character varying(50) COLLATE public.nocase,
    event_id character varying(30) COLLATE public.nocase,
    dispatchdatetime timestamp without time zone,
    deliverydatetime timestamp without time zone,
    deliveryleg_behaviour character varying(50) COLLATE public.nocase,
    deliveryevent_id character varying(30) COLLATE public.nocase,
    expclosuredatetime timestamp without time zone,
    ontime integer,
    offtime integer,
    cutofftime time without time zone,
    processtat integer,
    openingtime time without time zone,
    closingtime time without time zone,
    servicetype character varying(30) COLLATE public.nocase,
    locationdesc character varying(50) COLLATE public.nocase,
    samedaydispatch integer,
    packontime integer,
    packofftime integer,
    pickontime integer,
    pickofftime integer,
    podflag character(2) COLLATE public.nocase,
    packtat integer,
    packexpectedclosuretime timestamp without time zone,
    picktat integer,
    pickexpectedclosuretime timestamp without time zone,
    deltat integer,
    delexpectedclosuretime timestamp without time zone,
    delontime integer,
    delofftime integer,
    samedaydelivery integer,
    dispatchcreateddatetime timestamp without time zone,
    deliverycreateddatetime timestamp without time zone,
    tripsheetcreateddatetime timestamp without time zone,
    arrivedobddate timestamp without time zone,
    delexpdays integer,
    last_modified_date timestamp without time zone,
    etlcreateddatetime timestamp(3) without time zone DEFAULT now()
);