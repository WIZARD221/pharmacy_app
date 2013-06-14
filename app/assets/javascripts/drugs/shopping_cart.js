function addToCart(name, quantity, price, store){
	var itemList = $("table."+store);
	var item = "<tr class='cart-item'><td>"+name+"</td><td>"+quantity+"</td><td>"+price+"</td><td><button class='remove-button'" + 
			   "onClick=\"removeFromCart(this,'"+ store + "'," + price + ")\">X</button></td></tr>";
	$(itemList).append(item);
	incCartItems(store);
	$("p." + store).show();
	var checkOutsum = $("p#checkout_sum").html();
	$("p#checkout_sum").html(parseInt(checkOutsum) + parseInt(price) + "$")
}

function removeFromCart(cartItem, store, price){
	row = cartItem.parentNode.parentNode;
	$(row).remove();
	decCartItems(store);
	var checkOutsum = $("p#checkout_sum").html();
	$("p#checkout_sum").html(parseInt(checkOutsum) - price + "$")
}


function showBuyingOptions(id, store){
	hideBuyingOptions();
	$("button#" + id +"." + store + ".show-options").hide();
	$("button#" + id +"." + store + ".duration").show();
}

function hideBuyingOptions(){
	$("button.show-options").show();
	$("button.duration").hide();
}

function incCartItems(store){
	var numItems = $("#num_items");
	var numItemsVal = numItems.html();
	if(numItemsVal == "empty")
	{
		numItems.html("1");
	}
	else
	{
		numItems.html(parseInt(numItemsVal) + 1);
	}
	
	var storeNumItems = $(".num-items."+ store);
	var storeNumItemsVal = storeNumItems.html();
	
	if(storeNumItemsVal == ""){
		storeNumItems.html("1"); 
	}
	else{
		storeNumItems.html(parseInt(storeNumItemsVal) + 1);
	}
	
}

function decCartItems(store){
	var numItems = $("#num_items");
	var numItemsVal = numItems.html();
	if(numItemsVal == "1")
	{
		numItems.html("empty");
	}
	else
	{
		numItems.html(parseInt(numItemsVal) - 1);
	}
	
	var storeNumItems = $(".num-items."+ store);
	var storeNumItemsVal = storeNumItems.html();
	
	if(storeNumItemsVal == "1"){
		storeNumItems.html(""); 
	}
	else{
		storeNumItems.html(parseInt(storeNumItemsVal) - 1);
	}
	
}


