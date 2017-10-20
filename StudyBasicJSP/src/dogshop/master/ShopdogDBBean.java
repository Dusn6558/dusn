package dogshop.master;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ShopdogDBBean {
	private static ShopdogDBBean instance = new ShopdogDBBean();
	
	public static ShopdogDBBean getInstance() {
		return instance;
	}
	
	private ShopdogDBBean() {
	}
	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context)initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource)envCtx.lookup("jdbc/basicjsp");
		return ds.getConnection();
	}
	
	public int managerCheck(String id,String passwd) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String dbpasswd="";
		String sql="";
		int x=-1;
		
		try {
			conn=getConnection();
			sql="select managerpasswd from manager where managerId=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				dbpasswd=rs.getString("managerpasswd");
				if(dbpasswd.equals(passwd))
					x=1;
				else
					x=0;
			}else
				x=-1;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
			return x;
	}
	public void insertgoods(ShopdogDataBean goods) throws Exception{
		Connection conn=null;
		PreparedStatement pstmt=null;
		String sql="";
		
		try {
			conn = getConnection();
			sql="insert into goods values(seq.nextval,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, goods.getGoods_kind());
			pstmt.setString(2, goods.getGoods_name());
			pstmt.setInt(3, goods.getGoods_price());
			pstmt.setShort(4, goods.getGoods_count());
			pstmt.setString(5,goods.getGoods_com());
			pstmt.setString(6, goods.getGoods_date());
			pstmt.setString(7, goods.getGoods_country());
			pstmt.setString(8, goods.getGoods_image());
			pstmt.setString(9, goods.getGoods_content());
			pstmt.setByte(10, goods.getDiscount_rate());
			pstmt.setTimestamp(11, goods.getReg_date());
			
			pstmt.executeUpdate();
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
	}
	public int getgoodsCount() throws Exception {
		Connection conn=null;
		PreparedStatement pstmt = null;
		String sql="";
		ResultSet rs = null;
		int x=0;
		try {
			conn=getConnection();
			sql="select count(*) from goods";
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			if(rs.next())
				x = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
		return x;
	}
	public List<ShopdogDataBean> getgoodss(String goods_kind) throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		ResultSet rs = null;
		List<ShopdogDataBean> goodsList=null;
		
		try {
			conn = getConnection();
			String sql1 = "select * from goods order by reg_date desc";
			String sql2 = "select * from goods "
					+ "where goods_kind = ? order by reg_date desc";
			
			if(goods_kind.equals("all")) {
				pstmt=conn.prepareStatement(sql1);
			}else {
				pstmt=conn.prepareStatement(sql2);
				pstmt.setString(1, goods_kind);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				goodsList = new ArrayList<ShopdogDataBean>();
				do {
					ShopdogDataBean goods=new ShopdogDataBean();
					
					goods.setGoods_id(rs.getInt("goods_id"));
					goods.setGoods_kind(rs.getString("goods_kind"));
					goods.setGoods_name(rs.getString("goods_name"));
					goods.setGoods_price(rs.getInt("goods_price"));
					goods.setGoods_count(rs.getShort("goods_count"));
					goods.setGoods_com(rs.getString("goods_com"));
					goods.setGoods_date(rs.getString("goods_date"));
					goods.setGoods_country(rs.getString("goods_country"));
					goods.setGoods_image(rs.getString("goods_image"));
					goods.setDiscount_rate(rs.getByte("discount_rate"));
					goods.setReg_date(rs.getTimestamp("reg_date"));
					
					goodsList.add(goods);
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
		return goodsList;
	}
	public ShopdogDataBean[] getgoodss(String goods_kind, int count) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		ShopdogDataBean [] goodsList=null;
		int i=0;
		
		try {
			conn=getConnection();
			
			sql = "select * from "
					+ "(select rownum as rnum, bo.* "
					+ "from(select * from goods where goods_kind=? order by reg_date desc) bo)"
					+ " where rnum between ? and ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, goods_kind);
			pstmt.setInt(2, 0);
			pstmt.setInt(3, count);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				goodsList = new ShopdogDataBean[count];
				do {
					ShopdogDataBean goods=new ShopdogDataBean();
					
					goods.setGoods_id(rs.getInt("goods_id"));
					goods.setGoods_kind(rs.getString("goods_kind"));
					goods.setGoods_name(rs.getString("goods_name"));
					goods.setGoods_price(rs.getInt("goods_price"));
					goods.setGoods_count(rs.getShort("goods_count"));
					goods.setGoods_com(rs.getString("goods_com"));
					goods.setGoods_date(rs.getString("goods_date"));
					goods.setGoods_country(rs.getString("goods_country"));
					goods.setGoods_image(rs.getString("goods_image"));
					goods.setDiscount_rate(rs.getByte("discount_rate"));
					goods.setReg_date(rs.getTimestamp("reg_date"));
					
					goodsList[i]=goods;
					i++;
				}while(rs.next());
			}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
		return goodsList;
	}
	public ShopdogDataBean getgoods(int goodsId)throws Exception{
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		ResultSet rs = null;
		ShopdogDataBean goods=null;
		
		try {
			conn=getConnection();
			sql="select * from goods where goods_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, goodsId);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				goods = new ShopdogDataBean();

				goods.setGoods_kind(rs.getString("goods_kind"));
				goods.setGoods_name(rs.getString("goods_name"));
				goods.setGoods_price(rs.getInt("goods_price"));
				goods.setGoods_count(rs.getShort("goods_count"));
				goods.setGoods_com(rs.getString("goods_com"));
				goods.setGoods_date(rs.getString("goods_date"));
				goods.setGoods_country(rs.getString("goods_country"));
				goods.setGoods_image(rs.getString("goods_image"));
				goods.setGoods_content(rs.getString("goods_content"));
				goods.setDiscount_rate(rs.getByte("discount_rate"));
			
				}
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
		return goods;
	}
	public void updategoods(ShopdogDataBean goods,int goodsId) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		String sql = "";
		int x=-1;
		try {
			conn=getConnection();
			sql = "update goods set goods_kind=?, goods_name=?,goods_price=?,"
					+ "goods_count=?,goods_com=?,goods_date=?, goods_country=?,"
					+ "goods_image=?,goods_content=?,discount_rate=? "
					+ "where goods_id=?";
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setString(1, goods.getGoods_kind());
			pstmt.setString(2, goods.getGoods_name());
			pstmt.setInt(3, goods.getGoods_price());
			pstmt.setShort(4, goods.getGoods_count());
			pstmt.setString(5,goods.getGoods_com());
			pstmt.setString(6, goods.getGoods_date());
			pstmt.setString(7, goods.getGoods_country());
			pstmt.setString(8, goods.getGoods_image());
			pstmt.setString(9, goods.getGoods_content());
			pstmt.setByte(10, goods.getDiscount_rate());
			pstmt.setInt(11,goodsId);
			
			pstmt.executeUpdate();
			x=1;
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
		
	}
	public void deletegoods(int goodsId)throws Exception {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs = null;
		String sql="";
		
		try {
			conn=getConnection();
			sql="delete from goods where goods_id=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, goodsId);
			
			pstmt.executeUpdate();
		}catch(Exception ex) {
			ex.printStackTrace();
		}finally {
			if(rs!=null)
				try {rs.close();}catch(SQLException ex){}
			if(pstmt!=null) 
				try {pstmt.close();}catch(SQLException ex){}
			if(conn!=null) 
				try {conn.close();}catch(SQLException ex){}	
		}
	}
	
}
