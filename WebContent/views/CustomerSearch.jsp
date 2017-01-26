<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import = "java.util.*" %>

<%
	String 	 sIdentifier	=	"";
	String	 sIdentifierType		=	"";
	int		 iIdx1			=	0;

//	DAO_PartyInformation	daopiObject		=	new DAO_PartyInformation();
//	HashMap<String, HashMap<String,String>> hmAvailableParties	= 	daopiObject.searchParty(sIdentifier, sIdentifierType);	
	HashMap<String, HashMap<String,String>> hmAvailableParties	= 	new HashMap<String, HashMap<String,String>>();	
	HashMap<String,String> hmPartyInfo							= 	new HashMap<String,String>();	
/*	
	for (int iIdx0=0; iIdx0 < 15; iIdx0++)
	{
		hmPartyInfo							= 	new HashMap<String,String>();
		iIdx1								=	iIdx0 + 1;
		hmPartyInfo.put("PartyID", "P00" + String.format("%02d", iIdx1));
		hmPartyInfo.put("NameLast", "Last Name - " + String.format("%02d", iIdx1));
		hmPartyInfo.put("NameFirst", "First Name - " + String.format("%02d", iIdx1));
		hmPartyInfo.put("Address", "This is a test for two lines that need to display the address split into two lines of address- " + String.format("%02d", iIdx1));
		hmPartyInfo.put("TaxIdentifier", "12345678" + String.format("%02d", iIdx1));
		hmPartyInfo.put("DateOfBirth", "DOB - " + String.format("%02d", iIdx1));
		hmPartyInfo.put("PhonePrimary", "732-310-61" + String.format("%02d", iIdx1));
		hmAvailableParties.put("P00" + Integer.toString(iIdx1), hmPartyInfo);
	}
*/	
	Map <String, HashMap<String,String>> mListOfParties			=	new TreeMap<String, HashMap<String,String>>(hmAvailableParties);
//	Map <String, String> mProducts						=	new TreeMap<String, String>(hmProducts);
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
													<input name="entityType" type="radio" value="001" OnClick="hideshowControls2('001', 'BusinessEntityTR','')" ></input>
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
																<div class="specialHREF" style="cursor: pointer" onClick="SearchParties('Search', '')">Search</div>
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
												<td width="150"><input type="text" name="dateOfIncorporation" id="dateOfIncorporation" class="TEXT" size="10" maxlength="15"></td>
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
																<div class="specialHREF" style="cursor: pointer" onClick="SearchParties('Search', '')">Search</div>
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
												<td width="270"><input type="text" class="TEXT" name="dateOfBirth" id="dateOfBirth" size="20" maxlength="50"></input></td>
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
																<div class="specialHREF" style="cursor: pointer" onClick="AddParties('Add', '')">Add</div>
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
													<div class="bankGridHeader">Search Results</div>
												</td>
												<td width="0290" align="right">
													<div class="specialHREF" style="cursor: pointer" onClick="SelectParties('Select', '')">Select</div>
												</td>
											</tr>
										</table>		
									</td>
								</tr>
								<tr>
									<td width="1290">
										<div class="tableCustomerHeader">
											<table width="1290" bgcolor="#ff0000" cellspacing="0" cellpadding="0">
												<tr height="05">
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000"></td>
													<td width="145" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="300" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="500" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="118" bgcolor="#ff0000"></td>
												</tr>
												<tr>
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000"></td>
													<td width="145" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Entity ID</td>
													<td width="300" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Name</td>
													<td width="500" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Address</td>
													<td width="100" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Tax ID</td>
													<td width="100" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Date of Birth</td>
													<td width="118" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Phone</td>
												</tr>
												<tr height="02">
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000" ></td>
													<td width="145" bgcolor="#ff0000" ></td>
													<td width="300" bgcolor="#ff0000"></td>
													<td width="500" bgcolor="#ff0000"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="118" bgcolor="#ff0000"></td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
								<tr>
									<td width="1272">
										<div class="tableCustomer">
											<table width="1272" bgcolor="#ffffff" cellspacing="0" cellpadding="0">
												<tr>
													<td width="002" bgcolor="#ffffff"></td>
													<td width="020" bgcolor="#ffffff"></td>
													<td width="145" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="300" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="500" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
												</tr>
<!--  Following code needs to deleted.  Required JQuery will create the row and cells.  To be developed by the Contractor -->								
<%
												if (null != mListOfParties && mListOfParties.size() > 0)
												{	
													sObjectLevel1				=	mListOfParties.keySet();
													iObjectLevel1				=	sObjectLevel1.iterator();
													while (iObjectLevel1.hasNext())
													{
														sPartySortField			=	(String) iObjectLevel1.next();
														hmPartyInfo				= 	new HashMap<String,String>();
														hmPartyInfo				=	(HashMap<String, String>) mListOfParties.get(sPartySortField);
														if (null != hmPartyInfo &&hmPartyInfo.size() > 0)
														{
%>
												<tr  height="02">
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="#FFFFFF"></td>
													<td width="145" bgcolor="#FFFFFF"></td>
													<td width="300" bgcolor="#FFFFFF"></td>
													<td width="500" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
												</tr>
												<tr>
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="<%=sColorCode%>" class="navymed">
															<input type="checkbox" name="selectedParty" value="<%=hmPartyInfo.get("PartyID") %>"></input>
													</td>
													<td width="145" bgcolor="#FFFFFF" class="navymed"><%=hmPartyInfo.get("PartyID") %></td>
													<td width="300" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("NameLast").trim() + ", " + hmPartyInfo.get("NameFirst").trim()  %></td>
													<td width="500" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("Address") %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("TaxIdentifier").substring(hmPartyInfo.get("TaxIdentifier").trim().length() - 4) %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("DateOfBirth") %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("PhonePrimary") %></td>
												</tr>
												<tr  height="02">
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="#FFFFFF"></td>
													<td width="145" bgcolor="#FFFFFF"></td>
													<td width="300" bgcolor="#FFFFFF"></td>
													<td width="500" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
												</tr>
												<tr height="01">
													<td width="002" bgcolor="#ffbf00"></td>
													<td width="020" bgcolor="#ffbf00"></td>
													<td width="145" bgcolor="#ffbf00"></td>
													<td width="300" bgcolor="#ffbf00"></td>
													<td width="500" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
												</tr>
<%
														}
													}
												}	
