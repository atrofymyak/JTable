var selected = [];
var searchResultItems = [];
var itemsToRemove = [];

function ProcessParties(obj, contextPath){
	var ids = "";
	
	var data = [];
	
	for(var i = 0; i< selected.length; i++){
		var selItem = selected[i];				
					
		var item = {};
		
		item.uniqueID = selItem.uniqueID;
		item.entityId = selItem.entityId;
		item.name = selItem.name;
		item.address = selItem.address;
		item.taxId = selItem.taxId;
		item.dateOfBirth = selItem.dateOfBirth;		
		
		data.push(item);
	}		
	
	$.ajax(
			{
				type:"POST",			
				url: contextPath + "/processData",
				dataType: "json",				
				contentType: "application/json; charset=UTF-8",
				data: JSON.stringify(data),
				success: function(result){
					console.log("done");
				}
			});
}

function RemoveParties(obj1, contextPath){
	var table1 = $('#tas').DataTable();
	table1.destroy();
	
	table1 = $('#tas').DataTable({	
  		"lengthMenu": [[3, 10, 15, -1], [5, 10, 15, "All"]],
	    data:selected,
	    searching: false,
	    ordering: false,
	    "order": [[ 1, "asc" ]],
	    columns: [	
	    	{			
	    		data:"active",
	    		width:"20px",
                render: function ( data, type, row ) {						                	
                    if ( type === 'display' ) {							                    	
                    	return '<input type="checkbox" class="editor-active" value="' + row.uniqueID + '" id="tableRemove_' + row.uniqueID + '" onClick="removeItem(this);" />';
                    }
                    return data;
                },
                className: "dt-body-center"
            },
		    { data: 'entityId', name: 'entityId', width: '145px'},
		    { data: 'name', name: 'name', width: '300px'},
		    { data: 'address', name: 'address', width: '500px'},
		    { data: 'taxId', name: 'taxId', width: '100px'},
		    { data: 'dateOfBirth', name: 'dateOfBirth', width: '100px'  }
	        //{ data: 'phone' }
	    ]
	});
	$('#tas_length').css("display", "none");
	
}

function ClearParties(obj1, contextPath)
{
	selected.length = 0;
	RemoveParties(obj1, contextPath);
}

