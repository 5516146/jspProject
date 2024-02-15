<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="./IsLoggedIn.jsp" %> <!-- 로그인 확인 코드 삽입 --> <!-- include하는 파일은 html 태그 제거 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
	function validateForm(form){ /* 호출하면 form의 매개값을 받음 */
		if (form.title.value == ""){ /* form의 title value가 null이면 */
			alert("제목을 입력하세요."); /* 경고창 띄우고 */
			form.title.focus(); /* title에 커서 올림 */
			return false; /* false값 리턴 */
		}
		if (form.content.value == ""){ /* form의 content value가 null이면 */
			alert("내용을 입력하세요."); /* 경고창 띄우고 */
			form.content.focus();
			return false; /* false값 리턴 */
		}
	}
</script>
<title>Write.jsp</title>
</head>
<body>
	<jsp:include page="../Common/Link.jsp" /> <!-- 네비게이션 바 연결 -->
	<h2>회원제 게시판</h2>
	<form name="writeFrm" method="post" action="WriteProcess.jsp" onsubmit="return validateForm(this);"> <!-- submit 을 눌렀을 때 true 가 반환되면 post 방식으로 WriteProcess로 보냄 -->
		<table border="1" width="90%"> <!-- 굵기가 1이고 넓이가 90%인 테이블 생성 -->
			<tr>
				<td>제목</td>
				<td><input type="text" name="title" style="width:90%;"/></td> <!-- 제목을 입력하는 text 공간 -->
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content" style="width:90%; height:100px"></textarea></td> <!-- 내용을 입력하는 content 공간 -->
			</tr>
			<tr>
				<td colspan="2" align="center"> <!-- 열 2개를 합친 공간 생성 -->
					<button type="submit">작성 완료</button> <!-- 작성 완료 버튼 -->
					<button type="reset">다시 입력</button> <!-- 다시 작성 버튼 -->
					<button type="button" onclick="location.href=List.jsp;">목록 보기</button> <!-- 목록보기 버튼을 누르면 List.jsp로 넘어감 -->
				</td>
			</tr>
		</table>
	</form>
</body>
</html>