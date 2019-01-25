package android_board_server;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class Vision_Write {
	private static Vision_Write vision = new Vision_Write();

	public static Vision_Write getWrite() {
		return vision;
	}
	private String returns = "";
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private PreparedStatement pstmt2 = null;
	private ResultSet rs = null;

	public String write(String content) {
	    try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/OracleDB");
		conn = ds.getConnection();

		Statement stmt = conn.createStatement();
		String seq = "select max(SEQ) from TB_APP_INFO";
		ResultSet rs = stmt.executeQuery(seq);

		int num = -1;
		if (rs.next())
			num = rs.getInt(1);
		num++;

		String nowTime = getCurrentTime("YYYY,M,d");
		System.out.println(nowTime);

		System.out.println("시간확인" + nowTime);

		String sql = "INSERT INTO TB_APP_INFO (GENRE, REG_NM, APP_NM, APP_LINK, APP_PRICE, APP_DESC, DISCOUNT_YN, DISCOUNT_PER, DOWN_CNT, REG_DT)  " 
				+ " ('GAME', '김코이2', '코이 키우기2', '', 1000, '코이를 키우는 게임2', 'N', 0, 123123, '20190103121111')";
				//+ " values('"+ num +"','" + nowTime + "','" + content + "')";
		pstmt = conn.prepareStatement(sql);
		pstmt.executeUpdate();
		returns = "success";

	} catch (Exception e) {
		e.printStackTrace();
	} finally {
	    if (pstmt != null)
		try {
			pstmt.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    if (rs != null)
		try {
			rs.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	    if (conn != null)
		try {
			conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	return returns;
       }
        public static String getCurrentTime(String timeFormat) {
	       return new SimpleDateFormat(timeFormat).format(System.currentTimeMillis());
        }
}