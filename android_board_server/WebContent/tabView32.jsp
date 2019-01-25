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



String sql = "SELECT CODE_CL, CODE1, CODE2, DESC1, COL_NM  "
	+ " FROM TB_CODE "
	+ " WHERE 1=1 "
	+ " AND USE_FLG = '1' "
	+ " AND CODE1 != '****' "
	+ " ORDER BY ORDER_NO "

;


pstmt = conn.prepareStatement(sql);                          // prepareStatement���� �ش� sql�� �̸� �������Ѵ�.

//pstmt.setString(1,"test");



rs = pstmt.executeQuery();                                        // ������ �����ϰ� ����� ResultSet ��ü�� ��´�.

JSONObject jsonMain = new JSONObject();
JSONArray jArray = new JSONArray();


while(rs.next()){                                                        // ����� �� �྿ ���ư��鼭 �����´�.

JSONObject jObject = new JSONObject();

String categoryCd = rs.getString("CODE1");

String categoryImgUrl = rs.getString("CODE2");

String categoryNm = rs.getString("DESC1");



jObject.put("categoryCd", categoryCd);
jObject.put("categoryImgUrl", categoryImgUrl);
jObject.put("categoryNm", categoryNm);



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



