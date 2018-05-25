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
                
                var texto = document.getElementById("inputText").value = post.Content__c;
                component.set("v.newContent", texto);
                component.set("v.textChanged", marked(texto));
                
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
        var texto = document.getElementById("inputText").value;
        component.set("v.newContent", texto);
        component.set("v.textChanged", marked(texto));
    }, 
    
    getKeyPressed :function(component, event, helper) { 
        console.log("evento "+event);
        var ctrl = event.ctrlKey;
        if(ctrl){
            helper.ctrlPressed(component, event);
        }
    } 
})