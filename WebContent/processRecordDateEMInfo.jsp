<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="rendezvous.UserProfileInfo"%>
<%@ page import="rendezvous.State"%>
<%@ page import="rendezvous.ProfilePlacementPriority"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="rendezvous.Customer"%>
<%@ page import="rendezvous.UserProfile"%>
<%@ page import="config.DateConstants"%>
<%@ page import="rendezvous.Like"%>
<%@ page import="staff.RecordDateEM"%>
<%@ page import="staff.RecordDateEMInfo"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="refresh" content="3; url=recordDateEM.jsp" />
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="Stylesheet/topbar.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/customerCenter.css" type="text/css" rel="stylesheet">
<link href="Stylesheet/makeDate.css" type="text/css" rel="stylesheet">

<title>Redirecting...</title>
</head>
<body>
	<!--=============================================================================-->
	<!--============================= Check Information =============================-->
	<!--=============================================================================-->
	<!-- Check Information -->
	<%
	try {
		if (!session.getAttribute("staffSession").equals("EM")) {
			response.sendRedirect("staffLogin.jsp");
		}
		if (session.getAttribute("staffSSN") == null) {
			response.sendRedirect("staffLogin.jsp");
		}
	} catch (Exception ex) {
		response.sendRedirect("staffLogin.jsp");
		return;
	}
		
	%>
	<!--=============================================================================-->
	<!--================================ Top Bar ====================================-->
	<!--=============================================================================-->
	<!-- Top bar -->
	<div class="titleBar"></div>
	<div class=rendezvous>Rendezvous</div>
	<!-- Buttons -->
	<div class="signOut">
		<a href="employeeHome.jsp">Back to Employee Home</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="signOut.jsp">Sign Out</a>
	</div>
	<div class="staffSSN">
	</div>
	<div>
	<%
		try {
			String Id1 = RecordDateEMInfo.Id1;
			String Id2 = RecordDateEMInfo.Id2;

			String date_Month = RecordDateEMInfo.date_Month;
			String date_Day = RecordDateEMInfo.date_Day;
			String date_Year = RecordDateEMInfo.date_Year;
			String date_Hour = RecordDateEMInfo.date_Hour;
			String date_Minute = RecordDateEMInfo.date_Minute;
			String date_Second = RecordDateEMInfo.date_Second;

			String date_UseCurrentTime = RecordDateEMInfo.date_UseCurrentTime;
			//out.print(date_UseCurrentTime == null);

			String date_Loaction = RecordDateEMInfo.date_Loaction;
			String date_Zipcode = RecordDateEMInfo.date_Zipcode;
			
			StringBuilder datetime = RecordDateEMInfo.datetime;
			String repId = RecordDateEMInfo.repId;
			String fee = RecordDateEMInfo.fee;
			
			RecordDateEMInfo.init();
			int option=0;
			if(date_UseCurrentTime == null){
				if(date_Loaction.length()>0&&date_Zipcode.length()>0)
					option = 2;
				else
					option=0;
			}
			else{
				if(date_Loaction.length()>0&&date_Zipcode.length()>0)
					option = 3;
				else
					option=1;
			}
			
			boolean status1=false;
			
			String str = "";	
			
			switch(option) {
			case 0: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid+"^^^"+datetime.toString());
				status1 = RecordDateEMInfo.makeDateOnGivenDate(Id1, Id2, datetime.toString(),repId,fee);
				if(status1==false){
					str = "Failed to record a date!!!";
				}
				else{
					str = "Successfully recorded a date!!!";
				}
				break;
			}
			case 1: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid);
				status1 = RecordDateEMInfo.makeDateOnCurrent(Id1,Id2,repId,fee);
				if(status1==false){
					str = "Failed to record a date!!!";
				}
				else{
					str = "Successfully recorded a date!!!";
				}
				break;
			}
			case 2: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+pid+"^^^"+datetime.toString());
				status1 = RecordDateEMInfo.makeDateOnGivenDateGeo
						(Id1,Id2, datetime.toString(),date_Loaction,date_Zipcode,repId,fee);
				if(status1==false){
					str = "Failed to record a date!!!";
				}
				else{
					str = "Successfully recorded a date!!!";
				}
				break;
			}
			case 3: {
				//System.out.println((String)session.getAttribute("profileId")+"^^^^"+fee);
				status1 = RecordDateEMInfo.makeDateOnCurrentGeo
						(Id1,Id2,date_Loaction,date_Zipcode,repId,fee);
				if(status1==false){
					str = "Failed to record a date!!!";
				}
				else{
					str = "Successfully recorded a date!!!";
				}
				break;
			}
			}
	%>
	<div style="font-size: 4em; text-align: center; color: #d70026; padding-top: 2em;">
		<i class="fa fa-spinner fa-spin"></i>
	</div>
	<div style="font-size: 1.5em; text-align: center; font-weight: 500; padding-top: 1em;" class="fontfont">
		<%
			out.print(str);
		%>
	</div>
			<%
			return;
		} catch (Exception ex) {
			//ex.printStackTrace();
		}
	%>
	</div>
	<div style="margin: 10em;"></div>
</body>
</html>