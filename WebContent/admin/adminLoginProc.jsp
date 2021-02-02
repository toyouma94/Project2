<%@page import="model.admin"%>
<%@page import="model.MemberDAO"%>
<%@page import="util.CookieUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- LoginProcMap.jsp --%>
<%
	request.setCharacterEncoding("UTF-8");

//main.jsp에서 폼값받기
String email = request.getParameter("inputEmail");
String pass = request.getParameter("inputPassword");
System.out.println(email);
System.out.println(pass);
//DAO객체생성 및 DB연결
MemberDAO dao = new MemberDAO();

//Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap = dao.adminMemberMap(email, pass);

// System.out.println("이메일 검증전:" + email);

if (memberMap.isEmpty() == false) {
	//로그인 성공시 세션영역에 아래 속성을 저장한다.
	session.setAttribute("EMAIL", memberMap.get("inputEmail"));
	session.setAttribute("PASS", memberMap.get("inputPassword"));

	//아이디 저장하기 체크박스가 사용자가 체크하면! ...
	if (dao.AdminCheck(email).equals("T")) {
		response.sendRedirect("index.jsp");
		
	} else {
		dao.close();
		response.sendRedirect("login.jsp");
	}

} else {
	//로그인 실패시 or 없는회원
	dao.close();
	System.out.println("관리자 x.");
%>
<head>
<script>
	alert('관리자 계정이 아닙니다.');
	location.href = "./login.jsp";
</script>
</head>

<%
	}
%>



