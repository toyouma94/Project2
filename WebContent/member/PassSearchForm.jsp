<%@page import="javafx.scene.control.Alert"%>
<%@page import="sun.font.Script"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/global_head.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
String name = request.getParameter("name");
String email = request.getParameter("email");

System.out.println("아이디:" + id);
System.out.println("이름:" + name);
System.out.println("이메일:" + email);
MemberDAO dao = new MemberDAO();

String pass = dao.IdPass(id, name, email);
if (pass != null) {
%>

<%
	request.setCharacterEncoding("UTF-8");

//메일발송을 위한 객체생성
SMTPAuth smtp = new SMTPAuth();

String mailContents = name + "님의 비밀번호는 " + pass + " 입니다.";

//메일을 보내기 위한 여러가지 폼값을 Map컬렉션에 저장
Map<String, String> emailContent = new HashMap<String, String>();
emailContent.put("from", "ckzks24@naver.com");
emailContent.put("to", email);
emailContent.put("subject", "요청하신 비밀번호입니다");
//     emailContent.put("content",request.getParameter("content"));
emailContent.put("content", mailContents);

//내용이 null값이 아니라면 이메일발송
if (mailContents != null) {
	boolean emailResult = smtp.emailSending(emailContent);

	if (emailResult == true) {
%>

<script type="text/javascript">
	alert("이메일발송성공");
	location.href = './login.jsp'
</script>

<%
	} else {
%>
<script type="text/javascript">
	alert("이메일발송실패");
	location.href = './id_pw.jsp'
</script>
<%
	}

return;
}

} else {
%>
<script type="text/javascript">
	alert("잘못된 이메일입니다!");
	location.href = './id_pw.jsp'
</script>
<%
	}
%>