function AddParties(obj1, contextPath){			
	
	var entityTypes = $("input[name='entityType']:checked");
	
	var individualInputs=[];
	var businessInputs = [];
	var addressInputs = [];
	
	if($(entityTypes).size() == 0){
		alert("Please select 'Business' or 'Individual'");
	}else{
		var entityType = $(entityTypes[0]).val();
		
		var data = "entityType=" + entityType + "&";
		
		if('002' == entityType){
			individualInputs = $("#NewIndividualTR" ).find("input[type='text']");		
			
			$.each(individualInputs, function(index, value){
				data += value.name + "=" + value.value + "&";
				if(value.value == ''){
					return;
				}
			});						
		}else if('001' == entityType){			
			businessInputs = $("#NewBusinessTR" ).find("input[type='text']");
			
			$.each(businessInputs, function(index, value){
				if(value.value == ''){
					return;
				}
				data += value.name + "=" + value.value + "&";
			});
		}
		
		data += "partyID=partyID" + Math.floor(Math.random() * 100) + "&";
		
				
		addressInputs = $("#AddressTR" ).find("input[type='text']");
		
		$.each(addressInputs, function(index, value){
			if(value.value == ''){
				return;
			}
			
			data += value.name + "=" + value.value + "&";
		});
						
			$.ajax(
					{
						url: contextPath + "/storeData", 
						data: data,
						dataType: "json",
						success: function(result){														
							
							$.each(individualInputs, function(index, value){									
								$(value).css("border","1px solid #669999");
							});
						
							$.each(businessInputs, function(index, value){
								$(value).css("border","1px solid #669999");								
							});
						
							$.each(addressInputs, function(index, value){
								$(value).css("border","1px solid #669999");
							});
														
							
							if(result.errors != null){									
								var errors = result.errors.split(",");																
								
								for(var i = 0; i < errors.length; i++){
									var error = errors[i];									
									
									$("#" + error).css("border","2px solid red");									
								}
								
							}else{
							
								$.each(individualInputs, function(index, value){
									value.value = "";
								});
							
								$.each(businessInputs, function(index, value){
									value.value = "";								
								});
							
								$.each(addressInputs, function(index, value){
									value.value = "";								
								});
							
								console.log(result);
								
								
								var counter = selected.length;
								$.each( result, function( key, val ){
									var table1 = $('#tas').DataTable();
									table1.destroy();
									
									var item = {};
															
									counter++;
									item.active="" + counter;									
										
									$.each(val, function(key1, val1)
									{								
										if(key1 == 'partyID')
										{
											item.entityId = val1;
										}
										else if(key1 == 'nameOther')
										{
											item.name = val1;
										}
										else if(key1=='addressLine1')
										{
											item.address = val1;
										}
										else if(key1 == 'taxID')
										{
											item.taxId = val1
										}
										else if(key1 == 'dateOfBirth')
										{
											item.dateOfBirth = val1
										}
										else if(key1 == 'phone')
										{
											item.phone = val1
										}
										else if(key1 == 'uniqueID')
										{
											item.uniqueID = val1;
										}
									});
									
									selected.push(item);
								});
								
								table1 = $('#tas').DataTable
								 ({	
								    data:selected,
							  		"lengthMenu": [[3, 10, 15, -1], [5, 10, 15, "All"]],
								    searching: false,
								    ordering: false,
//								    paging:false,
//								    info:false,
							  		columnDefs: [{orderable: false, className: 'select-checkbox', targets:   0}],
							  		select: {style: 'multi', selector: 'td:first-child'},
								    "order": [[ 1, "asc" ]],
								    columns: 
								    [
								     	{			
								    		data:"active",
								    		width: "20px",
							                render: function ( data, type, row ) 
							                {						
							                    if ( type === 'display' ) 
							                    {							                    	
							                        return '<input type="checkbox" class="editor-active" value="' + row.uniqueID + '" id="tableRemove_' + row.uniqueID + '" onClick="removeItem(this);" />';
							                    }
							                    return data;
							                },
							                className: "dt-body-center"
								     	},
									    { data: 'entityId', name: 'entityId', width: '145px'},
									    { data: 'name', name: 'name', width: '300px'},
									    { data: 'address', name: 'address', width: '500px'},
									    { data: 'taxId', name: 'taxId', width: '100px'},
									    { data: 'dateOfBirth', name: 'dateOfBirth', width: '100px'  }
								        //{ data: 'phone' }
								    ]
								 });
							$('#tas_length').css("display", "none");
								
								//SearchParties("Search", contextPath);
							}
						}
					});		
	}
			
}

