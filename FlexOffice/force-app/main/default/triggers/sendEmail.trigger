trigger sendEmail on Reservation__c (after insert, after update) {
    sendEmailHandler.sendEmailNotification(Trigger.new); 
}
