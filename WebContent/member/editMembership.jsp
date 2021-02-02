<%@page import="model.MemberDTO"%>
<%@page import="org.apache.catalina.tribes.membership.Membership"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>
<html>
<%@ include file="./isLogin.jsp" %>
<%
MemberDTO dto = new MemberDTO();
dto.setId(session.getAttribute("ID").toString());
%>
<script
	src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	function sample6_execDaumPostcode() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var addr = ''; // 주소 변수
						var extraAddr = ''; // 참고항목 변수

						//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							addr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							addr = data.jibunAddress;
						}

						// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
						if (data.userSelectedType === 'R') {
							// 법정동명이 있을 경우 추가한다. (법정리는 제외)
							// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
							if (data.bname !== ''
									&& /[동|로|가]$/g.test(data.bname)) {
								extraAddr += data.bname;
							}
							// 건물명이 있고, 공동주택일 경우 추가한다.
							if (data.buildingName !== ''
									&& data.apartment === 'Y') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
							if (extraAddr !== '') {
								extraAddr = ' (' + extraAddr + ')';
							}
							// 조합된 참고항목을 해당 필드에 넣는다.
							document.getElementById("sample6_extraAddress").value = extraAddr;

						} else {
							document.getElementById("sample6_extraAddress").value = '';
						}

						// 우편번호와 주소 정보를 해당 필드에 넣는다.
						document.getElementById('sample6_postcode').value = data.zonecode;
						document.getElementById("sample6_address").value = addr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById("sample6_detailAddress")
								.focus();
					}
				}).open();
	}
</script>
<script type="text/javascript">
	var checkValue = function(frm) {
		var num2 = /[0-9]/g;
		var idRegExp2 = /^[a-z0-9]{4,12}$/;
		var eng2 = /[a-z]/g;

		if (frm.pass.value == '') {
			alert('비밀번호를 입력하세요');
			frm.pass.focus();
			return false;
		}

		if (!idRegExp2.test(frm.pass.value)) {
			alert('비밀번호가 조건에 맞지 않습니다');
			frm.pass.focus();
			return false;
		} else if (!eng2.test(frm.pass.value) || !num2.test(frm.pass.value)) {
			alert('비밀번호가 조건에 맞지 않습니다');
			frm.pass.focus();
			return false;
		}

		if (frm.pass2.value == '') {
			alert('비밀번호 확인을 입력하세요');
			frm.pass2.focus();
			return false;
		}
		/*
		입력한 패스워드가 일치하지 않으면 둘다 지우고 처음부터
		다시 입력하게 한다. 
		 */
		if (frm.pass.value != frm.pass2.value) {
			alert("입력한 비밀번호가 일치하지 않습니다.");
			frm.pass.value = "";
			frm.pass2.value = "";
			frm.pass.focus();
			return false;
		}

		//     if(frm.tel.value==''){
		//         alert('전화번호를 입력하세요');
		//         frm.mobile.focus();
		//         return false;
		//     }

		if (frm.mobile1.value == '' || frm.mobile2.value == ''
				|| frm.mobile3.value == '') {
			alert('핸드폰번호를 입력하세요');
			frm.mobile1.focus();
			return false;
		}

		if (frm.email_1.value == '' || frm.email_2.value == '') {
			alert('이메일을 입력하세요');
			frm.email_1.focus();
			return false;
		}

		if (frm.zip1.value == '') {
			alert('우편번호를 입력하세요');
			frm.zip1.focus();
			return false;
		}

		if (frm.addr1.value == '') {
			alert('주소를 입력하세요');
			frm.addr1.focus();
			return false;
		}
		if (frm.addr2.value == '') {
			alert('상세주소 입력하세요');
			frm.addr2.focus();
			return false;
		}
	}

	// 취소 버튼 클릭시 첫화면으로 이동
	function goFirstForm() {
		location.href = "../main/main.jsp";
	}

	//이메일 selectBox 입력갑 넘기기
	function selectEmail(ele) {
		var $ele = $(ele);
		var $email_2 = $('input[name=email_2]'); // '1'인 경우 직접입력 
		if ($ele.val() == "1") {
			$email_2.attr('readonly', false);
			$email_2.val('');
		} else {
			$email_2.attr('readonly', true);
			$email_2.val($ele.val());
		}
	}
</script>

