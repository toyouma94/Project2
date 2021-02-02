<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script type="text/javascript">

function fnLogin(frm){
   
//////////아이디체크 - * 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입
   //아이디 빈값 체크.
   if(frm.id.value==''){
      alert('아이디를 입력하세요.');
      frm.id.focus();
      return false;
   }
   //비밀번호 빈값인지 검사//
   if(frm.pass.value==''){
      alert('비밀번호를 입력하세요.');
      frm.pass.focus();
      return false;
   }
}

</script>

 <body>
   <center>
   <div id="wrap">
      <%@ include file="../include/top.jsp" %>

      <img src="../images/member/sub_image.jpg" id="main_visual" />

      <div class="contents_box">
         <div class="left_contents">
            <%@ include file = "../include/member_leftmenu.jsp" %>
         </div>
         <div class="right_contents">
            <div class="top_title">
               <img src="../images/login_title.gif" alt="인사말" class="con_title" />
               <p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
            </div>
            <div class="login_box01">
               <img src="../images/login_tit.gif" style="margin-bottom:30px;" />
               <form action="loginProcMap.jsp" name="subLogin" id="subLogin" method="post" onsubmit="return fnLogin(this);">
               <ul>
                  <li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" />
                  <input type="text" name="id" value="" class="login_input01" /></li>
                  <li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" />
                  <input type="password" name="pass" value="" class="login_input01" /></li>
               </ul>
               <input type="image" src="../images/login_btn.gif" class="login_btn01" /></a>
               </form>
            </div>
            <p style="text-align:center; margin-bottom:50px;"><a href="/member/id_pw.jsp">
            <img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href=""><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
         </div>
      </div>
      <%@ include file="../include/quick.jsp" %>
   </div>
   

   <%@ include file="../include/footer.jsp" %>
   </center>
 </body>
</html>