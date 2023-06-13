trigger AccountTrigger on Account (after  insert , after update) {

    if(trigger.isAfter && trigger.isInsert){
        AccountTriggerHandler.createNewContact(trigger.new,null );
  }
  if(trigger.isAfter && trigger.isUpdate){
     AccountTriggerHandler.createNewContact(trigger.new ,null); 
  }

}