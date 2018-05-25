@isTest
public class TestPost_Status_To_Published {
    
    @isTest
    public static void testInicialStatusDraft(){   
        
        Contact writer = new Contact(LastName = 'test');
        insert writer;
        Contact newWriter = [SELECT ID FROM Contact WHERE LastName = 'test'];
        Post__c p = New Post__c(Title__c = 'test', Status__c = 'Draft', Content__c = 'test', Writer__c = newWriter.Id);
        insert p;

        Post__c post = [SELECT ID, Status__c FROM Post__c WHERE Status__c = 'Draft' LIMIT 1];
        
        Test.startTest();
        post.Status__c = 'Published';
        Database.SaveResult result = Database.update(post, false);
        Test.stopTest();
        
        System.debug('TEST ' + result.getErrors());
        
        for(Database.Error er: result.getErrors()){
        	System.assertEquals('There was an error.', er.getMessage());
        }
    }
    
	@isTest
    public static void testInicialStatusReady(){
        
        Contact writer = new Contact(LastName = 'test');
        insert writer;
        Contact newWriter = [SELECT ID FROM Contact WHERE LastName = 'test'];
        Post__c p = New Post__c(Title__c = 'test', Status__c = 'Ready', Content__c = 'test', Writer__c = newWriter.Id);
        insert p;
        Post__c post = [SELECT Id, Status__c , CreatedBy.Manager.Id FROM Post__c WHERE Status__c = 'Ready' LIMIT 1];
        User manager = [SELECT Id FROM User WHERE Id = :post.Id Limit 1];
        
        System.runAs(manager){
            Test.startTest();
            post.Status__c = 'Published';
            Database.SaveResult result = Database.update(post, false);
            Test.stopTest();
        	System.assert(result.isSuccess());
        }
    }   

}