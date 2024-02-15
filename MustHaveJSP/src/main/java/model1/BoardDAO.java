package model1;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class BoardDAO extends JDBConnect{
	// 필드
	
	// 생성자
	public BoardDAO(ServletContext app) { // servletcontext 톰캣
		super(app);
	}
	// 메소드
	// 게시물 개수 세기 (목록에 출력할 게시물을 얻어오기)
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0; // 게시물 수를 담을 변수
		
		// 게시물 수를 얻어오는 쿼리문
		String query = "SELECT COUNT(*) FROM BOARD";
		if (map.get("searchWord") != null) {
			query += " WHERE " + map.get("searchField") + " " + " LIKE '%" + map.get("searchWord") + "%'";
		}
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			rs.next(); // 커서를 첫번째 행으로 이동
			totalCount = rs.getInt(1); // 첫번째 칼럼값을 가져옴
		} catch (SQLException e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		return totalCount;
	}
	
	// 검색 조건에 맞는 게시물 목록 반환
	public List<BoardDTO> selectList(Map<String, Object> map){
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // 결과 담을 리스트 변수 벡터형으로 생성
		
        String query = "SELECT * FROM board "; 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY num DESC "; 
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			
			while (rs.next()) { // 다음값이 없을 때까지 반복
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("NUM"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("ID"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto); // 결과를 리스트 변수에 저장
			}
		} catch (SQLException e) {
			System.out.println("게시물 조회 중 오류 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	// 검색 조건에 맞는 게시물 목록 반환
	public List<BoardDTO> selectListPage(Map<String, Object> map){
		List<BoardDTO> bbs = new Vector<BoardDTO>(); // 결과 담을 리스트 변수 벡터형으로 생성
		
        String query ="SELECT * FROM("
        		+ "SELECT TB.*, ROWNUM RNUM FROM("
        		+ "SELECT * FROM BOARD "; 
        if (map.get("searchWord") != null) {
            query += " WHERE " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY NUM DESC)TB) WHERE RNUM BETWEEN ? AND ?"; 
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, map.get("start").toString());
			pstmt.setString(2, map.get("end").toString());
			
			rs = pstmt.executeQuery();
			
			while (rs.next()) { // 다음값이 없을 때까지 반복
				BoardDTO dto = new BoardDTO();
				
				dto.setNum(rs.getString("NUM"));
				dto.setTitle(rs.getString("TITLE"));
				dto.setContent(rs.getString("content"));
				dto.setId(rs.getString("ID"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getString("visitcount"));
				
				bbs.add(dto); // 결과를 리스트 변수에 저장
			}
		} catch (SQLException e) {
			System.out.println("게시물 조회 중 오류 발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	// 게시글의 데이터를 받아 DB에 추가
	public int insertWrite(BoardDTO dto) {
		int result = 0; // 결과값을 반환할 변수 생성
		
		try {
			String query = "INSERT INTO BOARD(NUM, TITLE, CONTENT, ID, VISITCOUNT)"
						+ " VALUES(SEQ_BOARD_NUM.NEXTVAL, ?, ?, ?, 0)"; // 쿼리문 작성
			pstmt = conn.prepareStatement(query); // 쿼리문 생성
			pstmt.setString(1, dto.getTitle()); // 쿼리문에 값 삽입
			pstmt.setString(2, dto.getContent()); // 쿼리문에 값 삽입
			pstmt.setString(3, dto.getId()); // 쿼리문에 값 삽입
			
			result = pstmt.executeUpdate(); // result 변수에 결과값 삽입
		} catch (SQLException e) {
			System.out.println("게시물 입력 중 오류 발생 (insertWrite)");
			e.printStackTrace();
		}
		return result; // 결과값 리턴
	}
	
	// 게시물 클릭 시 조회수 증가
	public void updateVisitCount(String num) {
		try {
			String query = "UPDATE BOARD SET VISITCOUNT=VISITCOUNT+1 WHERE NUM=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, num);
			pstmt.executeQuery();
		} catch (SQLException e) {
			System.out.println("게시물 조회수 증가 오류 (updateVisitCount)");
			e.printStackTrace();
		}
	}
	
	// 자세히 보기 (번호를 받아 dto 로 리턴)
	public BoardDTO selectView(String num) {
		BoardDTO dto = new BoardDTO(); // DTO 객체 생성
		
		try {
			String query = "SELECT B.*, M.NAME FROM MEMBER M INNER JOIN BOARD B ON M.ID=B.ID WHERE NUM=?"; // 쿼리문 작성
			pstmt = conn.prepareStatement(query); // 쿼리문 생성
			pstmt.setString(1, num); // 넘어온 num 값을 쿼리문에 삽입
			rs = pstmt.executeQuery(); // 쿼리문 실행
			
			if (rs.next()) { // 쿼리문 처리 값이 있으면
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getString("visitcount"));
				dto.setName(rs.getString("name")); // DTO 객체에 값을 저장
			}
		} catch (SQLException e) {
			System.out.println("상세보기 중 오류 발생 (selectView)");
			e.printStackTrace();
		}
		return dto; // DTO 객체에 저장 한 값을 리턴
	}
	
	// 업데이트용 메소드
	public int updateEdit(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "UPDATE BOARD SET TITLE=?, CONTENT=? WHERE NUM=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getNum());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("게시물 수정 중 오류 발생 (updateEdit)");
			e.printStackTrace();
		}
		return result;
	}
	
	// 게시물 삭제 메소드
	public int deletePost(BoardDTO dto) {
		int result = 0;
		
		try {
			String query = "DELETE FROM BOARD WHERE NUM=?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dto.getNum());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("게시물 삭제 중 오류 발생 (deletePost)");
			e.printStackTrace();
		}
		return result;
	}
	
}