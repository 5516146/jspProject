package fileupload;

import java.sql.SQLException;
import java.util.List;
import java.util.Vector;

import common.DBConnPool;

public class MyfileDAO extends DBConnPool{
	// JDBC 연결해 SQL문을 처리
	// 새로운 게시물을 입력
	
	public int insertFile(MyfileDTO dto) {
		int applyResult = 0;
		try {
			String query = "INSERT INTO MYFILE (IDX, NAME, TITLE, CATE, OFILE, SFILE) VALUES (SEQ_BOARD_NUM.NEXTVAL, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getCate());
			pstmt.setString(4, dto.getOfile());
			pstmt.setString(5, dto.getSfile());
			
			applyResult = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("INSERT 중 예외 발생 (MyfileDAO.insertFile(dto))");
			e.printStackTrace();
		}
		return applyResult;
	}
	
	public List<MyfileDTO> myFileList(){
		List<MyfileDTO> fileList = new Vector<MyfileDTO>();
		
		try {
			String query = "SELECT * FROM MYFILE ORDER BY IDX DESC";
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				MyfileDTO dto = new MyfileDTO();
				dto.setIdx(rs.getString(1));
				dto.setName(rs.getString(2));
				dto.setTitle(rs.getString(3));
				dto.setCate(rs.getString(4));
				dto.setOfile(rs.getString(5));
				dto.setSfile(rs.getString(6));
				dto.setPostdate(rs.getString(7));
				
				fileList.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("SELECT 시 예외 발생 (MyfileDAO.myFileList()");
			e.printStackTrace();
		}
		return fileList;
	}
}