package model1;

public class BoardDTO {
	// DB 필드값과 동일한 객체 생성
	// 필드
	private String num; // 번호
	private String title; // 제목
	private String content; // 내용
	private String id; // 게시ID
	private java.sql.Date postdate; // 작성일
	private String visitcount; // 조회수
	private String name; // 작성자
	
	// 생성자
	public BoardDTO() {}

	// 메소드
	// getter
	public String getNum() {
		return num;
	}
	public String getTitle() {
		return title;
	}
	public String getContent() {
		return content;
	}
	public String getId() {
		return id;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public String getVisitcount() {
		return visitcount;
	}
	public String getName() {
		return name;
	}
	
	// setter
	public void setNum(String num) {
		this.num = num;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public void setVisitcount(String visitcount) {
		this.visitcount = visitcount;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
}