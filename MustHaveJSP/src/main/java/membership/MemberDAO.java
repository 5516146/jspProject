package membership;

import java.sql.SQLException;

import common.JDBConnect;

public class MemberDAO extends JDBConnect{
	// JDBC를 연결하여 CRUD를 담당
	// 전에 만든 JDBCConnect를 상속받아 사용
	// 필드
	
	// 생성자
	public MemberDAO(String driver, String url, String id, String pw) { // new JDBCConnect() 자동으로 객체 생성하면서 연결 진행
		super(driver, url, id, pw);
	}
	
	// 메소드
	// 로그인을 실행한 id와 pw가 DB에 있는지 확인
	public MemberDTO getMemberDTO(String userId, String userPw) {
		MemberDTO dto = new MemberDTO(); // 회원 객체 생성
		
		String query = "SELECT * FROM MEMBER WHERE ID=? AND PASS=?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPw);
			rs = pstmt.executeQuery();
			
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString("name"));
				dto.setRegidate(rs.getString(4));
			}
		} catch (SQLException e) {
			System.out.println("getMember() 메소드 오류 발생");
			e.printStackTrace();
		}
		return dto;
	}
}