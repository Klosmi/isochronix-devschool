public with sharing class sendEmailHandler {
    // all the inserted records are on the rList => it can be multiple records
    public static void sendEmailNotification(List<Reservation__c> rList) {
        //since we can have multiple records (rList), we can store the rList's records on this emailList, 1 by 1 creating 1 instance of email
        List <Messaging.Email> emailList = new List<Messaging.Email>();   
        // iterate on the rList, so reservation records are available on the 'r' 
        for(Reservation__c r : rList){               
            // get email address of the user who created the new record => CreatedBy method
            String emailUser = [SELECT CreatedBy.Email FROM Reservation__c WHERE Id =: r.Id].CreatedBy.Email;
            System.debug(emailUser);
            //instance of the SingleEmailMessage is created
            Messaging.SingleEmailMessage emailMsg = new Messaging.SingleEmailMessage();
            // set the parameters, list of string stores toAddress, and to Address stores the email address
            String[] toAddress = new String[]{emailUser};
            System.debug('to address'+ toAddress);
            // passing the toAddress parameter => toAddress provides multiple email addresses (that is whewe created the LIST of string)
            emailMsg.setToAddresses(toAddress);
            System.debug('Message' + emailMsg);
            // subject of the email - + reservation's name (like reservation number is: 0002 )
            String emailSub = 'Reservation is created. Reservation number is: ';
            // subject is set by passe the emailSub as a paramaeter
            emailMsg.setSubject(emailSub);
            // setting display name - could set any ther name
            String disName = 'Miklos';
            emailMsg.setSenderDisplayName(disName);
            // body of the email
            String content = 'Hi: reservation: ';
            emailMsg.setHtmlBody(content);
            //add emailMessage instance to emailList
            emailList.add(emailMsg);
            System.debug(emailList);

        }
    //quit from the loop
    Messaging.sendEmail(emailList);
    //System.debug('Messaging' + Messaging.sendEmail(emailList));


    // List <Messaging.Email> emailList=  new List<Messaging.Email>();
    // Messaging.SingleEmailMessage mails =  new Messaging.SingleEmailMessage();
    // String emailUser = [SELECT CreatedBy.Email FROM Reservation__c WHERE Id =: rList.Id].CreatedBy.Email;
    // String[] sendTo = new String[]{emailUser};//
    // Messaging.SingleEmailMessage mail =  new Messaging.SingleEmailMessage();
    // mail.setToAddresses(sendTo);
    // System.debug(emailUser);
    // mail.setToAddresses(sendTo);
    // mail.setSubject('Reservation created');
    // String body = 'A sreservation was created.' ;
    // mail.setHtmlBody(body);
    // mails.add(mail);
    // }
    // Messaging.sendEmail(mails);
    // System.debug(mails);
}
}




