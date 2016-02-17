//#
//# TEST CLASS
//#
@isTest
private class TestHandleProductPriceChange {

    static testMethod void myUnitTest() 
    {
        
        //#
        //# Setup a new invoice
        //#
        Invoice_Statement__c invoice = new Invoice_Statement__c(Status__c = 'Negotiating', Description__c = 'Unit test');
        insert invoice;
        
        
        //#
        //# Setup new products (merch)
        //#
        Merchandise__c[] products = new Merchandise__c[] {
	        new Merchandise__c(Name = 'Item 1', Description__c = 'test prod1', Price__c = 10, Inventory__c = 10),
	        new Merchandise__c(Name = 'Item 2', Description__c = 'test prod2', Price__c = 11, Inventory__c = 11)
       	
        };
       insert products;  
        	
       //#
       //# Now setup the line items to use these products....
       //#
       Line_Item__c[] lineItems = new Line_Item__c[] {
       		new Line_Item__c(Invoice_Statement__c = invoice.id, Merchandise__c = products[0].id, Unit_Price__c = 10, Units_Sold__c = 3),  
       		new Line_Item__c(Invoice_Statement__c = invoice.id, Merchandise__c = products[1].id, Unit_Price__c = 11, Units_Sold__c = 6)
       };       	
       insert lineItems;
         
        //#
        //# Setup Complete... now start the test
        //#
        products[0].Price__c = 20;
        products[1].Price__c = 5;
        Test.startTest();
        update products;
        Test.stopTest();
        
        //#
        //# Now get the results and see what happened
        //#
        lineItems = [Select Id, unit_price__c FROM Line_Item__c WHERE id IN :lineItems]; 
        system.assert(lineItems[0].unit_price__c == 10 );
         
         
    }
    
}