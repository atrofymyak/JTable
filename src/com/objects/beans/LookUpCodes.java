package com.objects.beans;

public class LookUpCodes
{



	private String	LookUpCode			=	"";
	private String	LookUpDescription	=	"";
	private String	LookUpCategory		=	"";

	
	public LookUpCodes() 
	{
		super();
	}
	public String getLookUpCode() {
		return LookUpCode;
	}


	public void setLookUpCode(String lookUpCode) {
		LookUpCode = lookUpCode;
	}


	public String getLookUpDescription() {
		return LookUpDescription;
	}


	public void setLookUpDescription(String lookUpDescription) {
		LookUpDescription = lookUpDescription;
	}


	public String getLookUpCategory() {
		return LookUpCategory;
	}


	public void setLookUpCategory(String lookUpCategory) {
		LookUpCategory = lookUpCategory;
	}

}

