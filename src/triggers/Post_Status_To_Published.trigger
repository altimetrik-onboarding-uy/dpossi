trigger Post_Status_To_Published on Post__c (before update) {

    for(Post__c c: Trigger.new){
        if(c.Status__c == 'Published'){
            Post__c oldPost = Trigger.oldMap.get(c.ID);
            if(oldPost.Status__c != 'Ready'){
                c.AddError('There was an error.');
            }
            else{
                c.Published_Date__c = date.today();
            }
        }
    }
}