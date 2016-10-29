<%@ LANGUAGE="VBSCRIPT" %>
<% option explicit 
	Dim objConn, objRS, strSQL, objRS3, objRS4
	Set objConn = Server.CreateObject("ADODB.Connection")
	Set objRS = Server.CreateObject ("ADODB.Recordset")
	Set objRS3 = Server.CreateObject ("ADODB.Recordset")
	Set objRS4 = Server.CreateObject ("ADODB.Recordset")
	objConn.ConnectionString ="DRIVER={Microsoft Access Driver (*.mdb)}; DBQ=" & server.mappath("data/main.mdb")
	objConn.Open
	
	strSQL = "SELECT * FROM tblModinfo"
	objRS.Open strSQL, objConn, 1
	
	strSQL = "SELECT * FROM tblCats"
	objRS3.Open strSQL, objConn, 1
%>

<html>
<head>
<title>
<%=objRS("modTitle")%>
</title>
</head>
<body topmargin="0" leftmargin="0">
	<Table ID="Main Table" Width="1005" height="<%=objRS("pageMinimumHeight")%>" cellspacing="0" cellpadding="0" align="<%=objRS("websitePos")%>">
		<TR>
			<TD Height="<%=objRS("titleHeight")%>" ColSpan="3" background="images\menutop.PNG">
			
			</TD>
		</TR>
		<TR>
			<TD height="<%=objRS("seperatorHeight")%>" Colspan="3" background="images\menumiddle.PNG">
			
			</TD>
		</TR>
		<TR>
			<TD valign="top" align="left" Width="<%=objRS("menuWidth")%>" height background="images\menuside.PNG" rowspan="2">
			<!--Menu Contents-->
			
				<%do while not objRS3.EOF%>
					
									
					<table border="0" width="<%=objRS("catWidth")%>" align="left" cellspacing="0" cellpadding="0">
						<tr>
							<td width="<%=objRS("catWidth")%>" height="29" background="images\menucat.PNG">
								&nbsp;&nbsp;<font face="Arial" color="<%=objRS("menuColor")%>"><b>
								
								<!--Category Name-->
								<%=objRS3("catName")%>
								
								<b></font>
							</td>
						</tr>
						<tr>
							<td width="<%=objRS("catWidth")%>" height="<%=objRS("topCatHeight")%>" background="images\menusubtop.PNG">
							</td>
						</tr>
						<tr>
							<td width="<%=objRS("catWidth")%>" background="images\menusubmid.PNG"><font face="Arial" size="-1">
							<!--Sub Category Contents-->
							
							<%
							strSQL = "SELECT * FROM tblSubCats WHERE catID=" & objRS3("catID")
							objRS4.Open strSQL, objConn, 1
							if not objRS4.EOF then
								do while not objRS4.EOF
									Response.Write "&nbsp;&nbsp;&nbsp;&nbsp;<a href="""
									if objRS4("subCatLinkType") = "Internal" then
										Response.Write "index.asp?page=" & objRS4("subCatLink")
									end if
									if objRS4("subCatLinkType") = "External" then
										Response.Write objRS4("subCatLink")
									end if
									Response.Write """><font color=""" & objRS("menuColor") & """>" & objRS4("subCatName") & "</font></a></br>"
									objRS4.MoveNext
								loop
							end if
							objRS4.Close
							%>

							</font>
							</td>
						</tr>
						<tr>
							<td width="<%=objRS("catWidth")%>" height="<%=objRS("botCatHeight")%>" background="images\menusubbot.PNG">
							</td>
						</tr>
						
					
					</table></br>
				<%
					objRS3.MoveNext
				loop%>
			
				<!--/Menu Contents-->
			</TD>
			<TD Width="777" align="left" valign="top">
				
				<!--Page Contents START-->
				
				
				
				
				
				
				
				
				
				
				
				<!--Page Contents END-->
				
				
			</TD>
			<!---------------Make Side Cell size changeable, default to 12 if 0------------------------->
			<td width="<%=objRS("adColumnWidth")%>" valign="top" align="center"><%=objRS("adColumn")%>
			</td>
		</TR>
		<TR>
			<TD height="30" align="Center">
				<font size="-2"> <%=objRS("modTitle")%> by <%=objRS("modTeam")%> © <%=year(date)%></br>
				<%=objRS("modTitle")%> is a modification of <a href="<%=objRS("gameNameLink")%>"><%=objRS("gameName")%></a>, developed by <a href="<%=objRS("gameCreatorLink")%>"><%=objRS("gameCreator")%></a></br>
				Website platform written by Matt Bell © 2005</br>
				<%=objRS("footerinfo")%>
				</font>
			</TD>
		</TR>
		<TR>
			<TD Width="<%=objRS("menuWidth")%>" Height="<%=objRS("menuFooterHeight")%>" Background="images\menubottom.PNG">
			</TD>
		</TR>
	</Table>
	
</Body>
</Html>