%>												
											</table>
										</div>
									</td>
								</tr>
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
													<div class="specialHREF" style="cursor: pointer" onClick="RemoveParties('Remove', '')">Remove</div>
												</td>
											</tr>
										</table>		
									</td>
								</tr>
								<tr>
									<td width="1290">
										<div class="tableCustomerHeader">
											<table width="1290" bgcolor="#ff0000" cellspacing="0" cellpadding="0">
												<tr height="05">
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000"></td>
													<td width="145" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="300" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="500" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="118" bgcolor="#ff0000"></td>
												</tr>
												<tr>
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000"></td>
													<td width="145" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Entity ID</td>
													<td width="300" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Name</td>
													<td width="500" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Address</td>
													<td width="100" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Tax ID</td>
													<td width="100" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Date of Birth</td>
													<td width="118" bgcolor="#ff0000" class="bankColumnHeaders" align="center">Phone</td>
												</tr>
												<tr height="02">
													<td width="002" bgcolor="#ff0000"></td>
													<td width="020" bgcolor="#ff0000" ></td>
													<td width="145" bgcolor="#ff0000" ></td>
													<td width="300" bgcolor="#ff0000"></td>
													<td width="500" bgcolor="#ff0000"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="100" bgcolor="#ff0000"></td>
													<td width="118" bgcolor="#ff0000"></td>
												</tr>
											</table>
										</div>
									</td>
								</tr>
								<tr>
									<td width="1272">
										<div class="tableCustomer">
											<table width="1272" bgcolor="#ffffff" cellspacing="0" cellpadding="0">
												<tr>
													<td width="002" bgcolor="#ffffff"></td>
													<td width="020" bgcolor="#ffffff"></td>
													<td width="145" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="300" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="500" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
													<td width="001" bgcolor="#ffbf00" rowspan="99"></td>
													<td width="100" bgcolor="#ffffff"></td>
												</tr>
<!--  Following code needs to deleted.  Required JQuery will create the row and cells.  To be developed by the Contractor -->								
<%
												if (null != mListOfParties && mListOfParties.size() > 0)
												{	
													sObjectLevel1				=	mListOfParties.keySet();
													iObjectLevel1				=	sObjectLevel1.iterator();
													while (iObjectLevel1.hasNext())
													{
														sPartySortField			=	(String) iObjectLevel1.next();
														hmPartyInfo				= 	new HashMap<String,String>();
														hmPartyInfo				=	(HashMap<String, String>) mListOfParties.get(sPartySortField);
														if (null != hmPartyInfo &&hmPartyInfo.size() > 0)
														{
%>
												<tr  height="02">
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="#FFFFFF"></td>
													<td width="145" bgcolor="#FFFFFF"></td>
													<td width="300" bgcolor="#FFFFFF"></td>
													<td width="500" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
												</tr>
												<tr>
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="<%=sColorCode%>" class="navymed">
															<input type="checkbox" name="selectedParty" value="<%=hmPartyInfo.get("PartyID") %>"></input>
													</td>
													<td width="145" bgcolor="#FFFFFF" class="navymed"><%=hmPartyInfo.get("PartyID") %></td>
													<td width="300" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("NameLast").trim() + ", " + hmPartyInfo.get("NameFirst").trim()  %></td>
													<td width="500" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("Address") %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("TaxIdentifier").substring(hmPartyInfo.get("TaxIdentifier").trim().length() - 4) %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("DateOfBirth") %></td>
													<td width="100" bgcolor="#FFFFFF" class="navymed" align="center"><%=hmPartyInfo.get("PhonePrimary") %></td>
												</tr>
												<tr  height="02">
													<td width="002" bgcolor="#FFFFFF"></td>
													<td width="020" bgcolor="#FFFFFF"></td>
													<td width="145" bgcolor="#FFFFFF"></td>
													<td width="300" bgcolor="#FFFFFF"></td>
													<td width="500" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
													<td width="100" bgcolor="#FFFFFF"></td>
												</tr>
												<tr height="01">
													<td width="002" bgcolor="#ffbf00"></td>
													<td width="020" bgcolor="#ffbf00"></td>
													<td width="145" bgcolor="#ffbf00"></td>
													<td width="300" bgcolor="#ffbf00"></td>
													<td width="500" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
													<td width="100" bgcolor="#ffbf00"></td>
												</tr>
<%
														}
													}
												}	
%>												
											</table>
										</div>
									</td>
								</tr>
							</table>