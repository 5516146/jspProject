<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>LoginForm.jsp</title>
</head>
<body>
<!-- LoginForm은 input 박스의 값을 LoginProcess로 보냄 (req, res) -->
	<!-- 외부에서 만든 메뉴 삽입 -->
	<jsp:include page="../Common/Link.jsp" />
	<h2>로그인 페이지</h2>
	<!-- 로그인에러가 있는지 확인 -->
	<span style="color:red; font-size:1.2em;">
		<%= request.getAttribute("LoginErrMsg") == null ? "" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
	// 로그인 상태인지 확인
	if (session.getAttribute("UserId") == null){
	%>
	<script>
	// 로그인 상태가 아니면
		function validateForm(form) {
			if(!form.user_id.value){
				alter("아이디를 입력하세요.");
				return false;
			}
			if (form.user_pw.value == ""){
				alert("패스워드를 입력하세요.");
				return false;
			}
		}
	</script>
	<!-- onsubmit : submit을 눌렀을 때 제일 먼저 실행 -->
	<form action="LoginProcess.jsp" method="post" name="Loginfrm" onsubmit="return validateForm(this);">
		아이디 : <input type="text" name="user_id"/><br/>
		비밀번호 : <input type="password" name="user_pw"/><br>
		<input type="submit" value="로그인"/>
	</form>
	<%
	} else {
	%>
		<%= session.getAttribute("UserName") %> 회원님, 로그인되셨습니다. <br/>
		<%= session.getAttribute("UserId") %> 회원님, 반값습니다. <br/>
		<a href="Logout.jsp">[로그아웃]</a>
	<%
	}
	%>
</body>
</html>