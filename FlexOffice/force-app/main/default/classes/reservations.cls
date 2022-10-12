public with sharing class reservations {
    
    @AuraEnabled(cacheable=true)
    public static Salle__c reservationCreator(Salle__c reserv){
        try {
            insert reserv;
            return reserv;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
   
    //THIS IS THE CODE
    @AuraEnabled
    public static List<Desk__c> getAvailableDesks(){
        try {
            return [SELECT Id, Name FROM Desk__c];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    

    public List<SelectOption> getDesks()
{
    List<SelectOption> options = new List<SelectOption>();
    Schema.DescribeFieldResult fieldResult = Desk__c.DeskList__c.getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    for( Schema.PicklistEntry f : ple)
    {
        options.add(new SelectOption(f.getLabel(), f.getValue()));
    }
    return options;
}


    @AuraEnabled(cacheable=true)
    public static Contact fetchContact(String conId){
        return [SELECT Id,Name,Email FROM Contact WHERE ID=:conId];
    }

    @AuraEnabled
    public static string createDesk(String desk){
        try {
            Desk__c d  = (Desk__c)JSON.deserialize(desk, Desk__c.class);
            insert d;
            return d.id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

