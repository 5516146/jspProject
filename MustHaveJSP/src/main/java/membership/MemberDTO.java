package membership;

public class MemberDTO {
	// 멤버 테이블의 정보를 객체화하여 게터 세터 설정
	// 필드
	private String id;
	private String pass;
	private String name;
	private String regidate;
	
	// 생성자
	public MemberDTO() {}

	// 메소드
	// getter
	public String getId() {
		return id;
	}
	public String getPass() {
		return pass;
	}
	public String getName() {
		return name;
	}
	public String getRegidate() {
		return regidate;
	}
	// setter
	public void setId(String id) {
		this.id = id;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public void setName(String name) {
		this.name = name;
	}
	public void setRegidate(String regidate) {
		this.regidate = regidate;
	}
	
	
}