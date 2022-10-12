trigger RestricUserDeleteRecord on Reservation__c (before delete) {
    Id profileId = UserInfo.getProfileId();
    //get profile name
    String profileName = [SELECT Id, Name from Profile WHERE Id =: profileId].Name;
    String username = UserInfo.getName();

    for(Reservation__c res : trigger.old){
        //Restrict a Profile from deleting a Record
        if(profileName == 'System Administrator') {
            res.addError('You are not allowed to delete a Reservation records');
        }
        if(profileName == 'Manager') {
            res.addError('You are not allowed to delete a Reservation records');
        }
        if(username == 'user02'){
             res.addError('You are not allowed to delete a Reservation records');
        }
    }
}