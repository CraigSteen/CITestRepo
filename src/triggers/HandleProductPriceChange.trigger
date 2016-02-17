trigger HandleProductPriceChange on Merchandise__c (after update) {
//#
//# Trigger to update all invoices lines with a header status of Negotiating
//# to have new item line prices if the product prices have dropped when this
//# merchandise item is updated
//#


	//#
	//# Create a list of line items
	//#
	List<Line_Item__c> openLineItems = 
		[
			SELECT j.Unit_Price__c, j.Merchandise__r.Price__c  		
			FROM Line_Item__c j
			WHERE j.Invoice_Statement__r.Status__c = 'Negotiating'
			AND  j.Merchandise__r.id IN :Trigger.new FOR UPDATE
		];
	
	
	//#
	//# Walk through the list and update the lines with the item price
	//#
	for (Line_Item__c li : openLineItems)
	{
		if (li.Merchandise__r.Price__c < li.Unit_Price__c)
		{
			li.Unit_Price__c = li.Merchandise__r.Price__c;
		}	
	}

	//#
	//# Now issue the update
	//#
	update openLineItems;

}