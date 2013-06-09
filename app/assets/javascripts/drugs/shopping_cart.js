function addToCart(name, quantity, price, store){
	var itemList = $("table."+store);
	var item = "<tr><td>"+name+"</td><td>"+quantity+"</td><td>"+price+"</td></tr>";
	$(itemList).append(item);
}

function showBuyingOptions(id, store){
	
	var drug = Drug.createDrug(id);
	var storeButton = $("tr#" + id + " td.stores button." + store)[0];
	var options =   $(".btn-group."+store);
	if(drug.tDayPrice != ""){
		$(options).append("<button class='"+ store +"'>30 Day</button>");
	}
	if(drug.nDayPrice != ""){
		$(options).append("<button class='"+ store +"'>90 Day</button>");
	}
	
	
	
}
