public with sharing class gnm_OppRedirectExtensions {



   private Opportunity Opp = new Opportunity();
   private User ThisUser;
  
   public gnm_OppRedirectExtensions(ApexPages.StandardController controller) {

        thisUser = [Select Id, Restrict_Opportunuties__c from User where Id = :Userinfo.getUserId() LIMIT 1];

        if (controller.getId() != null)
        {
            this.Opp = [select Id, Name, Ownerid from opportunity where Id = :controller.getId() LIMIT 1];
        } 
             
    }

   
  
  
    public pageReference doRedirect()
    {
    
        
        
        
        PageReference pr; 
        
        
         if (this.Opp.OwnerId !=   Userinfo.getUserId() && ThisUser.Restrict_Opportunuties__c)
             pr = new pageReference('/' + this.Opp.Id );    // GO BACK TO DEFAULT PAGE WHICH WE HAVE OVERRIDEN
         else
             pr = new pageReference('/' + this.Opp.Id + '/e?nooverride=1');    // SURE ! EDIT!
 
             
        
        for(string s : Apexpages.currentPage().getParameters().keySet())
        {
            pr.getParameters().put(s, Apexpages.currentPage().getParameters().get(s));
        }
        
        pr.setRedirect(true);
        return pr;
    
    }
    



}