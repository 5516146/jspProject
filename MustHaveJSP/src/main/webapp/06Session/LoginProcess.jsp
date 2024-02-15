<%@page import="membership.MemberDTO"%>
<%@page import="membership.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 로그인 폼으로부터 받은 아이디와 패스워드
String userId = request.getParameter("user_id");
String userPwd = request.getParameter("user_pw");

// web.xml에서 가져온 DB 연결 정보
String oracleDriver = application.getInitParameter("OracleDriver");
String oracleURL = application.getInitParameter("OracleURL");
String oracleId = application.getInitParameter("OracleId");
String oraclePwd = application.getInitParameter("OraclePwd");

// JDBC 연결 (dto, dao 셋팅 후 진행)
MemberDAO dao = new MemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd); // JDBC 연결
MemberDTO dto = dao.getMemberDTO(userId, userPwd); // 폼으로 받은 값을 getMemberDTO에 매개값으로 전달

dao.close(); // JDBC 연결 해제

// id pw 를 넣어 찾은 값을 dto에 넘겨줌
if (dto.getId() != null){ // dto 객체에 id가 있으면
	session.setAttribute("UserId", dto.getId()); // 세션 영역에 dto id 값을 넣음
	session.setAttribute("UserName", dto.getName()); // 세션 영역에 dto name 값을 넣음
	response.sendRedirect("LoginForm.jsp"); // 응답을 LoginForm으로 돌아감
} else { // 없으면
	request.setAttribute("LoginErrMsg", "로그인 오류입니다."); // 요청 영역에 에러 메세지를 넣음
	request.getRequestDispatcher("LoginForm.jsp").forward(request, response); // LoginForm으로 돌아감
}

%>    
    
    
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginProcess.jsp</title>
</head>
<body>
	<!-- JDBC를 활용하여 memberDTO를 가져와 세션에 저장 -->
	
	
</body>
</html>