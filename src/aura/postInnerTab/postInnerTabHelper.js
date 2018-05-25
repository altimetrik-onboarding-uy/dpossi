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
                    post.Content__c = newContentValue;
                    action.setParams({
                        "content": newContentValue,
                        "post": post
                    });
                    action.setCallback(this, function(response){
                        var state = response.getState();
                        
                        if(state != 'SUCCESS'){
                            component.set("v.post", post);
                            console.log('There has been an error while saving the new content.');
                        }
                    });
					$A.enqueueAction(action);   
                }                
            }), 3000);
		component.set("v.intervalId", intervalId);        
    },
    
    ctrlPressed: function(component, event){
    	var key = event.key.toLowerCase();
        var target = event.target;
        var shift = event.shiftKey;
        var text = target.value;
        var back = target.selectionStart;
        var forward = target.selectionEnd;
        var finalText = text.substring(0, back);
        var fixCursor;
        
    	if(key == "b"){
            finalText += "****";
            fixCursor = 2;
		}
 		else if(key == "i"){
    		finalText += "**";
            fixCursor = 1;
		}
		else if(key == "q" && !shift){
            finalText += "``";
            fixCursor = 1;
        }
		else if(key == "l" && shift){
            finalText += "``````";
            fixCursor = 3;
        }
        
        finalText += text.substring(forward, text.length);
        document.getElementById("inputText").value = finalText;
        target.selectionStart = back+fixCursor;
        target.selectionEnd = forward+fixCursor;
	},
})