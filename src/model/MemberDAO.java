package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	Connection con; 
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본생성자에서 DBCP(커넥션풀)을 통해 DB연결
	public MemberDAO() {
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context)initCtx.lookup("java:comp/env");			 
			DataSource source = (DataSource)ctx.lookup("jdbc_mariadb");
			con = source.getConnection();
			System.out.println("DBCP연결성공");
		}
		catch(Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}		
	}
	
	
	/*
	데이터베이스의 연결을 해제할때 사용. 
	컴퓨터는 한정된 자원을 사용하므로 연결했다면 반드시
	연결을 해제해줘야 한다.  
	*/
	public void close() {
		try {
			//사용된 자원이 있다면 자원해제 해준다.
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
    public boolean duplicateIdCheck(String id)
    {
    	String query = "SELECT count(id) FROM membership WHERE ID=?";
    	
    	int isMember = 0;
    	boolean isFlag = false;
   
        try {
                 
        	psmt = con.prepareStatement(query);
 
        	psmt.setString(1, id);
        	rs = psmt.executeQuery();
        	
        	rs.next();
            
        	isMember = rs.getInt(1);
        	System.out.println("affected:"+isMember);
        	if(isMember==0) //회원이 아닌경우
				isFlag = false;
			else //회원인 경우(해당 아이디,패스워드가 일치함)
				isFlag = true; 
            
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return isFlag;
    } // end duplicateIdCheck()
    
    //아이디찾기
    public String IdSearch(String name,String email)
    {
    	String id=null;//찾을 아이디
    	
    	String query = "SELECT id FROM membership WHERE name=? AND email=?";
    	
        try {
                 
        	psmt = con.prepareStatement(query);
        	psmt.setString(1, name);
        	psmt.setString(2, email);
        	
        	rs = psmt.executeQuery();
            while(rs.next()) {
            	id=rs.getString("id");
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return id;
    } 
    //비번찾기
    public String IdPass(String id,String name,String email)
    {
    	String pass=null;//찾을 아이디
    	
    	String query = "SELECT pass FROM membership WHERE id=? AND name=? AND email=?";
    	
        try {
                 
        	psmt = con.prepareStatement(query);
        	psmt.setString(1, id);
        	psmt.setString(2, name);
        	psmt.setString(3, email);
        	
        	rs = psmt.executeQuery();
            while(rs.next()) {
            	pass=rs.getString("pass");
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return pass;
    } 

	public int insertWrite(MemberDTO dto) {
		int affected = 0;
		try {
			/*
			데이터 입력을 위한 insert문 작성. 
			MariaDB에서는 시퀀스 대신 자동증가 컬럼을 사용한다.
			해당 컬럼에 auto_increment를 부여하게되면 레코드 삽입시
			자동으로 증가하는 컬럼이 된다. insert문 작성시 해당 컬럼은
			명시하지 않는다.
			 */
			String query = "INSERT INTO membership ( "
				+ " id,pass,name,open_email,email,telephone,cellphone,address,admin) "
				+ " VALUES ( "
				+ " ?, ?, ?, ?, ?, ?, ?, ?, 'F')";

			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getOpen_email());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getTelephone());
			psmt.setString(7, dto.getCellphone());
			psmt.setString(8, dto.getAddress());
			//psmt.setString(9, dto.getAdmin());
			
			/*
			쿼리문 실행시 사용하는 메소드
			 	executeQuery() : select계열의 쿼리문을
			 		실행할때 사용한다. 행에 영향을 주지않고
			 		조회를 위해 사용된다. 반환타입은 ResultSet이다.
			 	executeUpdate() : insert,delete,update
			 		쿼리문을 실행할때 사용한다. 행에 영향을 주게되고
			 		반환타입은 쿼리의 영향을 받은 행의 갯수가 반환되므로
			 		int형이 된다. 			 
			 */
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		
		return affected;
	}
	//회원정보수정
	public int EditWrite(MemberDTO dto) {
		int affected = 0;
		try {
			/*
			데이터 입력을 위한 insert문 작성. 
			MariaDB에서는 시퀀스 대신 자동증가 컬럼을 사용한다.
			해당 컬럼에 auto_increment를 부여하게되면 레코드 삽입시
			자동으로 증가하는 컬럼이 된다. insert문 작성시 해당 컬럼은
			명시하지 않는다.
			 */
			String query = "UPDATE membership SET "
					+ " pass=? ,open_email=? ,email=? ,telephone=? ,cellphone=? ,address=? "
					+ " WHERE id=? ";
			
			psmt = con.prepareStatement(query);
			System.out.println(query);
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getOpen_email());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getTelephone());
			psmt.setString(5, dto.getCellphone());
			psmt.setString(6, dto.getAddress());
			psmt.setString(7, dto.getId());

			//psmt.setString(9, dto.getAdmin());
			
			/*
			쿼리문 실행시 사용하는 메소드
			 	executeQuery() : select계열의 쿼리문을
			 		실행할때 사용한다. 행에 영향을 주지않고
			 		조회를 위해 사용된다. 반환타입은 ResultSet이다.
			 	executeUpdate() : insert,delete,update
			 		쿼리문을 실행할때 사용한다. 행에 영향을 주게되고
			 		반환타입은 쿼리의 영향을 받은 행의 갯수가 반환되므로
			 		int형이 된다. 			 
			 */
			affected = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("edit중 예외발생");
			e.printStackTrace();
		}
		
		return affected;
	}
	//로그인방법3 : DTO객체 대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMemberMap(String id,
			String pwd){
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();

		String query = "SELECT id, pass, name FROM "
				+ " membership WHERE id=? AND pass=?";
		System.out.println(id+"<>"+pwd);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();

			//회원정보가 있다면 put()을 통해 정보를 저장한다.
			if(rs.next()) {
				maps.put("id", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
				maps.put("name", rs.getString("name"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch(Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}

		return maps;
	}
	//관리자 로그인 : DTO객체 대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> adminMemberMap(String email,
			String pwd){
		
		//회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();
		
		String query = "SELECT email, pass FROM "
				+ " membership WHERE email=? AND pass=?";
		System.out.println(email+"<>"+pwd);
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, email);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();
			
			//회원정보가 있다면 put()을 통해 정보를 저장한다.
			if(rs.next()) {
				maps.put("email", rs.getString(1));
				maps.put("pass", rs.getString("pass"));
			}
			else {
				System.out.println("결과셋이 없습니다.");
			}
		}
		catch(Exception e) {
			System.out.println("getMemberDTO오류");
			e.printStackTrace();
		}
		
		return maps;
	}
	//관리자 T,F 반환
    public String AdminCheck(String email)
    {
    	String admin=null;//찾을 아이디
    	
    	String query = "SELECT admin FROM membership WHERE email=? ";
    	
        try {
                 
        	psmt = con.prepareStatement(query);
        	psmt.setString(1, email);
        	
        	rs = psmt.executeQuery();
            while(rs.next()) {
            	admin=rs.getString("admin");
            }
        } catch (Exception e) {
        	e.printStackTrace();
        }
        
        return admin;
    } 
	
	
}
