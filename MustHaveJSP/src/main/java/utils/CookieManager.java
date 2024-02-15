package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieManager {
	// 쿠키를 생성, 찾기, 삭제하는 공통의 코드
	
	// 명시한 이름, 값, 유지기간 조건으로 새로운 쿠키 생성
	public static void makeCookie(HttpServletResponse response, String cName, String cValue, int cTime) {
		Cookie cookie = new Cookie(cName, cValue); // cName 쿠키 생성
		cookie.setPath("/"); // 경로 설정
		cookie.setMaxAge(cTime); // 유지기간 설정
		response.addCookie(cookie); // 응답 객체에 추가
	} // makeCookie
	
	// 명시한 이름의 쿠키를 찾아 값을 반환
	public static String readCookie(HttpServletRequest request, String cName) {
		String cookieValue = ""; // 값을 반환받을 변수 생성
		
		Cookie[] cookies = request.getCookies(); // cookies 배열에 받은 쿠키들 입력
		if (cookies != null) { // 쿠키가 있으면
			for (Cookie c : cookies) { // c 에 쿠키를 하나씩 넣고
				String cookieName = c.getName(); // 쿠키의 이름을 찾아 cookieName에 입력
				if (cookieName.equals(cName)) { // 매개변수 이름과 쿠키의 이름이 같으면
					cookieValue = c.getValue(); // 쿠키의 값을 반환
				}
			}
		}
		return cookieValue;
	} // readCookie
	
	// 명시한 이름의 쿠키를 삭제
	public static void deleteCookie(HttpServletResponse response, String cName) {
		makeCookie(response, cName, "", 0); // 받은 값을 makecookie 메소드로 보내 유지기간을 0으로 설정
	} // deleteCookie
}