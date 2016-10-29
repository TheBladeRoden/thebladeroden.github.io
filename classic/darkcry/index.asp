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

<body topmargin="0" leftmargin="0" bgcolor="#080F2B">
	<Table ID="Main Table" Width="1005" height="<%=objRS("pageMinimumHeight")%>" cellspacing="0" cellpadding="0" align="<%if not objRS("websitePos") = "Left" then response.Write objRS("websitePos")%>">
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
								&nbsp;&nbsp;&nbsp;&nbsp;<font face="Arial" color="<%=objRS("menuColor")%>"><b>
								
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
									Response.Write "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href="""
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
				<font color="white">
				<!--Page Contents-->
				
				<%
					Dim PageName 
					PageName = Request.QueryString("page")
					
					if objRS("defaultPage") = "News" AND PageName = "" Then PageName = "News"
					if objRS("defaultPage") = "News" AND isNull(PageName) Then PageName = "News"
					
					if PageName="News" Then
							set newsRS = Server.CreateObject ("ADODB.Recordset")
							strSQL="SELECT * FROM tblNews ORDER BY newsID desc"
							newsRS.Open strSQL, objConn, 1
					
					'NEWS TABLE
					
									dim newscount
									for newscount = 1 to objRS("newsEntries")
										if not newsRS.EOF then%>
											<table width="680" cellspacing="0">
												<tr>
													<td bgcolor="#0D1844"><h3><font color="white">&nbsp;&nbsp;<%=newsRS("Title")%></td>
													<td bgcolor="#0D1844" align="right"><h3><font color="white"><%=newsRS("Date")%></td>
												</tr>
												<tr>
													<td width="680" colspan="2"><font color="white"><%=newsRS("Contents")%></td>
												</tr>
											</table></br>
										<%	newsRS.MoveNext
										end if
									next
								
								if not newsRS.EOF then%> 
									<a href="index.asp?page=NewsAll"><font color="white">Show All News</a>
							<%	end if
								
						
					end if	
			
					dim newsRS
							
					If PageName="NewsAll" Then
						
						set newsRS = Server.CreateObject ("ADODB.Recordset")
						strSQL="SELECT * FROM tblNews ORDER BY newsID desc"
						newsRS.Open strSQL, objConn, 1
						
						do while not newsRS.EOF
						%>	
						
						<table width="680" cellspacing="0">
							<tr>
								<td bgcolor="#0D1844"><h3><font color="white">&nbsp;&nbsp;<%=newsRS("Title")%></td>
								<td bgcolor="#0D1844" align="right"><h3><font color="white"><%=newsRS("Date")%></td>
							</tr>
							<tr>
								<td width="680" colspan="2"><%=newsRS("Contents")%></td>
							</tr>
						</table></br>
						
					<%	newsRS.MoveNext
						loop
					
					'END NEWS TABLE
					
					end if
					
					if PageName = "" or isNull(PageName) then PageName = objRS("defaultPage")
					
					If isNumeric(PageName) then
						Dim objRS2
						Set objRS2 = Server.CreateObject ("ADODB.Recordset")
						strSQL = "SELECT * FROM tblPages WHERE pageID=" & PageName
						objRS2.Open strSQL, objConn, 1
						if not objRS2.EOF then
								Response.Write objRS2("Contents")
							else
								Response.Write "<table width=""400"" height=""100"" border=""0""><tr><td width=""65"" align=""right""><img src=""images\error.png""></td><td width=""18""></td><td><h3><font face=""arial"">Page not found!</font></h3></td></tr></table>"
						end if
						
					end if
					
					if not isNumeric(PageName) And Not PageName = "News" And Not PageName = "NewsAll" then
						Response.Write "<table width=""400"" height=""100"" border=""0""><tr><td width=""65"" align=""right""><img src=""images\error.png""></td><td width=""18""></td><td><h3><font face=""arial"">Page not found!</font></h3></td></tr></table>"
					end if
				%>
				
				<!--/Page Contents-->
				
				
			</TD>
			<!---------------Make Side Cell size changeable, default to 12 if 0------------------------->
			<td width="<%=objRS("adColumnWidth")%>" valign="top" align="center"><%=objRS("adColumn")%>
			</td>
		</TR>
		<TR>
			<TD height="30" align="Center">
				<font color="white" size="-2"> <%=objRS("modTitle")%> by <%=objRS("modTeam")%> © <%=year(date)%></br>
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

</html>
