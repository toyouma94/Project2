<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//리퀘스트 내장객체를 이용해서 생성된 쿠키를 가져온다.
Cookie[] cookies = request.getCookies();
//쿠키값을 저장할 변수
String cookid = "";
//생성된 쿠키가 존재한다면...
if (cookies != null) {
	for (Cookie ck : cookies) {
		if (ck.getName().equals("CookId")) { //(프록시에서 선언한 쿠키의 이름인(키이름)확인if문)
	//쿠키이름인 키 아이디저장에 관련된 값이 있는지 확인
	cookid = ck.getValue();
	System.out.println("메인페이지 저장 체크박스 확인=" + cookid);
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");

@import url("../css/main.css");

@import url("../css/sub.css");
</style>

<script type="text/javascript">
	function fnLogin(frm) {

		//아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입
		//아이디 빈값 체크.
		if (frm.id.value == '') {
			alert('아이디를 입력하세요.');
			frm.id.focus();
			return false;
		}
		//비밀번호 빈값인지 검사//
		if (frm.pass1.value == '') {
			alert('비밀번호를 입력하세요.');
			frm.pass1.focus();
			return false;
		}
	}
</script>

</head>
<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<div id="main_visual">
				<a href="/product/sub01.jsp"><img
					src="../images/main_image_01.jpg" /></a><a
					href="/product/sub01_02.jsp"><img
					src="../images/main_image_02.jpg" /></a><a
					href="/product/sub01_03.jsp"><img
					src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img
					src="../images/main_image_04.jpg" /></a>
			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title01.gif" alt="로그인 LOGIN" />
					</p>
					<div class="login_box">
						<%
							//로그인 되었는지 확인하기 위해 세션영역에서 속성을 가져온다.
						if (session.getAttribute("ID") == null) {//로그인 전 상태..
						%>
						<!-- return이 빠지면 submit하면서 그냥 check()를 실행하는 것 뿐이고,
            return이 있어야 callback받아서 check의 결과값을 submit에 리턴해주게 됩니다.
             -->
						<form action="../member/loginProcMap.jsp" method="post"
							name="loginBox" onsubmit="return fnLogin(this);">
							<table cellpadding="0" cellspacing="0" border="0">
								<colgroup>
									<col width="45px" />
									<col width="120px" />
									<col width="55px" />
								</colgroup>
								<tr>
									<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
									<td><input type="text" name="id"
										value="<%=(cookid.length() == 0) ? "" : cookid%>"
										class="login_input" /></td>
									<!-- 메인화면 로그인버튼 -->
									<td rowspan="2"><input type="image"
										src="../images/login_btn01.gif" alt="로그인" /></td>
								</tr>
								<tr>
									<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
									<td><input type="password" name="pass" value=""
										class="login_input" /></td>
								</tr>
							</table>
							<p>
								<!-- 저장(체크박스) -->
								<label><input type="checkbox" name="checkSave"
									<%if (cookid.length() != 0) {%> checked="checked" <%}%> /> <img
									src="../images/login_tit03.gif" alt="저장" /></label> <a
									href="../member/id_pw.jsp"><img
									src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a> <a
									href="../member/join01.jsp"><img
									src="../images/login_btn03.gif" alt="회원가입" /></a>
							</p>
							<%
								} else { //로그인 후 상태
							%>
						</form>

						<!-- 로그인 후 -->
						<!-- 세션으로 처리. if문 활용  -->
						<p style="padding: 10px 0px 10px 10px">
							<span style="font-weight: bold; color: #333;"> <%=session.getAttribute("NAME")%>
							</span> 회원님, 반갑습니다.<br />로그인 하셨습니다.
						</p>
						<p style="text-align: right; padding-right: 10px;">
							<input type="image" src="../images/login_btn04.gif" alt="회원정보수정" onclick="location.href='../member/editMembership?mode=edit&id=<%=session.getAttribute("ID")%>'" /></a>
							<a href="../member/Logout.jsp"><img
								src="../images/login_btn05.gif" alt="로그아웃" /></a>
						</p>
						<%
							}
						%>

					</div>
				</div>
				<div class="main_con_center">
					<p class="main_title">
						<img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a
							href="/space/sub01.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_board_list">
						<li><p>
								<a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span>
							</p></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					</ul>
				</div>
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a
							href="/space/sub03.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_board_list">
						<li><p>
								<a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span>
							</p></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지마포 구립 장애인 직업재활센터
								홈페이지마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
						<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					</ul>
				</div>
			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title">
						<img src="../images/main_title04.gif" alt="월간일정 CALENDAR" />
					</p>
					<img src="../images/main_tel.gif" />
				</div>
				<div class="main_con_center">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title05.gif" alt="월간일정 CALENDAR" />
					</p>
					<div class="cal_top">
						<table cellpadding="0" cellspacing="0" border="0">
							<colgroup>
								<col width="13px;" />
								<col width="*" />
								<col width="13px;" />
							</colgroup>
							<tr>
								<td><a href=""><img src="../images/cal_a01.gif"
										style="margin-top: 3px;" /></a></td>
								<td><img src="../images/calender_2012.gif" />&nbsp;&nbsp;<img
									src="../images/calender_m1.gif" /></td>
								<td><a href=""><img src="../images/cal_a02.gif"
										style="margin-top: 3px;" /></a></td>
							</tr>
						</table>
					</div>
					<div class="cal_bottom">
						<table cellpadding="0" cellspacing="0" border="0" class="calendar">
							<colgroup>
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="14%" />
								<col width="*" />
							</colgroup>
							<tr>
								<th><img src="../images/day01.gif" alt="S" /></th>
								<th><img src="../images/day02.gif" alt="M" /></th>
								<th><img src="../images/day03.gif" alt="T" /></th>
								<th><img src="../images/day04.gif" alt="W" /></th>
								<th><img src="../images/day05.gif" alt="T" /></th>
								<th><img src="../images/day06.gif" alt="F" /></th>
								<th><img src="../images/day07.gif" alt="S" /></th>
							</tr>
							<tr>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">1</a></td>
								<td><a href="">2</a></td>
								<td><a href="">3</a></td>
							</tr>
							<tr>
								<td><a href="">4</a></td>
								<td><a href="">5</a></td>
								<td><a href="">6</a></td>
								<td><a href="">7</a></td>
								<td><a href="">8</a></td>
								<td><a href="">9</a></td>
								<td><a href="">10</a></td>
							</tr>
							<tr>
								<td><a href="">11</a></td>
								<td><a href="">12</a></td>
								<td><a href="">13</a></td>
								<td><a href="">14</a></td>
								<td><a href="">15</a></td>
								<td><a href="">16</a></td>
								<td><a href="">17</a></td>
							</tr>
							<tr>
								<td><a href="">18</a></td>
								<td><a href="">19</a></td>
								<td><a href="">20</a></td>
								<td><a href="">21</a></td>
								<td><a href="">22</a></td>
								<td><a href="">23</a></td>
								<td><a href="">24</a></td>
							</tr>
							<tr>
								<td><a href="">25</a></td>
								<td><a href="">26</a></td>
								<td><a href="">27</a></td>
								<td><a href="">28</a></td>
								<td><a href="">29</a></td>
								<td><a href="">30</a></td>
								<td><a href="">31</a></td>
							</tr>
							<tr>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
								<td><a href="">&nbsp;</a></td>
							</tr>
						</table>
					</div>
				</div>
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a
							href="/space/sub04.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_photo_list">
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
						<li>
							<dl>
								<dt>
									<a href=""><img src="../images/g_img.gif" /></a>
								</dt>
								<dd>
									<a href="">마포 구립 장애인...</a>
								</dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>

		<%@ include file="../include/footer.jsp"%>

	</center>
</body>
</html>