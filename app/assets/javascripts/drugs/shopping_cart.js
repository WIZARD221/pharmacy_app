function addToCart(name, quantity, price, store){
	var itemList = $("table."+store);
	var item = "<tr class='cart-item'><td class='name'>"+name+"</td><td class='quantity'>"+quantity+"</td><td class='price'>"+price+"</td><td display='none' class='store hidden'>" + store + "</td><td class='options'><button class=' btn remove-button'" + 
			   "onClick=\"removeFromCart(this,'"+ store + "'," + price + ")\"><i class='icon-remove'></i></button></td></tr>";
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
	var numItems = $("#num-items");
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
		$("table." + store).show();	
	}
	else{
		storeNumItems.html(parseInt(storeNumItemsVal) + 1);
	}
	
}

function decCartItems(store){
	var numItems = $("#num-items");
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
		$("table." + store).hide();
		$("p." + store).hide();
	}
	else{
		storeNumItems.html(parseInt(storeNumItemsVal) - 1);
	}
}

function createShoppingCartJson(){
	var shoppingCartList = {"drugs":[], "stores":[]};
	var cartItems = $("div#shopping_cart tr.cart-item");
	var numCartItems = cartItems.length;
	
	for(var i = 0; i < numCartItems; i++ ){
		
		var drugName = $(cartItems[i]).find(".name")[0].innerHTML;
		var quantity = $(cartItems[i]).find(".quantity")[0].innerHTML;
		var price = $(cartItems[i]).find(".price")[0].innerHTML;
		var store = $(cartItems[i]).find("td.store")[0].innerHTML;
		
		shoppingCartList.drugs.push({"name":drugName, "quantity":quantity, "price":price, "store": store});
	}
	
	var stores = $("p.store");
	var numStores = stores.length;
	
	for(var i=0; i<numStores; i++){
		var storeName = stores[i].innerHTML;
		shoppingCartList.stores.push({"name":storeName});
	}
	
	$("#shopping_cart input#drugList").val(JSON.stringify(shoppingCartList));
}


















