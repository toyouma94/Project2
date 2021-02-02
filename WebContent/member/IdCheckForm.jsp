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
	String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
boolean result = dao.duplicateIdCheck(id);
dao.close();
%>
<title>아이디 중복 체크</title>

<style type="text/css">
#wrap {
	width: 490px;
	text-align: center;
	margin: 0 auto 0 auto;
}

#chk {
	text-align: center;
}

#cancelBtn {
	visibility: visible;
}

#useBtn {
	visibility: visible;
}
</style>

<script type="text/javascript">
	var httpRequest = null;

	// httpRequest 객체 생성
	function getXMLHttpRequest() {
		var httpRequest = null;

		if (window.ActiveXObject) {
			try {
				httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				try {
					httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
				} catch (e2) {
					httpRequest = null;
				}
			}
		} else if (window.XMLHttpRequest) {
			httpRequest = new window.XMLHttpRequest();
		}
		return httpRequest;
	}

	// 회원가입창의 아이디 입력란의 값을 가져온다.
	function idCheck(fn) {
		//중복 체크를 누를때 입력된 아이디가 없다면..
		if (fn.id.value == "") {
			//경고창을 띄우고..
			alert("아이디를 입력후 중복확인을 누르삼");
			//포커스를 이동한다.
			fn.id.focus();
		} else {
			fn.id.readOnly = true;
			window.open("../include/id_overapping.jsp?id=" + fn.id.value,
					"idover", "width=300,height=200");
		}
	}

	// 아이디 중복체크
	function idCheck(frm) {
		var num = /[0-9]/g;
		var idRegExp = /^[a-z0-9]{4,12}$/;
		var eng = /[a-z]/g;
		var id = document.getElementById("userId").value;

		if (!id) {
			alert("아이디를 입력하지 않았습니다.");
			return false;
		} else if (!idRegExp.test(id)) {
			alert('아이디가 조건에 맞지 않습니다');
			frm.id.focus();
			return false;
		} else if (!eng.test(id) || !num.test(id)) {
			alert('아이디가 조건에 맞지 않습니다');
			frm.id.focus();
			return false;
		} else {
			location.href = "IdCheckForm.jsp?id=" + id;

		}
	}

	function idUse1() {
		var id = document.getElementById("userId").value;
		opener.document.registForm.id.value = id;
		opener.document.getElementsByName("id")[0].readOnly = true;

		self.close();
	}
</script>

</head>
<body onload="pValue()">
	<div id="wrap">
		<br> <b><font size="4" color="gray">아이디 중복체크</font></b>
		<%
			if (result) {
		%>
		<center>
			<p>이미 사용중인 아이디입니다</p>
		</center>
		<%
			} else {
		%>
		<center>
			<p>
				<%=id%>는 사용중인 아이디가 아닙니다
			</p>
		</center>
		<%
			}
		%>
		<hr size="1" width="460">
		<br>
		<div id="chk">
			<form id="checkForm">
				<input type="text" value="<%=request.getParameter("id")%>"
					name="idinput" id="userId"> <input type="button"
					value="중복확인" onclick="idCheck(this.form)">
			</form>
			<div id="msg"></div>
		</div>
		<br>
		<form name="id">
			<input id="useBtn" type="button" value="사용하기" onclick="idUse1()">
			<input id="cancelBtn" type="button" value="취소"
				onclick="window.close()">
		</form>
	</div>
</body>

</html>