package model;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


//@WebServlet("/member/edit")
public class WriteEdit extends HttpServlet {
	
	/*
	글쓰기 페이지로 진입했을때의 요청을 처리한다. 글쓰기 폼으로 이동(location)하는것은
	get방식이므로 doGet()에서 처리한다. 
	 */
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		/*
		글쓰기 페이지로 진입할때는 다른 처리없이 포워드만 하면 된다. 
		 */
		req.getRequestDispatcher("/member/editMembership.jsp")
			.forward(req, resp);
	}
	/*
	글 작성을 완료한 후 서버로 전송(submit)할때의 요청을 처리한다. 게시판에 글을 쓸때는
	post방식으로 처리하게된다. 
	 */
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		
		//한글처리
		req.setCharacterEncoding("UTF-8");
		
			String pass = req.getParameter("pass");
			String telephone = req.getParameter("tel1")+'-'+req.getParameter("tel2")+'-'+req.getParameter("tel3");
			String cellphone = req.getParameter("mobile1")+'-'+req.getParameter("mobile2")+'-'+req.getParameter("mobile3");
			String open_email = req.getParameter("open_email");
			String email = req.getParameter("email_1")+'@'+req.getParameter("email_2");
			String address = req.getParameter("zip1")+req.getParameter("addr1")+req.getParameter("addr2");
			String id = req.getParameter("id");
			//String admin = req.getParameter("admin");
			
			//DTO객체에 위의 폼값을 저장한다. 
			MemberDTO dto = new MemberDTO();

			dto.setPass(pass);
			dto.setTelephone(telephone);
			dto.setCellphone(cellphone);
			
			if(open_email == null) {
				open_email = "F";
			}
			else {
				open_email = "T";
			}
			dto.setOpen_email(open_email);
			dto.setEmail(email);
			dto.setAddress(address);
			dto.setId(id);
			//dto.setAdmin(admin);
			
			//DAO객체생성 및 연결...insert처리
			MemberDAO dao = new MemberDAO();
			dao.EditWrite(dto);
			//파일업로드 성공 및 insert성공시..
						
			dao.close();
			
			
			req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
		
	}
}





