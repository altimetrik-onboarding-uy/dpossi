({
	doInit: function(component, event, helper){
        var action = component.get("c.getPost");
        action.setParams({
            "postId": component.get("v.recordId")
        });

        action.setCallback(this, function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                component.set("v.post", response.getReturnValue());
                var post = component.get("v.post");
                console.log(post.Status__c);
				component.set("v.currentStatus", post.Status__c);
                console.log("Status "+component.get("v.currentStatus"));
            }else{
                console.log("Failed "+ state);
            }
        });
        $A.enqueueAction(action);
    },

})