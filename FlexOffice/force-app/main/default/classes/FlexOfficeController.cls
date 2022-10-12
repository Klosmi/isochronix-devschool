public class FlexOfficeController {
   
//desk
    @AuraEnabled
    public static string createDesk(String desk){
        try {
            Desk__c d = (Desk__c)JSON.deserialize(desk, Desk__c.class);
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
            desks = [SELECT Id, Name FROM Desk__c];
            return JSON.serialize(desks);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=true)
    public static list<Reservation__c> getRes() {
        return [SELECT Id, Name, Satatus__c  FROM Reservation__c];
    }

    // // status
    // @AuraEnabled
    // public static  Reservation__c createReservation(string dateres , string idres ) {
    //     Reservation__c v = new Reservation__c () ;
    //     v.status__c = 'validée' ;
    //     v.DateDeReservation__c = Date.valueOf(dateres) ;
    //     v.Bureau__c = Id.valueOf(idres) ;
    //     v.Occupeur__c = UserInfo.getUserId();

    //          insert v;
    //          return v ;
    // }
     
    // @AuraEnabled
    // public static  Reservation__c UpdateReservation(string Idresvar ) {
    //     string Idvart ;
    //     Idvart= Idresvar ;
    //     Reservation__c vres = new Reservation__c () ;
    //     vres.status__c = 'Annulée' ;
    //       vres.Id = Id.valueOf(Idresvar);
    //          update vres ;
    //          return vres;
    // }  
}