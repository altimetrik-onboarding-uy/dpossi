({
    saveContent : function(component) {
        var intervalId;

        intervalId = window.setInterval($A.getCallback(
            function() {
                console.log("INTERVALO");
		        var newContentValue = component.get("v.newContent");
        		var post = component.get("v.post");
                var action = component.get("c.saveContent");
                
                if(newContentValue != post.Content__c){
                    action.setParams({
                        "content": newContentValue,
                        "post": post
                    });
                    action.setCallback(this, function(response){
                        var state = response.getState();
                        
                        if(state != 'SUCCESS'){
                            console.log('There has been an error while saving the new content.');
                        }
                    });
					$A.enqueueAction(action);   
                }                
            }), 3000);
		component.set("v.intervalId", intervalId);        
    }
})