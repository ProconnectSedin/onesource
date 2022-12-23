CREATE or replace TRIGGER controlheadertrigger
     AFTER insert or update or delete ON ods.controlheader
     FOR EACH ROW
     EXECUTE PROCEDURE ods.controlheaderaudit();
	 
	 
	 
CREATE or replace TRIGGER controldetailtrigger
     AFTER insert or update or delete ON ods.controldetail
     FOR EACH ROW
     EXECUTE PROCEDURE ods.controldetailaudit();


     