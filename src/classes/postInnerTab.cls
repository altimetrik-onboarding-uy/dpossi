public class postInnerTab {
	
	@AuraEnabled
    public static Post__c getPost(String postId){
        return [SELECT Id, Content__c, Status__c FROM Post__c WHERE Id = :postId];
    }
    
    @AuraEnabled 
    public static void saveContent(String content, Post__c post){
        post.Content__c = content;
        update post;
    }
}