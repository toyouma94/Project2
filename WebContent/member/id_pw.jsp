<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>


<script type="text/javascript">
	function idSearch(fn) {

		if (fn.id_name.value == '') {
			alert('이름을 입력해주세요');

			return false;
		}

		else if (fn.id_email.value == '') {
			alert('이메일을 입력해주세요');

			return false;
		}

		window.open("IdSearchForm.jsp?name=" + fn.id_name.value + "&email="
				+ fn.id_email.value, "idover", "width=500, height=300");

	}
	function passSearch(frm) {

		var id = document.getElementsByName("id")[0].value;
		window.name = "parentForm";
		window.open("PassSearchForm.jsp", "chkForm",
				"width=500, height=300, resizable = no, scrollbars = no");
	}
</script>

<body>
	<form>
		<center>
			<div id="wrap">
				<%@ include file="../include/top.jsp"%>

				<img src="../images/member/sub_image.jpg" id="main_visual" />

				<div class="contents_box">
					<div class="left_contents">
						<%@ include file="../include/member_leftmenu.jsp"%>
					</div>
					<div class="right_contents">
						<div class="top_title">
							<img src="../images/member/id_pw_title.gif" alt=""
								class="con_title" />
							<p class="location">
								<img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기
							<p>
						</div>
						<div class="idpw_box">
							<form name="searchId" method="post">
								<div class="id_box">
									<ul>
										<li><input type="text" name="id_name" value=""
											class="login_input01" /></li>
										<li><input type="text" name="id_email" value=""
											class="login_input01" /></li>
									</ul>
									<button type="button" class="id_btn"
										onclick="idSearch(this.form)" style="border: 0" />
										<img src="../images/member/id_btn01.gif" alt="" /> <a href=""><img
											src="../images/login_btn03.gif" class="id_btn02" /></a></div>
							</form>
							<div class="idpw_box">
								<form name="searchPass" method="post"
									action="PassSearchForm.jsp">
									<div class="pw_box">
										<ul>
											<li><input type="text" name="id" value=""
												class="login_input01" /></li>
											<li><input type="text" name="name" value=""
												class="login_input01" /></li>
											<li><input type="text" name="email" value=""
												class="login_input01" /></li>
										</ul>
										<a href=""><input type="image"
											src="../images/member/id_btn01.gif" class="pw_btn"
											name="submit" value="submit" /></a>
									</div>
							</div>
	</form>
	</form>
	</div>
	</div>
	<%@ include file="../include/quick.jsp"%>
	</div>


	<%@ include file="../include/footer.jsp"%>
	</center>

</body>
</html>
