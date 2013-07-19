$(document).ready(function() {
    $("header").hide();
    sortDrugs();
    window.print();
} );

function sortDrugs()
{
	var items = $("table#temp_table .item");
	var numItems = items.length;
	
	for (var i=0; i < numItems; i++) {
	  var store = $(items[i]).find(".store")[0].innerHTML;
	  var storeTable =  $("table." + store);
	  
	  storeTable.append(items[i]);
	};
}
