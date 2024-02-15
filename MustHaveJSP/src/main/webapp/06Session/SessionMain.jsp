<%@page import="java.sql.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 세션 정보 만들기 -->
<%
// 날짜 표기 형식
SimpleDateFormat dateFormat = new SimpleDateFormat("HH:mm:ss");

// 최초 요청(세션 생성) 시각
long creationTime = session.getCreationTime();
String creationTimeStr = dateFormat.format(new Date(creationTime));

// 마지막 요청 시각
long lastTime = session.getLastAccessedTime();
String lastTimeStr = dateFormat.format(new Date(lastTime));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SessionMain.jsp</title>
</head>
<body>
	<h2>Session 설정 확인</h2>
	<ul>
		<li>세션 유지 시간(프로젝트) : <%= session.getMaxInactiveInterval() %>
		<li>세션 아이디(현재 id) : <%= session.getId() %>
		<li>최초 요청 시간 : <%= creationTimeStr %>
		<li>마지막 요청 시간 : <%= lastTimeStr %>
	</ul>
	
	
</body>
</html>