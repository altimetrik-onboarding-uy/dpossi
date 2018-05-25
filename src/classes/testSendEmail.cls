@isTest
private class testSendEmail {
    @testSetup 
    static void setup() {
        List<Post__c> lstPost = new List<Post__c>();
        Contact c = new Contact(LastName = 'Name');
        insert c;
        
        for (Integer i=0;i<10;i++) {
            Post__c p = new Post__c(
                Writer__c = c.Id,
            	Status__c= 'Under Review', 
                Tags__c = ' ', 
                Title__c = 'Test' + i, 
                Content__c = 'Content test' 
            );
            lstPost.add(p);
        }
        insert lstPost;
    }

    public static testmethod void test() {        
       	Test.startTest();
           sendEmail send = new sendEmail();
           Id batchId = Database.executeBatch(send);
        Test.stopTest();
        System.debug('EMAIL AMOUNT'+send.emailAmount);
        System.assert(send.emailAmount > 0);
    }
    
}