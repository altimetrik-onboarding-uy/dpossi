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
                component.set("v.newContent", post.Content__c);
                helper.saveContent(component); 
            }else{
                console.log("Failed "+ state);
            }
        });
        $A.enqueueAction(action);
    },
    
    update : function (component, event, helper) {
		var intervalId = component.get("v.intervalId");  
        if(intervalId != "") {
            window.clearInterval(intervalId);
            component.set("v.intervalId", "");
        }
    },
    
    onTextUpdated: function(component, event, helper){
        var texto = component.get("v.newContent");
        component.set("v.textChanged", marked(texto));
    }
})