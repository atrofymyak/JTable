<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.util.*" %>

<%
	String 	 sIdentifier	=	"";
	String	 sIdentifierType		=	"";
	int		 iIdx1			=	0;

	HashMap<String, HashMap<String,String>> hmAvailableParties	= 	new HashMap<String, HashMap<String,String>>();	
	HashMap<String,String> hmPartyInfo							= 	new HashMap<String,String>();	
	Map <String, HashMap<String,String>> mListOfParties			=	new TreeMap<String, HashMap<String,String>>(hmAvailableParties);
	Set<String>		 sObjectLevel1;
	Iterator<String> iObjectLevel1;
	Set<String>		 sObjectLevel2;
	Iterator<String> iObjectLevel2;
	int		iCtr		=	0;
	
	String	sPartySortField		=	"";
	String	sName				=	"";
	String	sAddress			=	""; 
	String	sSSN				=	"";
	String 	sSSNForDisplay		=	"";
	String	sDateofBirth		=	"";
	String	sPhone				=	"";
	int		iColorType			=	0;
	String	sColorCode			=	"";
%>


<script type="text/javascript" src="js/jquery/jquery.min.js"></script>
<script type="text/javascript" src="js/jquery-ui-1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/dataTables.select.min.js"></script>
<script type="text/javascript" src="js/base.js"></script>
<style>@IMPORT url("css/Main.css");</style>
<link rel="stylesheet" href="css/jquery-ui.css">
<link rel="stylesheet" href="css/jquery.dataTables.min.css">
						<div class="NewAccountSection">
							<input type="hidden" name="CurrentlyVisible" id="CurrentlyVisible" value=""></input>
							<table width="1300" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
								<tr valign="top">
									<td width="0005" rowspan="99"></td>
									<td width="1290"></td>
									<td width="0005" rowspan="99"></td>
								</tr>
								<tr>
									<td width="1290" height="10"></td>
								</tr>
								<tr valign="center">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="labelText" align="right">Entity Type:</td>
												<td width="015">
													<input name="entityType" type="radio" value="001" OnClick="hideshowControls2('001', 'BusinessEntityTR',null)" ></input>
												</td>
												<td width="110" align="center"><div class="roundedCorner">Business</div></td>
												<td width="015">
													<input name="entityType" type="radio" value="002" OnClick="hideshowControls2('002', 'IndividualTR','')" ></input>
												</td>
												<td width="110" align="center"><div class="roundedCorner">Individual</div></td>
												<td width="890"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td width="1290" height="4"></td>
								</tr>
								<tr id="BusinessEntityTR" style="display: none;" valign="top">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="labelText" align="right">Date Incorporated:</td>
												<td width="150"><input type="text" class="TEXT" name="dateOfIncorporation" id="dateOfIncorporation" size="10" maxlength="15"></td>
												<td width="150" class="labelText" align="right">Business Name:</td>
												<td width="840"><input type="text" class="TEXT" name="businessName" id="businessName" size="70" maxlength="70"></td>
											</tr>
											<tr>
												<td width="150"></td>
												<td width="150"></td>
												<td width="150"></td>
												<td width="840">
													<table width="840" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
														<tr>
															<td width="720"></td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="SearchParties('Search', '<%=request.getContextPath()%>')">Search</div>
															</td>	
															<td width="020" align="center">|</td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="hideshowControls3('Create', 'NewBusinessTR')">Create</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								<tr>
								<tr id="IndividualTR" style="display: none;" valign="top">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="150" class="labelText" align="right">Date of Birth:</td>
												<td width="150"><input type="text" name="dateOfBirth" id="dateOfBirth" class="TEXT" size="10" maxlength="15"></td>
												<td width="150" class="labelText" align="right">Party Name:</td>
												<td width="840"><input type="text" class="TEXT" name="partyName" id="partyName" size="70" maxlength="70"></td>
											</tr>
											<tr>
												<td width="150"></td>
												<td width="150"></td>
												<td width="150"></td>
												<td width="840">
													<table width="840" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
														<tr>
															<td width="720"></td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="SearchParties('Search', '<%=request.getContextPath()%>')">Search</div>
															</td>	
															<td width="020" align="center">|</td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="hideshowControls3('Create', 'NewIndividualTR')">Create</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="NewBusinessTR" style="display: none;" valign="top">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="160" class="labelText" align="right">Name:</td>
												<td width="700"><input type="text" class="TEXT" name="nameCompany" id="nameCompany" size="80" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Stock Symbol:</td>
												<td width="270"><input type="text" class="TEXT" name="stockSymbol" id="stockSymbol" size="15" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="4" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Parent Company:</td>
												<td width="700"><input type="text" class="TEXT" name="parentCompany" id="parentCompany" size="80" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Stock Symbol:</td>
												<td width="270"><input type="text" class="TEXT" name="stockSymbolParent" id="stockSymbolParent" size="15" maxlength="50"></input></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="NewIndividualTR" style="display: none;" valign="top">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="160" class="labelText" align="right">First Name:</td>
												<td width="270"><input type="text" class="TEXT" name="nameFirst" id="nameFirst" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Last Name:</td>
												<td width="270"><input type="text" class="TEXT" name="nameLast" id="nameLast" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Middle Name:</td>
												<td width="270"><input type="text" class="TEXT" name="nameMiddle" id="nameMiddle" size="30" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Other Name:</td>
												<td width="270"><input type="text" class="TEXT" name="nameOther" id="nameOther" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Date Of Birth:</td>
												<td width="270"><input type="text" class="TEXT" name="dateOfBirth" id="dateOfBirthAdd" size="20" maxlength="50"></input></td>
												<td width="160"></td>
												<td width="270"></td>
											</tr>
										</table>
									</td>
								</tr>
								<tr id="AddressTR" style="display: none;" valign="top">
									<td width="1290">
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Country:</td>
												<td width="270"><input type="text" class="TEXT" name="countryName" id="countryName" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Address Line 1:</td>
												<td width="270"><input type="text" class="TEXT" name="addressLine1" id="addressLine1" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">address Line 2:</td>
												<td width="270"><input type="text" class="TEXT" name="addressLine2" id="addressLine2" size="30" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">City:</td>
												<td width="270"><input type="text" class="TEXT" name="addressCity" id="addressCity" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">State-Province:</td>
												<td width="270"><input type="text" class="TEXT" name="stateProvince" id="stateProvince" size="30" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Postal Code:</td>
												<td width="270"><input type="text" class="TEXT" name="postalCode" id="postalCode" size="30" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Citizenship:</td>
												<td width="270"><input type="text" class="TEXT" name="citizenship" id="citizenship" size="20" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Residency:</td>
												<td width="270"><input type="text" class="TEXT" name="residency" id="residency" size="20" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Tax ID:</td>
												<td width="270"><input type="text" class="TEXT" name="taxID" id="taxID" size="20" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Document ID:</td>
												<td width="270"><input type="text" class="TEXT" name="documentID" id="documentID" size="20" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">ID Type:</td>
												<td width="270"><input type="text" class="TEXT" name="typeOfID" id=typeOfID size="20" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">IssuedBy:</td>
												<td width="270"><input type="text" class="TEXT" name="issuedBy" id="issuedBy" size="20" maxlength="50"></input></td>
											</tr>
											<tr>
												<td width="1290" colspan="6" height="4"></td>
											</tr>
											<tr>
												<td width="160" class="labelText" align="right">Issue Country:</td>
												<td width="270"><input type="text" class="TEXT" name="issueCountry" id="issueCountry" size="20" maxlength="50"></input></td>
												<td width="160" class="labelText" align="right">Contact Phone:</td>
												<td width="270"><input type="text" class="TEXT" name="contactPhone" id="contactPhone" size="15" maxlength="15"></input></td>
												<td width="160"></td>
												<td width="270"></td>
											</tr>
											<tr>
												<td width="160"></td>
												<td width="270"></td>
												<td width="160"></td>
												<td width="700" colspan="3">
													<table width="700" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
														<tr>
															<td width="680"></td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="AddParties('Add', '<%=request.getContextPath()%>')">Add</div>
															</td>	
															<td width="020" align="center">|</td>
															<td width="050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="hideshowControls4('Cancel', '')">Cancel</div>
															</td>
														</tr>
													</table>
												</td>
											</tr>
										</table>
									</td>
								<tr>
							</table>
							<!-- Search Results  -->
							<table width="1300" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" id="searchResultsTableSelect">
								<tr>
									<td width="0005" bgcolor="#FFFFFF" rowspan="99"></td>
									<td width="1290" height="20"></td>
									<td width="0005" bgcolor="#FFFFFF" rowspan="99"></td>
								</tr>
								<tr>
									<td width="1290" height="20" align="right">		
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="1000">
													<div class="bankGridHeader">Search Results</div>
												</td>
												<td width="0290" align="right">
													<div class="specialHREF" style="cursor: pointer" onClick="SelectParties('Select', '')">Select</div>
												</td>
											</tr>
										</table>		
									</td>
								</tr>
							</table>
							<table id="searchResultsTable" width="1300" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" class="cell-border stripe">	
								<thead>
            						<tr>
            							<th width="020"><input type="checkbox" name="select_all" value="1" id="example-select-all"></th>
                						<th width="145">Entity ID</th>
                						<th width="300">Name</th>
                						<th width="500">Address</th>
                						<th width="100">Tax ID</th>
                						<th width="100">Date Of Birth</th>                						
            						</tr>
        						</thead>									
							</table>
							<!-- Selected Customers  -->
							<table width="1300" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
								<tr>
									<td width="0005" bgcolor="#FFFFFF" rowspan="99"></td>
									<td width="1290" height="20"></td>
									<td width="0005" bgcolor="#FFFFFF" rowspan="99"></td>
								</tr>
								<tr>
									<td width="1290" height="20" align="right">		
										<table width="1290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
											<tr>
												<td width="1000">
													<div class="bankGridHeader">Selected Parties</div>
												</td>
												<td width="0290" align="right">
													<table width="0290" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0">
														<tr>
															<td width="0100" align="right"></td>												
															<td width="0050" align="center">
																<div class="specialHREF" style="cursor: pointer" onClick="ProcessParties('Process', '<%=request.getContextPath()%>')">Process</div>
															</td>
															<td width="0020" align="center">|</td>
															<td width="0050" align="center">
																<div class="specialHREF" style="cursor: pointer" onClick="ClearParties('Clear', '<%=request.getContextPath()%>')">Clear</div>
															</td>
															<td width="0020" align="center">|</td>
															<td width="0050" align="right">
																<div class="specialHREF" style="cursor: pointer" onClick="RemoveParties('Remove', '<%=request.getContextPath()%>')">Remove</div>
															</td>
														</tr>
													</table>		
												</td>
											</tr>
										</table>		
									</td>
								</tr>
							</table>
							
							<table id="tas" width="1300" bgcolor="#FFFFFF" cellspacing="0" cellpadding="0" class="cell-border">
							<thead>
            						<tr>   
            							<th width="020"><input type="checkbox" name="select_all" value="1" id="example-select-all-remove"></th>
                						<th width="145">Entity ID</th>
                						<th width="300">Name</th>
                						<th width="500">Address</th>
                						<th width="100">Tax ID</th>
                						<th width="100">Date Of Birth</th>                						
            						</tr>
        						</thead>
							</table>
						</div>
<script type="text/javascript">
$( function() {
    $( "#dateOfBirth" ).datepicker({
      changeMonth: true,
      changeYear: true,
      yearRange: "1977:2017",
      dateFormat: "yy-mm-dd"
    });
    
    $( "#dateOfBirthAdd" ).datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "1977:2017",
        dateFormat: "yy-mm-dd"
    });
    
    $( "#dateOfIncorporation" ).datepicker({
        changeMonth: true,
        changeYear: true,
        yearRange: "1977:2017",
        dateFormat: "yy-mm-dd"
      });
    
  } );


</script>		