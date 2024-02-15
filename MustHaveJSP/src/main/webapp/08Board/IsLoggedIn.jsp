<%@page import="utils.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 로그인 여부를 확인하는 프로세스 처리 -->
<%
if (session.getAttribute("UserId") == null){ // 세션에 ID가 있는지 확인
	JSFunction.alertLocation("로그인 후 이용해주세요.", "../06Session/LoginForm.jsp", out); // 없으면 경고창 띄운 후 로그인 폼으로 이동
	return;
}
%>