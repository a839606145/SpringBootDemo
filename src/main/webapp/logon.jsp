<%@ page language="java" contentType="text/html;charset=gb2312"%>
<%@ page import="java.util.*" %>
<%@ page session="true"%>
<!--
[]=================================================================[]
	Logon.jsp

	Copyright (C) 2003 Feitian Tech. Co. Ltd. All rights reserved.

	Comment : Demonstration how to use ePass 1000ND Active Control
			  in JSP
[]=================================================================[]

-->

<%
String RndData ="";
char Upper = 'z';
char Lower = 'a';
   Random r = new Random();
for(int i=0;i<20;i++)
{
   int tempval = (int)((int)Lower + (r.nextFloat() * ((int)(Upper - Lower))));
   RndData += new Character((char)tempval).toString();
}
session.setAttribute("RandomData",RndData);
%>

<HTML>
<HEAD>
<TITLE>Logon - ePass 1000ND SDK Test [JSP]</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<STYLE TYPE="text/css">
<!--
@import "test.css";
-->
</STYLE>
<script language=vbscript>
Dim FirstDigest
Dim Digest 
Digest= "01234567890123456"

dim bErr

sub ShowErr(Msg)
	bErr = true
	MsgBox Msg
'	document.Writeln "<FONT COLOR='#FF0000'>"
'	document.Writeln "<P>&nbsp;</P><P>&nbsp;</P><P>&nbsp;</P><P ALIGN='CENTER'><B>ERROR:</B>"
'	document.Writeln "<P>&nbsp;</P><P ALIGN='CENTER'>"
'	document.Writeln Msg
'	document.Writeln " failed, and returns 0x" & hex(Err.number) & ".<br>"
'	document.Writeln "<P>&nbsp;</P><P>&nbsp;</P><P>&nbsp;</P>"
'	document.Writeln "</FONT>"
End Sub

function Validate()
	Digest = "01234567890123456"
	On Error Resume Next
	Dim TheForm
	Set TheForm = document.forms("ValidForm")
	If Len(TheForm.UserPIN.Value) < 4  Then
		MsgBox "PIN empty or user pin length less than 4 or so pin length less than 6!!"	 
		Validate = FALSE
		Exit Function
	End If

	bErr = false

	'Let detecte whether the ePass 1000ND Safe Active Control loaded.
	'If we call any method and the Err.number be set to &H1B6, it 
	'means the ePass 1000ND Safe Active Control had not be loaded.
	ePass.GetLibVersion


	If Err.number = &H1B6 Then

		ShowErr "Load ePass 1000ND Safe Active Control"
		Validate = false
		Exit function
	Else
	

		ePass.OpenDevice 1, ""
		
		If Err then
			ShowErr "Open first ePass failed."
			Validate = false
			Exit function
		End if
		
			
		'you can use this function to reset securityState
		'ePass.ResetSecurityState 0
		dim results
		results = "01234567890123456"
		results = ePass.GetStrProperty(7, 0, 0)
		
		
        'ePass.VerifyPIN CInt(TheForm.Identity.Value), CStr(TheForm.UserPIN.Value)
		ePass.VerifyPIN 0, CStr(TheForm.UserPIN.Value)
		If Err Then
			ShowErr "Verify User PIN Failure!!!"
			Validate = false
			ePass.CloseDevice
			Exit function
		End If
		

		If Not bErr Then
			ePass.ChangeDir &H300, 0, "ASP_DEMO"
			If Err then 
				ShowErr "Change to demo directory"
				Validate = false
				ePass.CloseDevice
				Exit function
			End If
		End If


		'Open the first key file.
		If Not bErr Then
			ePass.OpenFile 0, 1
			If Err Then 
				ShowErr "Open first KEY-file"
				Validate = false
				ePass.CloseDevice
				Exit function
			End If
		End If

		'Do HASH-MD5-HMAC compute.
		If Not bErr Then
			Digest = ePass.HashToken (1, 2,"<%=(String)session.getAttribute("RandomData")%>")
			If Err Then 
				ShowErr "HashToken compute"
				Validate = false
				ePass.CloseDevice
				Exit function
			End If
			
			DigestID.innerHTML = "<input type='hidden' name='Digest' Value='" & Digest & "'>"
			snID.innerHTML = "<input type='hidden' name='SN_SERAL' Value='" & results & "'>"
		End If
	End If
	ePass.CloseDevice
End function
</script>

</HEAD>
<BODY>
                     
<OBJECT classid=clsid:0272DA76-96FB-449E-8298-178876E0EA89 id=ePass name = ePass STYLE="LEFT: 0px; TOP: 0px" width=0 height=0></OBJECT>

<H1 ALIGN="center">ePass 1000ND Active Control<BR>Demo Program for JSP</H1>
<TABLE WIDTH="600" BORDER="0" ALIGN="center">
  <TR>
    <TD>
      <P ALIGN="CENTER">Welcome to ePass 1000ND Active Control demonstration program for JSP.</P>


<SCRIPT id=clientEventHandlersVBS language=vbscript>
<!--
		'Now you had get the result of HASH compute and the random data
		' use to HASH compute. You should post these data to server and
		' do verify operation.
		document.Writeln ("<P>&nbsp;</P><P ALIGN='CENTER'>To logon, you must input your PIN.</P>")
		document.Writeln ("<P>&nbsp;</P><P>&nbsp;</P></TD></TR><TR><TD>")
		document.Writeln ("<FORM id=ValidForm METHOD='post' ACTION='verify.jsp' onsubmit='return Validate();' language='jscript'>")

		'Post the result of HASH compute by ePass can use by server.

		document.Writeln ("<span id=DigestID></span>")
		document.Writeln ("<span id=snID></span>")
		'document.Writeln ("<input type='hidden' name='Digest' Value='" & Digest & "'>")

		'Create a table and let user input the PIN.
		document.Writeln ("<TABLE WIDTH='250' BORDER='1' ALIGN='center' CELLSPACING='0' BORDERCOLORDARK='#E7EBFF' BORDERCOLORLIGHT='#000000'>")
		'If you add so pin verify ,you maybe add these codes as these
		'document.Writeln "<TR><TD ALIGN='right'>Identity:</TD><TD>"
		'document.Writeln "<select name='Identity'>"
		'document.Writeln "<option  value='0'>User PIN</option>"
		'document.Writeln "<option value='1'>So PIN</option>"
		'document.Writeln "</select>"
		'document.Writeln "</TD></TR>"
		
		document.Writeln ("<TR><TD ALIGN='right'>User PIN:</TD><TD><INPUT TYPE='password' NAME='UserPIN' CLASS='inputtext'></TD></TR>")


		document.Writeln ("</TABLE><P>&nbsp;</P><P ALIGN='center'>")
		document.Writeln ("<INPUT TYPE='submit' NAME='Submit' VALUE='Let me in' CLASS='inputbtn'>")
		document.Writeln ("<INPUT TYPE='reset' NAME='Reset' VALUE='Re-input' CLASS='inputbtn'></P></FORM>")
-->
</SCRIPT>

	</TD>
  </TR>
</TABLE>
<H2>&nbsp;</H2>
<P>&nbsp;</P>
<P ALIGN="center">Copyright&copy; 2003-2012,Feitian Tech. Co. Ltd.</P>
</BODY>
</HTML>