package ch13.board;

import java.sql.*;
import java.util.*;
import javax.naming.*;
import javax.sql.*;

public class BoardDBBean {
	private static BoardDBBean instance = new BoardDBBean();
	//클레스의 메소드 접근시 필요 싱글턴페턴
	public static BoardDBBean getInstance() {
		return instance;
	}
	private BoardDBBean() {}
	//2번 방법//커넥션 폴로부터 connection 객체를 얻어냄//커넥션풀을 사용하는 방법
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	//1번방법 jdbc 드라이버를 사용하는 방법  387page
	
//	private Connection getConnection() throws Exception {
//		Connection conn =  null;
//		String jdbcUrl = "jdbc:mysql://localhost:3306/basicjsp";
//		String dbId="jspid";
//		String dbPass="jsppass";
//		
//		Class.forName("com.mysql.jdbc.Driver");
//		conn = DriverManager.getConnection(jdbcUrl,dbId,dbPass);
//		
//		return conn;
//	}
	//테이블을 추가 writePro
	public void insertArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "";
		
		int num=article.getNum();
		int ref=article.getRef();
		int re_step=article.getRe_step();
		int re_level=article.getRe_level();
		int number=0;
		
		try {
			conn = getConnection();
			sql="select max(num) from board";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				number=rs.getInt(1)+1;
			else
				number=1;
			
			if(num!=0) {
				sql="update board set re_step=re_step+1 where ref=? and re_step>?";
				pstmt=conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step=re_step+1;
				re_level=re_level+1;
				
			}else {
				ref=number;
				re_step=0;
				re_level=0;
			}
			sql="insert into board(num,writer,email,subject,passwd,reg_date,"
					+ "ref,re_step,re_level,content,ip) values(?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			pstmt.setString(2, article.getWriter());
			pstmt.setString(3, article.getEmail());
			pstmt.setString(4, article.getSubject());
			pstmt.setString(5, article.getPasswd());
			pstmt.setTimestamp(6, article.getReg_date());
			pstmt.setInt(7,ref);
			pstmt.setInt(8,re_step);
			pstmt.setInt(9, re_level);
			pstmt.setString(10, article.getContent());
			pstmt.setString(11, article.getIp());
			
			pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
	}
	//전체 글의 수 list
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		
		int x = 0;
		
		try {
			conn= getConnection();
			sql="select count(*) from board";
			pstmt=conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				x=rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return x;
	}
	// 글의 목록 여러개 가져오기 list
	public List<BoardDataBean> getArticles(int start, int end) throws Exception{
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		List<BoardDataBean> articleList=null;
		
		try {
			conn= getConnection();
//			sql="select * from board order by ref desc, re_step asc limit ?,?";
			sql = "select * from "
					+ "(select rownum as rnum, bo.*"
					+ " from (select * from board order by ref desc, re_step asc) bo)"
					+ " where rnum between ? and ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, start-1);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				articleList = new ArrayList<BoardDataBean>(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setWriter(rs.getString("writer"));
					article.setEmail(rs.getString("email"));
					article.setSubject(rs.getString("subject"));
					article.setPasswd(rs.getString("passwd"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));
					article.setIp(rs.getString("ip"));
					articleList.add(article);
				}while(rs.next());
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return articleList;
	}
	//글의 내용보기 content
	public BoardDataBean getArticle( int num)throws Exception {
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		BoardDataBean article = null;
		
		try {
			conn= getConnection();
			sql="update board set readcount=readcount+1 where num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			pstmt.executeUpdate();
			
			sql="select * from board where num=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return article;
	}
	//글수정폼에서 사용할 글의 내용 updateForm
	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		BoardDataBean article = null;
		
		try {
			conn= getConnection();
			sql="select * from board where num =?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setWriter(rs.getString("writer"));
				article.setEmail(rs.getString("email"));
				article.setSubject(rs.getString("subject"));
				article.setPasswd(rs.getString("passwd"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
				article.setIp(rs.getString("ip"));				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return article;
	}
	//글 수정처리 updatePro
	public int updateArticle(BoardDataBean article) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql = "";
		String dbpasswd="";
		int x=-1;
		try {
			conn = getConnection();
			sql="select passwd from board where num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, article.getNum());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd=rs.getString("passwd");
				if(dbpasswd.equals(article.getPasswd())) {
					sql="update board set writer =?, email=?,subject=?,passwd=?,content=? where num=?";
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setString(1, article.getWriter());
					pstmt.setString(2, article.getEmail());
					pstmt.setString(3, article.getSubject());
					pstmt.setString(4, article.getPasswd());
					pstmt.setString(5, article.getContent());
					pstmt.setInt(6, article.getNum());
					pstmt.executeUpdate();
					x=1;
				}else{
					x=0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return x;
	}
	//글삭제 처리 deletePro
	public int deleteArticle(int num,String passwd) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		String dbpasswd="";
		String sql="";
		ResultSet rs = null;
		int x=-1;
		try {
			conn=getConnection();
			
			sql="select passwd from board where num = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,num);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd=rs.getString("passwd");
				if(dbpasswd.equals(passwd)) {
					sql="delete from board where num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x=1; //글삭제 성공
				}else
					x=0; //비빌번호 틀림
				}
			}
		catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs != null)try {rs.close();}catch(Exception e) {e.printStackTrace();}
			if(pstmt != null)try {pstmt.close();}catch(Exception e) {e.printStackTrace();}
			if(conn != null)try {conn.close();}catch(Exception e) {e.printStackTrace();}
		}
		return x;
	}
}
