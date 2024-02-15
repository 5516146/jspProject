<%@page import="utils.JSFunction"%>
<%@page import="model1.BoardDAO"%>
<%@page import="model1.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- DTO, DAO를 활용하여 JDBC에 게시물 기록 -->
<%
// 폼 값 받기
String title = request.getParameter("title"); // post 방식으로 넘어온 title 값을 저장
String content = request.getParameter("content"); /// post 방식으로 넘어온 content 값을 저장

// 폼 값을 DTO 객체에 저장
BoardDTO dto = new BoardDTO(); // DTO 객체 생성
dto.setTitle(title); // dto 객체에 넘어온 title 값 저장
dto.setContent(content); // dto 객체에 넘어온 content 값 저장
dto.setId(session.getAttribute("UserId").toString()); // dto 객체에 세션에 있는 id 값을 String 으로 변환하여 저장

// DAO 객체를 통해 DB에 DTO 저장
BoardDAO dao = new BoardDAO(application); // DAO 객체를 3번 생성자로 생성하여 DB 연결
int iResult = dao.insertWrite(dto); // inserWrite 에서 넘어온 값을 iResult에 저장
/* int iResult = 0;
for (int i = 1; i < 100; i++){
	dto.setTitle(title + "-" + i); // 제목 글자에 -1부터 -100까지 붙음
	iResult = dao.insertWrite(dto); // insert 쿼리 실행
} */
dao.close(); // 연결된 DB 종료

// 성공 실패 여부
if (iResult == 1){ // 넘어온 iResult 값이 1이면
	response.sendRedirect("List.jsp"); // List.jsp 로 넘김
} else { // 아니면
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out); // 글쓰기 전 화면으로 돌아감
}

%>