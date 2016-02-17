//#
//# new Page Controller Class for Storefront!! BLAH!!!
//#
public class StoreFront {

	//#
	//# Vars
	//#
    public String message { get; set; }
	DisplayMerchandise[] products;


	//#
	//# INternal class for display purposes
	//#
    public class DisplayMerchandise
    {
        public Merchandise__c merchandise {get; set;}
        public Decimal count {get; set;}
        //#
        //# Ctor for internal class
        //#
        public DisplayMerchandise( Merchandise__c item)             
        {
            this.merchandise = item;        
        } 
    }


    

	//#
	//# getProducts used when the apex page uses the public "Products" property/method
	//#  from controller
	//#
    public DisplayMerchandise[] getProducts()
    {
        if (products == null)
        {
            products = new DisplayMerchandise[]{};
            for (Merchandise__c item :
                 [SELECT Id,name, Description__c, price__c
                 FROM Merchandise__c
                 WHERE Inventory__c > 0])
            {
                products.add(new DisplayMerchandise(item));
            }
        }    
                
        return products;
    }


	//#
	//# Action invoked from page when action = {!shop} is used on a
	//# button / postbacl event.
	//#	
    public Pagereference shop()
    {
    
        message = 'You bought: ';
        for (DisplayMerchandise p: products)
        {
            if (p.count > 0)
            {
                message += p.merchandise.name + ' (' + p.count + ')  ' ;
            }
        }
        
        return null;
    
    }



}