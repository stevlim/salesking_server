<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<%@ page import = "java.sql.*" %>
<%



Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.

PreparedStatement pstmt = null;

ResultSet rs = null;

try{

	String url = "jdbc:mysql://202.68.234.54:3306/android_board";        // ����Ϸ��� �����ͺ��̽����� ������ URL ���

	String id = "root";                                                    // ����� ����

	String pw = "koiware`123";                                                // ����� ������ �н�����



Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.

conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.



String sql = "SELECT SEQ, GENRE, REG_NM, APP_NM, APP_LINK, APP_PRICE, APP_DESC, DISCOUNT_YN, DISCOUNT_PER, DOWN_CNT, REG_DT, IMG_URL FROM TB_APP_INFO WHERE APP_EVENT_TYPE = '1' ";                        // sql ����

pstmt = conn.prepareStatement(sql);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

//pstmt.setString(1,"test");



rs = pstmt.executeQuery();                                        // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.

JSONObject jsonMain = new JSONObject();
JSONArray jArray = new JSONArray();


while(rs.next()){                                                        // ����� �� �྿ ���ư��鼭 �����´�.

JSONObject jObject = new JSONObject();

String seq = rs.getString("SEQ");

String genre = rs.getString("GENRE");

String regNm = rs.getString("REG_NM");

String appNm = rs.getString("APP_NM");

int downCnt = rs.getInt("DOWN_CNT"); 

String imgUrl = rs.getString("IMG_URL"); 

//System.out.print(seq + " : " + genre + " : " + regNm + " : " + appNm + " : ");

jObject.put("seq", seq);
jObject.put("genre", genre);
jObject.put("regNm", regNm);
jObject.put("appNm", appNm);
jObject.put("downCnt", downCnt);
jObject.put("imgUrl", imgUrl);

System.out.println("seq : " + jObject.toString());

jArray.put(jObject);
}

jsonMain.put("dataSend", jArray);

System.out.print("jsonMain : " + jsonMain);

out.println(jsonMain); 

out.flush();

}catch(Exception e){                                                    // ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.

e.printStackTrace();

out.println("member ���̺� ȣ�⿡ �����߽��ϴ�.");

}finally{                                                            // ������ ���� �Ǵ� ���п� ������� ����� �ڿ��� ���� �Ѵ�.  (�����߿�)

if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset ��ü ����

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement ��ü ����

if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection ����

}

%>
