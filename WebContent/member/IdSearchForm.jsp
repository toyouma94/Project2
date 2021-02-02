<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="../common/bootstrap-4.5.3/css/bootstrap.css" />
<script src="../common/jquery/jquery-3.5.1.js"></script>

<%
	request.setCharacterEncoding("utf-8");

String name = request.getParameter("name");
String email = request.getParameter("email");
MemberDAO dao = new MemberDAO();
String id = dao.IdSearch(name, email);
dao.close();
%>
<title>아이디 찾기</title>
<body>

	<tr>
		<td>
			<%
				if (id != null) {
			%>
			<table width="300px" align=center border="0"
				style="color: black; font-size: 15px;">
				<tr align=center>
					<td style="height: 170px">아이디 찾기를 성공했습니다.</td>
				</tr>
				<tr align=center>
					<td style="font-size: 15px">회원님의 아이디는 <%=id%> 입니다.
					</td>
				</tr>
			</table> <%
 	} else {
 %>
			<table width="300px" align=center border="0"
				style="color: black; font-size: 15px;">
				<tr align=center>
					<td style="height: 170px">아이디 찾기를 실패했습니다.</td>
				</tr>
			</table> <%
 	}
 %>
		
</body>
</html>
