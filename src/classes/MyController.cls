public with sharing class MyController {

    private transient Opportunity[] stuff; 
    public  string MyData {get;set;}

    public PageReference DoIt() {
        
        SYSTEM.Debug(LoggingLevel.Info,'>>>>>>>>>> DO IT!<<<<<<<<<');
        this.MyData = String.valueOf( DateTime.Now());
        
        
        return null;
    }


    public Opportunity[] getStuff() {
    
    
        SYSTEM.Debug(LoggingLevel.Info,'>>>>>>>>>> GETTING STUFF!<<<<<<<<<');
        if (stuff == null)
        {
            SYSTEM.Debug(LoggingLevel.Info,'>>>>>>>>>> GETTING STUFF FROM SOQL<<<<<<<<<');
            stuff =  [select Id,Name from Opportunity LIMIT 1000] ;        
        }
        else
        {
            SYSTEM.Debug(LoggingLevel.Info,'>>>>>>>>>> USING STUFF FROM VARIABLE <<<<<<<<<');
        }
        return stuff;
    

    }

}