$(document).ready(function() {
    $('#drug_table').dataTable({
    	"sDom": '<"top"fl>rt<"bottom"p><"clear">'
    });
    
    $("button.duration").hide();
} );


function Drug(name, form, conditions, tDayPrice, tDayQuantity, nDayPrice, nDayQuantity){
	this.name = name;
	this.form = form;
	this.conditions = conditions;
	this.tDayPrice = tDayPrice;
	this.tDayQuantity = tDayQuantity; 
	this.nDayPrice = nDayPrice;
	this.nDayQuantity = nDayQuantity;
}

Drug.createDrug = function(id){
	var name = $("#drug"+id+ " .name a")[0].innerHTML;
	var form = $("#drug"+id+ " .form")[0].innerHTML;
	var conditions = $("#drug"+id+ " .conditions")[0].innerHTML;
	var thirty_day_price = $("#drug"+id+ " .thirty_day_price")[0].innerHTML;
	var thirty_day_quantity = $("#drug"+id+ " .thirty_day_quantity")[0].innerHTML;
	var ninety_day_price = $("#drug"+id+ " .ninety_day_price")[0].innerHTML;
	var ninety_day_quantity = $("#drug"+id+ " .ninety_day_quantity")[0].innerHTML; 
	
	return new Drug(name, form, conditions, thirty_day_price, thirty_day_quantity, ninety_day_price, ninety_day_quantity);
}