function SelectParties(obj1,obj2)
{		
	var table = $('#searchResultsTable').DataTable();
	table.destroy();
	
	table = $('#searchResultsTable').DataTable
			({	
		  		"lengthMenu": [[3, 10, 15, -1], [5, 10, 15, "All"]],
		  		data:searchResultItems,
		  		columnDefs: [{orderable: false, className: 'select-checkbox', targets:   0}],
		  		select: {style: 'multi', selector: 'td:first-child'},
		  		order: [[ 1, 'asc' ]],											        
		  		columns: 
		  		[
			    	{			
			    		data:"active",
			    		width:"20px",
		                render: function ( data, type, row ) 
		                {						                	
		                    if ( type === 'display' ) 
		                    {
		                    	return '<input type="checkbox" class="editor-active" value="' + row.uniqueID + ' " id="table_' + row.uniqueID + '" onClick="selectItem(this);" />';
		                    }
		                    return data;
		                },
		                className: "dt-body-center"
		            },
				    { data: 'entityId', name: 'entityId', width: '145px'},
				    { data: 'name', name: 'name', width: '300px'},
				    { data: 'address', name: 'address', width: '500px'},
				    { data: 'taxId', name: 'taxId', width: '100px'},
				    { data: 'dateOfBirth', name: 'dateOfBirth', width: '100px'  }
			        //{ data: 'phone' }
			    ]
			});
	 		$('#searchResultsTable_length').css("display", "none");

	var table1 = $('#tas').DataTable();
	table1.destroy();
	
	table1 = $('#tas').DataTable
			 ({	
			    data:selected,
		  		"lengthMenu": [[3, 10, 15, -1], [5, 10, 15, "All"]],
			    searching: false,
			    ordering: false,
//			    paging:false,
//			    info:false,
		  		columnDefs: [{orderable: false, className: 'select-checkbox', targets:   0}],
		  		select: {style: 'multi', selector: 'td:first-child'},
			    "order": [[ 1, "asc" ]],
			    columns: 
			    [
			     	{			
			    		data:"active",
			    		width: "20px",
		                render: function ( data, type, row ) 
		                {						
		                    if ( type === 'display' ) 
		                    {							                    	
		                        return '<input type="checkbox" class="editor-active" value="' + row.uniqueID + '" id="tableRemove_' + row.uniqueID + '" onClick="removeItem(this);" />';
		                    }
		                    return data;
		                },
		                className: "dt-body-center"
			     	},
				    { data: 'entityId', name: 'entityId', width: '145px'},
				    { data: 'name', name: 'name', width: '300px'},
				    { data: 'address', name: 'address', width: '500px'},
				    { data: 'taxId', name: 'taxId', width: '100px'},
				    { data: 'dateOfBirth', name: 'dateOfBirth', width: '100px'  }
			        //{ data: 'phone' }
			    ]
			 });
		$('#tas_length').css("display", "none");
}

function removeItem(obj){
	var id = $(obj).val();
		
	
	for(var i = 0; i < selected.length; i++){
		var item = selected[i];
		
		if((parseInt(item.uniqueID)) == (parseInt(id))){
			
			if($(obj).prop('checked')){
				itemsToRemove.push(item);
				selected.splice(i, 1);
			}
			
			break;
		}
	}
	
}


function SearchResultItem ( entityId, name, address, taxId, dateOfBirth, phone ) 
{
    this.entityId = entityId;
    this.name = name;
    this.address = address;
    this.taxId = taxId;
    this.dateOfBirth = dateOfBirth;
    this.phone = phone;
}

