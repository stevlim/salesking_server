<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	//���⼭ request.getParameter�� �ȵ���̵忡�� ���� ������ �޽��ϴ�.
	//�ȵ���̵忡�� ���� sendMsg = "id="+strings[0]+"&pwd="+strings[1]; ���⼭
	// Ű���� request.getParameter���� ���� ���ƾ� �մϴ� ���� �翬�� Ÿ�Ե� ���ƾ� �ϱ���.
	String id = request.getParameter("id");
	String pwd = request.getParameter("pwd");
	
	// �ٽ� �ȵ���̵�� ��� ���� ������ ���� ���� out.print�� ����ϸ� �˴ϴ� ����	
	if(id.equals("rain483") && pwd.equals("1234")) {
		out.print("�� true");
	} else {
		out.print("���� false");
	}
%>

