<%@page import="model1.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model1.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
BoardDAO dao = new BoardDAO(application);

// 사용자가 입력한 검색 조건을 MAP에 저장
Map<String, Object> param = new HashMap<String, Object>(); // 파라미터 생성용 맵
String searchField = request.getParameter("searchField"); // 검색 필드 생성
String searchWord = request.getParameter("searchWord"); // 검색 내용 생성

if (searchWord != null){ // searchWord 값이 null 이 아니면 파라미터 메모리에 값 추가
	param.put("searchField", searchField);
	param.put("searchWord", searchWord);
}

int totalCount = dao.selectCount(param); // 위에서 만든 파라미터 값을 매개값으로 전달받아 게시물 수 확인
List<BoardDTO> boardLists = dao.selectList(param); // 위에서 만든 파라미터 값을 매개값으로 전달받아 게시물 목록 받기
dao.close(); // DB 연결 끊기

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List.jsp</title>
</head>
<body>
<!-- DTO, DAO를 활용한 게시물 목록 보기 화면 -->
	<jsp:include page="../Common/Link.jsp"/> <!-- 네비게이션 바 --> 
	
	<h2>목록 보기</h2>
	<!-- 검색 폼 -->
	<form method="get">
		<table border="1" width="90%">
			<tr>
				<td align="center">
					<select name="searchField">
						<option value="title">제목</option>
						<option value="content">내용</option>
					</select>
					<input type="text" name="searchWord"/>
					<input type="submit" value="검색"/>
				</td>
			</tr>
		</table>
	</form>
	
	<!-- 게시물 목록 테이블 -->
	<table border="1" width="90%">
		<tr>
			<!-- 칼럼 이름 -->
			<th width="10%">번호
			<th width="50%">제목
			<th width="15%">작성자
			<th width="10%">조회수
			<th width="15%">작성일
		</tr>
		<!-- 목록 내용 -->
		<%
		if (boardLists.isEmpty()){ // 게시물이 하나도 없을 때
		%>
		<tr>
			<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
		</tr>
		<%
		} else { // 게시물이 있을 때
			int virtualNum = 0; // 화면 상의 게시물 번호
			for (BoardDTO dto : boardLists){
				virtualNum = totalCount--;  // 전체 게시물 수에서 시작해 1씩 감소
		%>
		<tr align="center">
			<td><%= virtualNum %></td> <!-- 게시물 번호 -->
			<td align="left"> <!-- 제목(+ 하이퍼링크) -->
				<a href="View.jsp?num=<%= dto.getNum() %>"><%= dto.getTitle() %></a> <!-- get 방식으로 넘어감 -->
			</td>
			<td align="center"><%= dto.getId() %></td> <!-- 작성자 ID -->
			<td align="center"><%= dto.getVisitcount() %></td> <!-- 조회수 -->
			<td align="center"><%= dto.getPostdate() %></td> <!-- 작성일 -->
		</tr>
		<%
			}
		}
		%>
	</table>
	
	<!-- 목록 하단의 [글쓰기] 버튼 -->
	<table border="1" width="90%">
		<tr align="right">
			<td><button type="button" onclick="location.href='Write.jsp';">글쓰기</button></td>
		</tr>
	</table>
</body>
</html>