function SearchParties(type, contextPath)
{	
	
	var entityTypes = $("input[name='entityType']:checked");
	
	if($(entityTypes).size() == 0)
	{
		alert("Please select 'Business' or 'Individual'");
	}
	else
	{	
		var entityType = $(entityTypes[0]).val();		
		var data = "entityType=" + entityType + "&";
		if('001' == entityType)
		{
			if($("#dateOfIncorporation").val() == '')
			{
				alert("Please fill Date Of Incorporation");
				return;
			}
			
			if($("#businessName").val() == '')
			{
				alert("Please fill Business Name");
				return;
			}
			
			data += "dateOfIncorporation=" +  $("#dateOfIncorporation").val() + "&";
			data += "businessName=" +  $("#businessName").val();
		}
		else if('002' == entityType)
		{
			if($("#dateOfBirth").val() == '')
			{
				alert("Please fill Date Of Birth");
				return;
			}
			
			if($("#partyName").val() == '')
			{
				alert("Please fill Party Name");
				return;
			}
			
			data += "dateOfIncorporation=" +  $("#dateOfBirth").val() + "&";
			data += "businessName=" +  $("#partyName").val();			
		}
		$('#searchResultsTable').hide();
		$("#searchResultsTableSelect").hide();
		$('#example-select-all').prop('checked', false);
		var table = $('#searchResultsTable').DataTable();
		table.destroy();	
				
		searchResultItems.length = 0;
		$.ajax(
		{
			url: contextPath + "/test", 
			data: data,
			dataType: "json",
			success: function(result)
			{
				var items = [];var counter = 0;
				$.each( result, function( key, val ) 
				{
					var table = $('#searchResultsTable').DataTable();
					table.destroy();
					
					var item = {};
													
					item.active="" + counter;
					counter++;
						
					$.each(val, function(key1, val1)
					{								
						if(key1 == 'partyID')
						{
							item.entityId = val1;
						}
						else if(key1 == 'nameOther')
						{
							item.name = val1;
						}
						else if(key1=='addressLine1')
						{
							item.address = val1;
						}
						else if(key1 == 'taxID')
						{
							item.taxId = val1
						}
						else if(key1 == 'dateOfBirth')
						{
							item.dateOfBirth = val1
						}
						else if(key1 == 'phone')
						{
							item.phone = val1
						}
						else if(key1 == 'uniqueID')
						{
							item.uniqueID = val1;
						}
					});
					
					items.push(item);	
					searchResultItems.push(item);
				});
				table = $('#searchResultsTable').DataTable(
				{	
					"lengthMenu": [[3, 10, 15, -1], [5, 10, 15, "All"]],
					data:searchResultItems,								    
					columnDefs: 
					[ 
					 	{
				            orderable: false,
				            className: 'select-checkbox',
				            targets:   0
				        } 
					 ],
				     select: {style: 'multi', selector: 'td:first-child'},
				     order: [[ 1, 'asc' ]],											        
					 columns: 
					 [
					  	{
					  		data:"active",
					  		width: "20px",
				            render: function ( data, type, row ) 
				            {						                	
				            	if ( type === 'display' ) 
				            	{
				            		return '<input type="checkbox" class="editor-active" value="' + row.uniqueID + ' " id="table_' + row.uniqueID + '" onClick="selectItem(this);" />'; 
				            	}
				                return data;
				            },
				            className: "dt-body-center"
				        },
					    { data: 'entityId', name: 'entityId', width: '145px'},
					    { data: 'name', name: 'name', width: '300px'},
					    { data: 'address', name: 'address', width: '500px'},
					    { data: 'taxId', name: 'taxId', width: '100px'},
					    { data: 'dateOfBirth', name: 'dateOfBirth', width: '100px'  }
					        //{ data: 'phone' }
					]
				});
					$('#searchResultsTable_length').css("display", "none");
					$("#searchResultsTable").show();
					$("#searchResultsTableSelect").show();
					$('#example-select-all').on('click', function(){
				        // Get all rows with search applied							 
				    var rows = table.rows({ 'search': 'applied' }).nodes();
				        // Check/uncheck checkboxes for all rows in the table
				    $('input[type="checkbox"]', rows).prop('checked', this.checked);
				});
			}
		});
	}
}

function selectItem(obj){
	var id = obj.value;
	
	var index = -1;
	
	for(var i = 0; i < searchResultItems.length; i++){
		var item = searchResultItems[i];
		
		if((parseInt(item.uniqueID)) == (parseInt(id))){
			
			if($(obj).prop('checked')){
				selected.push(item);
	            searchResultItems.splice(i, 1);
			}
			
			break;
		}
	}
	
}

function checkEntry() {
	if (document.forms[0].userID.value == "") {
		return false;
	}
	if (document.forms[0].password.value == "") {
		return false;
	}
	document.forms[0].RequestID.value = "Authenticate";
	document.forms[0].ProcessID.value = "MainMenu";
	document.forms[0].submit();
	return true;
}
function resetEntry() {
	document.forms[0].txtUserId.value = "";
	document.forms[0].txtPassword.value = "";
	return false;
}
function submitRequest(sRequestID, sMenuName) {
	document.forms[0].RequestID.value = "";
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].LevelZeroMenu.value = sMenuName;
	document.forms[0].submit();
	return true;
}
function submitActionRequest(sRequestID) {
	document.forms[0].RequestID.value = sRequestID;
	// document.forms[0].RequestID.value = "";
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].submit();
	return true;
}
function submitActionRequest(sRequestID, sRequestType) {
	document.forms[0].RequestID.value = sRequestID;
	document.forms[0].RequestType.value = sRequestType;
	// document.forms[0].RequestID.value = "";
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].submit();
	return true;
}
function submitMenuRequest(sRequestID, sRequestor) {
	document.forms[0].RequestID.value = sRequestID;
	document.forms[0].Requestor.value = sRequestor;
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].submit();
	return true;
}
function submitLeftMenuRequest(sRequestID) {
	document.forms[0].RequestID.value = sRequestID;
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].submit();
	return true;
}

