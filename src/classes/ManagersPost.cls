public class ManagersPost {

    String email;
    String lstPosts = '';
    
    public ManagersPost(String email){
        this.email = email;
    }
    
    public String getPosts(){
        return lstPosts;
    }
    public void setPost(Post__c post){
        lstPosts += ' '+post.Id+', /n';
    }    
    public String getEmail(){
        return email;
    }
}