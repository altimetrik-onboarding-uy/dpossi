@isTest
public class testPostInnerTab {
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
                Title__c = 'Test ' + i, 
                Content__c = 'Content test' 
            );
            lstPost.add(p);
        }
        insert lstPost;
    }
    
    @isTest
    private static void testGetPostTrue(){
        Post__c postSelected = [SELECT Id, Content__c, Status__c FROM Post__c WHERE Title__c = 'Test 0' LIMIT 1];
        
        Test.startTest();
        	Post__c postReturned = postInnerTab.getPost(postSelected.Id);
        Test.stopTest();
        
        System.assertEquals(postSelected, postReturned);
    }
    
    @isTest
    private static void testSetContent(){
        Post__c postSelected = [SELECT id, content__c FROM Post__c WHERE Title__c = 'Test 0' LIMIT 1];
        
        Test.startTest();
        	postInnerTab.saveContent('NEW CONTENT', postSelected);
        Test.stopTest();
        
        Post__c postReturned = [SELECT id, content__c FROM Post__c WHERE Title__c = 'Test 0' LIMIT 1];
        System.assertEquals('NEW CONTENT', postReturned.Content__c);
    }
}