<body>
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
						<td class="con_title"><h3>
								<strong>회원정보 수정</strong>
							</h3>
						<td />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원정보수정
						
						<p>
					</div>

					<p class="join_title">
						<img src="../images/join_tit03.gif" alt="회원정보입력" />
					</p>
					<form action="../member/editMembership" name="registForm" id="registForm"
						method="post" onsubmit="return checkValue(this);">
						<table cellpadding="0" cellspacing="0" border="0" class="join_box">
						
						<input type="hidden" name="id" value="<%=session.getAttribute("ID")%>" />
							<colgroup>
								<col width="80px;" />
								<col width="*" />
							</colgroup>
							<tr>
								<th><img src="../images/join_tit003.gif" /></th>
								<td><input type="password" name="pass" value=""
									class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의
										영문/숫자 조합</span></td>
							</tr>
							<tr>
								<th><img src="../images/join_tit04.gif" /></th>
								<td><input type="password" name="pass2" value=""
									class="join_input" /></td>
							</tr>


							<tr>
								<th><img src="../images/join_tit06.gif" /></th>
								<td><input type="text" name="tel1" value="" maxlength="3"
									class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
									type="text" name="tel2" value="" maxlength="4"
									class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
									type="text" name="tel3" value="" maxlength="4"
									class="join_input" style="width: 50px;" /> &nbsp;&nbsp;<span>*
										전화번호는 필수입력 사항이 아닙니다.</span></td>
							</tr>
							<tr>
								<th><img src="../images/join_tit07.gif" /></th>
								<td><input type="text" name="mobile1" value=""
									maxlength="3" class="join_input" style="width: 50px;" />&nbsp;-&nbsp;
									<input type="text" name="mobile2" value="" maxlength="4"
									class="join_input" style="width: 50px;" />&nbsp;-&nbsp; <input
									type="text" name="mobile3" value="" maxlength="4"
									class="join_input" style="width: 50px;" /></td>
							</tr>
							<tr>
								<th><img src="../images/join_tit08.gif" /></th>
								<td><input type="text" name="email_1"
									style="width: 100px; height: 20px; border: solid 1px #dadada;"
									value="" /> @ <input type="text" name="email_2"
									style="width: 150px; height: 20px; border: solid 1px #dadada;"
									value="" /> <select name="select_email" id="select_email"
									onChange="selectEmail(this)">
										<option selected="" value="0">선택해주세요</option>
										<option value="1">직접입력</option>
										<option value="dreamwiz.com">dreamwiz.com</option>
										<option value="empal.com">empal.com</option>
										<option value="empas.com">empas.com</option>
										<option value="freechal.com">freechal.com</option>
										<option value="hanafos.com">hanafos.com</option>
										<option value="hanmail.net">hanmail.net</option>
										<option value="hotmail.com">hotmail.com</option>
										<option value="intizen.com">intizen.com</option>
										<option value="korea.com">korea.com</option>
										<option value="kornet.net">kornet.net</option>
										<option value="msn.co.kr">msn.co.kr</option>
										<option value="nate.com">nate.com</option>
										<option value="naver.com">naver.com</option>
										<option value="netian.com">netian.com</option>
										<option value="orgio.co.kr">orgio.co.kr</option>
										<option value="paran.com">paran.com</option>
										<option value="sayclub.com">sayclub.com</option>
										<option value="yahoo.co.kr">yahoo.co.kr</option>
										<option value="yahoo.com">yahoo.com</option>
								</select> <input type="checkbox" name="open_email" value="1"> <span>이메일
										수신동의</span></td>
							</tr>
							<tr>
								<th><img src="../images/join_tit09.gif" /></th>
								<td><input type="text" name="zip1" value=""
									id="sample6_postcode" class="join_input" style="width: 100px;" />
									<a href="javascript:;" title="새 창으로 열림"
									onclick="sample6_execDaumPostcode()" onkeypress="">[우편번호검색]</a>
									<br /> <input type="text" name="addr1" value=""
									id="sample6_address" class="join_input"
									style="width: 550px; margin-top: 5px;" /><br> <input
									type="text" name="addr2" value="" id="sample6_detailAddress"
									class="join_input" style="width: 550px; margin-top: 5px;" /> <input
									type="hidden" id="sample6_extraAddress" placeholder="참고항목">
								</td>
							</tr>
						</table>
						<p style="text-align: center; margin-bottom: 20px">
							<button type="submit"">
								<input type="image" src="../images/btn01.gif" />
							</button>
							&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif"
								onclick="goFirstForm()" /></a>
						</p>
					</form>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
