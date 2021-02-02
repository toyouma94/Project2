<%@page import="model.MemberDAO"%>
<%@page import="util.CookieUtil"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- LoginProcMap.jsp --%>
<%
request.setCharacterEncoding("UTF-8");

//main.jsp에서 폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");

//저장(체크박스) 네임인(checkSave)을  값을 가져와서.
//변수(checksave)에 값을 넣음.
String checksave = request.getParameter("checkSave");
//디버깅용- System.out.println(checksave);

//DAO객체생성 및 DB연결
MemberDAO dao = new MemberDAO();

//Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap = dao.getMemberMap(id, pass);

dao.close();

System.out.println("아이디 검증전:" + id);

if(memberMap.isEmpty()==false){
   //로그인 성공시 세션영역에 아래 속성을 저장한다.
   session.setAttribute("ID", memberMap.get("id"));
   session.setAttribute("PASS", memberMap.get("pass"));
   session.setAttribute("NAME", memberMap.get("name"));
   
   /*
    1.쿠키객체생성 : new Cookie(쿠키명, 쿠키값)
       : 쿠키명을 설정하는 setName() 함수가 별도로 존재하지 
       않으므로 생성자를 통해 쿠키명을 설정한다. 
    */
   
   //아이디 저장하기 체크박스가 사용자가 체크하면! ...
   if(checksave != null) {

      //체크하면 쿠키를 생성한다. 
      CookieUtil.makeCookie(request, response, "CookId", id, 
            60*60*24);
      System.out.println("저장체크박스 체크O" + checksave);
   }
   else {
      //체크해제하면 쿠키를 삭제한다. 
      CookieUtil.makeCookie(request, response, "CookId", "", 0);
      System.out.println("저장체크박스 체크X" + checksave);
   }
   //메인(로그인이포함된) 페이지로 이동
   response.sendRedirect("../main/main.jsp");
      
}
else{ 
   //로그인 실패시 or 없는회원
   System.out.println("로그인에 실패하여 세션저장이 되지 않았습니다.");
%>
   <head>
      <script>
         alert('등록된 회원이 아닙니다.');
         location.href="../main/main.jsp";
      </script>
   </head>
   
<% } %>