function hideshowControls(sArgument, sControl2HideShow, sListOfValues) {
	var sCurrentlyVisible = "visible" + sControl2HideShow;
	var sCurrentlyVisibleValue = document.getElementById(sCurrentlyVisible).value;
	if (null == sCurrentlyVisibleValue || sCurrentlyVisibleValue == "") {

	} else {
		document.getElementById(sCurrentlyVisibleValue).style.display = "none";
	}
	document.getElementById(sCurrentlyVisible).value = sControl2HideShow
			+ sArgument;
	document.getElementById(sControl2HideShow + sArgument).style.display = "";

	return true;
}
function hideshowControls2(sArgument, sControl2HideShow, sListOfValues) {
	var sCurrentlyVisibleValue = document.getElementById("CurrentlyVisible").value;
	if (null == sCurrentlyVisibleValue || sCurrentlyVisibleValue == "") {

	} else {
		document.getElementById(sCurrentlyVisibleValue).style.display = "none";
	}
	document.getElementById("AddressTR").style.display = "none";
	document.getElementById("CurrentlyVisible").value = sControl2HideShow;
	document.getElementById(sControl2HideShow).style.display = "";

	return true;
}
function hideshowControls3(sArgument, sControl2HideShow, sListOfValues) {
	var sCurrentlyVisibleValue = document.getElementById("CurrentlyVisible").value;
	if (null == sCurrentlyVisibleValue || sCurrentlyVisibleValue == "") {

	} else {
		document.getElementById(sCurrentlyVisibleValue).style.display = "none";
	}
	document.getElementById("CurrentlyVisible").value = sControl2HideShow;
	document.getElementById(sControl2HideShow).style.display = "";
	document.getElementById("AddressTR").style.display = "";
	return true;
}
function hideshowControls4(sArgument, sControl2HideShow, sListOfValues) {
	document.getElementById("CurrentlyVisible").value = "";
	document.getElementById("addressCity").value = "";
	document.getElementById("addressLine1").value = "";
	document.getElementById("addressLine2").value = "";
	document.getElementById("citizenship").value = "";
	document.getElementById("countryName").value = "";
	document.getElementById("dateOfBirth").value = "";
	document.getElementById("documentID").value = "";
	document.getElementById("issuedBy").value = "";
	document.getElementById("nameFirst").value = "";
	document.getElementById("nameLast").value = "";
	document.getElementById("nameMiddle").value = "";
	document.getElementById("nameOther").value = "";
	document.getElementById("postalCode").value = "";
	document.getElementById("residency").value = "";
	document.getElementById("stateProvince").value = "";
	document.getElementById("stockSymbol").value = "";
	document.getElementById("stockSymbolParent").value = "";
	document.getElementById("taxID").value = "";
	document.getElementById("typeOfID").value = "";
	document.getElementById("nameCompany").value = "";
	document.getElementById("parentCompany").value = "";
	document.getElementById("businessName").value = "";
	document.getElementById("partyName").value = "";
	var ele = document.getElementsByName("entityType");
	for (var i = 0; i < ele.length; i++)
		ele[i].checked = false;

	document.getElementById("BusinessEntityTR").style.display = "none";
	document.getElementById("IndividualTR").style.display = "none";
	document.getElementById("NewBusinessTR").style.display = "none";
	document.getElementById("NewIndividualTR").style.display = "none";
	document.getElementById("AddressTR").style.display = "none";
	return true;
}
function submitEditRequest(sRequestID, sRequestType, sPassThruParameters) {
	// alert("I am in EditRequest");
	// document.forms[0].RequestID.value = sRequestID;
	document.forms[0].RequestType.value = sRequestType;
	document.forms[0].PassThruParameters.value = sPassThruParameters;
	// document.forms[0].RequestID.value = "";
	document.forms[0].ProcessID.value = sRequestID;
	document.forms[0].submit();
	return true;
}
