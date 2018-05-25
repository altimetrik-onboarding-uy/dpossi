global class sendEmail implements Database.Batchable<sObject>, Database.Stateful{
    global Map<Id, ManagersPost> mapManagersPost = new Map<Id, ManagersPost>();
    global Messaging.SendEmailResult[] results = null;
    global integer emailAmount = 0;
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id, Name, Status__c, CreatedById, CreatedBy.Manager.Id, CreatedBy.Manager.Email, Writer__c FROM Post__C WHERE Status__c =  \'Under Review\' ');
    }
    
    global void execute(Database.BatchableContext BC, List<Post__c> scope){
        for(Post__c p: scope){
            if(mapManagersPost.containsKey(p.CreatedBy.Manager.Id)){
                ManagersPost mp = mapManagersPost.get(p.CreatedBy.Manager.Id);
                mp.setPost(p);
                mapManagersPost.put(p.CreatedBy.Manager.Id, mp);
            }else{
           		ManagersPost mp = new ManagersPost(p.CreatedBy.Manager.Email);
                mp.setPost(p);
                mapManagersPost.put(p.CreatedBy.Manager.Id, mp);
            }
        }
        system.debug('MAP SIZE'+mapManagersPost.size());
    }
    
    global void finish(Database.BatchableContext BC){
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        
        for(Id manager: mapManagersPost.keySet()){
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            ManagersPost mp = mapManagersPost.get(manager);
            List<String> lstEmails = new List<String>();
            lstEmails.add('dpossi@altimetrik.com');
            mail.setToAddresses(lstEmails);
            mail.setSubject('Post to review');
            mail.plainTextBody = 'Dear Manager, /n You have the following emails to review: /n' + mp.getPosts() + 'Thanks.' ;
            emails.add(mail);
        }
        try{
            Messaging.SendEmailResult[] results = Messaging.sendEmail(emails,false);
            if (results[0].success){
                System.debug('The email was sent successfully.');
               	emailAmount++;
            }
        }catch (Exception e){
            System.debug('There was an error while sending the emails: ' + e.getMessage());
        }
    }
}