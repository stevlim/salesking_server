<%@page import="org.json.JSONArray"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR" %>

<%@ page import = "java.sql.*" %>
<%



Connection conn = null;                                        // null로 초기화 한다.

PreparedStatement pstmt = null;

ResultSet rs = null;

try{

	String url = "jdbc:mysql://202.68.234.54:3306/android_board";        // 사용하려는 데이터베이스명을 포함한 URL 기술

	String id = "root";                                                    // 사용자 계정

	String pw = "koiware`123";                                                // 사용자 계정의 패스워드



Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.

conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.



String sql = "SELECT SEQ, GENRE, REG_NM, APP_NM, APP_LINK, APP_PRICE, APP_DESC, DISCOUNT_YN, DISCOUNT_PER, DOWN_CNT, REG_DT, IMG_URL FROM TB_APP_INFO WHERE APP_EVENT_TYPE = '1' ";                        // sql 쿼리

pstmt = conn.prepareStatement(sql);                          // prepareStatement에서 해당 sql을 미리 컴파일한다.

//pstmt.setString(1,"test");



rs = pstmt.executeQuery();                                        // 쿼리를 실행하고 결과를 ResultSet 객체에 담는다.

JSONObject jsonMain = new JSONObject();
JSONArray jArray = new JSONArray();


while(rs.next()){                                                        // 결과를 한 행씩 돌아가면서 가져온다.

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

}catch(Exception e){                                                    // 예외가 발생하면 예외 상황을 처리한다.

e.printStackTrace();

out.println("member 테이블 호출에 실패했습니다.");

}finally{                                                            // 쿼리가 성공 또는 실패에 상관없이 사용한 자원을 해제 한다.  (순서중요)

if(rs != null) try{rs.close();}catch(SQLException sqle){}            // Resultset 객체 해제

if(pstmt != null) try{pstmt.close();}catch(SQLException sqle){}   // PreparedStatement 객체 해제

if(conn != null) try{conn.close();}catch(SQLException sqle){}   // Connection 해제

}

%>
