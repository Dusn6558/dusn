package dogshop.shopping;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import dogshop.master.ShopdogDataBean;

public class bankDBBean {
	private static bankDBBean instance = new bankDBBean();
	
	public static bankDBBean getInstance() {
		return instance;
	}
	
	private bankDBBean() {}
	
	private Connection getConnection() throws Exception {
        Context initCtx = new InitialContext();
        Context envCtx = (Context) initCtx.lookup("java:comp/env");
        DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
        return ds.getConnection();
    }public List<String> getAccount(){
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> accountList = null;
        try {
            conn = getConnection();
                        
            pstmt = conn.prepareStatement("select * from bank");
            rs = pstmt.executeQuery();
            
            accountList = new ArrayList<String>();
            
            while (rs.next()) {
           	  String account = new String(rs.getString("account")+" "
                     + rs.getString("bank")+" "+rs.getString("name"));
           	  accountList.add(account);
		    }
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
        return accountList;
    }
	 public void insertAccount(bankDataBean member)throws Exception {
			    	Connection conn = null;
			        PreparedStatement pstmt = null;
			        String sql="";
			        try {
			            conn = getConnection();
			            sql = "insert into bank values(?,?,?,?)";
			            pstmt = conn.prepareStatement(sql);
			            pstmt.setString(1, member.getId());
			            pstmt.setString(2, member.getAccount());
			            pstmt.setString(3, member.getBank());
			            pstmt.setTimestamp(4, member.getReg_date());
			            pstmt.executeUpdate();
			        }catch(Exception ex) {
			        	ex.printStackTrace();
			        } finally {
			            if (pstmt != null) 
			            	try { pstmt.close(); } catch(SQLException ex) {}
			            if (conn != null) 
			            	try { conn.close(); } catch(SQLException ex) {}
			        }
			    }
	/*public List<String> getAccount(String id) throws Exception{
    	Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<String> accountList = null;
        String sql = "";
        try {
            conn = getConnection();
            sql = "select account, bank, name from "
            		+ "member m inner join bank b on m.id = b.id"
            		+ " where b.id = ? "
            		+ " order by b.reg_date desc";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            rs = pstmt.executeQuery();
            
            accountList = new ArrayList<String>();
            
            while (rs.next()) {
           	  String account = new String(rs.getString("account")+" "
                     + rs.getString("bank")+" "+rs.getString("name"));
           	  accountList.add(account);
		    }
        }catch(Exception ex) {
        	ex.printStackTrace();
        } finally {
            if (pstmt != null) 
            	try { pstmt.close(); } catch(SQLException ex) {}
            if (conn != null) 
            	try { conn.close(); } catch(SQLException ex) {}
        }
        return accountList;
    }*/
	public List<bankDataBean> getbankAccount(String id) throws Exception{
		Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        List<bankDataBean> bankList= null;
        String sql = "";
        try {
        	conn = getConnection();
        	sql = "select * from bank where id = ?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setString(1, id);
        	
        	rs = pstmt.executeQuery();
        	bankList = new ArrayList<bankDataBean>();
		
        	while(rs.next()) {
        		
        		bankDataBean bank=new bankDataBean();
        		bank.setId(rs.getString("id"));
        		bank.setAccount(rs.getString("account"));
        		bank.setBank(rs.getString("bank"));
        		bank.setReg_date(rs.getTimestamp("reg_date"));
        	}
        
		}catch(Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null) 
	        	try { rs.close(); } catch(SQLException ex) {}
	        if (pstmt != null) 
	        	try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) 
	        	try { conn.close(); } catch(SQLException ex) {}
	    }
        return bankList;
	}
	public void updateAccount(bankDataBean bank, String account) throws Exception{
		Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
        	conn = getConnection();
        	sql = "update bank set account=?, bank=?, reg_date=? "
        			+ "where id=? and account=?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setString(1, bank.getAccount());
        	pstmt.setString(2, bank.getBank());
        	pstmt.setTimestamp(3, bank.getReg_date());
        	pstmt.setString(4, bank.getId());
        	pstmt.setString(5, account);
        	
        	pstmt.executeUpdate();
        }catch(Exception e) {
			e.printStackTrace();
		} finally {
	        if (pstmt != null) 
	        	try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) 
	        	try { conn.close(); } catch(SQLException ex) {}
	    }
	}
	public void deleteAccount(String id, String account) throws Exception{
		Connection conn = null;
        PreparedStatement pstmt = null;
        String sql = "";
        try {
        	conn = getConnection();
        	sql = "delete from bank where id=? and account=?";
        	pstmt = conn.prepareStatement(sql);
        	pstmt.setString(1, id);
        	pstmt.setString(2, account);
        	pstmt.executeUpdate();
        }catch(Exception e) {
			e.printStackTrace();
		} finally {
	        if (pstmt != null) 
	        	try { pstmt.close(); } catch(SQLException ex) {}
	        if (conn != null) 
	        	try { conn.close(); } catch(SQLException ex) {}
	    }
	}

}
