public with sharing class PickListHelper {
   
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getUsers(){
        Map<String, String> userMap = new Map<String, String>();
        for(User userObj: [SELECT FirstName, Email FROM User WHERE Username LIKE '%@%.%']){
            userMap.put(userObj.Email, userObj.FirstName);
        }
        return userMap;
    }


    @AuraEnabled
    public static List<String> getDesks(){
        List<String> options = new List<String>();
        Schema.DescribeFieldResult fieldResult = Desk__c.DeskList__c.getDescribe();
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            options.add(p.getLabel());
        }
        return options;
    }
}

