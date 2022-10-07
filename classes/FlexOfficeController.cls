public class FlexOfficeController {
   
//desk
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

    @AuraEnabled
    public static string getDesks(){
        try {
            List<Desk__c> desks = new List<Desk__c> ();
            desks = [SELECT Id, Name, Checkbox__c FROM Desk__c];
            return JSON.serialize(desks);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

// reservation
    @AuraEnabled
    public static string createReservation(String reservation){
        try {
            Reservation__c res  = (Reservation__c)JSON.deserialize(reservation, Reservation__c.class);
            insert res;
            return res.id;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static string getReservations(){
        try {
            List<Reservation__c> reserv = new List<Reservation__c> ();
            reserv = [SELECT Id, Name FROM Reservation__c];
            return JSON.serialize(reserv);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
        
}
  