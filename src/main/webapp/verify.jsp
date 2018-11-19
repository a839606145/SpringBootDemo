<%@ page language="java" contentType="text/html;charset=gb2312" %>
<%@ page session="true" %>
<%@ page import="java.io.*"%>
<%@ page import = "root.util.HMAC_MD5"%>

<!--
[]=================================================================[]
	Verify.jsp

	Copyright (C) 2003 Feitian Tech. Co. Ltd. All rights reserved.

	Comment : Demonstration how to use ePass 1000ND Active Control
			  in JSP
[]=================================================================[]
-->
<%
	String Randata = (String)session.getAttribute("RandomData");

	String SerNo = request.getParameter("SN_SERAL");
	String ClientDigest = request.getParameter("Digest");
	
	//read SN and PWD from text file
	String SerNoTxt="";
	String Pwd="";

	//set read file path 
	String p=request.getServletPath();
 	String path=request.getRealPath(p);
  	path=path.substring(0,path.lastIndexOf("\\"));
 	String realpath=path+"\\user.txt";	
		
  	BufferedReader file; 
	
 	file = new BufferedReader(new FileReader(realpath));  
	try  
	{  
		SerNoTxt = file.readLine();  
		Pwd = file.readLine();
	}  
	catch (IOException e)  
	{//Error  
	   
	}   		
	
	HMAC_MD5 hm = new HMAC_MD5(Pwd.getBytes());
	hm.addData(Randata.getBytes());
	
	byte digest[];
	digest = hm.sign();
	String ss = hm.toString();
	if(ClientDigest.equals(ss))
	{
		out.println("ok,equal!");
	}
	else
	{
		out.println("Sorry,clentDigest doesn't equal Server Digest!");
	}


%>
