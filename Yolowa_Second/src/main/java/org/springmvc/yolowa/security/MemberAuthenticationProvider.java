package org.springmvc.yolowa.security;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.PointService;
import org.springmvc.yolowa.model.vo.Authority;
import org.springmvc.yolowa.model.vo.MemberVO;



//Spring Security를 이용한 인증로직을 정의한 클래스 
public class MemberAuthenticationProvider implements AuthenticationProvider{
	@Resource
	private MemberService memberService;
	//비밀번호 암호화처리를 위한 객체를 주입받는다 
	@Resource
    private BCryptPasswordEncoder passwordEncoder;
	@Resource
	private PointService pointService;
	@Override
	/*Authentication authenticate(Authentication authentication) throws AuthenticationException
	 * -실제 인증 처리
     *    - 규칙
     *     1. 파라미터로 전달받은 Authentication 객체에 대해 인증처리를 지원하지 않으면 null을 리턴한다.
     *     2. Authentication 객체를 이용한 인증에 실패하면 AuthenticationException 발생시킨다.
     *     3. 인증에 성공하면, 인증 정보를 담은 Authentication 객체를 만들어 return 한다.
	 */
	/**
	 * 사용자가 화면에서 로그인을 하면 아래의 메서드가 실행된다. 
	 * 매개변수 : 인증시 필요한 정보 - Authentication ( 사용자가 입력한 ID , PASSWORD가 저장되어 있음 ) 
	 * 리턴 : 인증한 정보를 가진 Authentication	 * 
	 * 매개변수에 전달된 Authentication객체를 받아 인증처리를 한뒤 인증한 정보를 Authentication에 담아 리턴
	 */
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {		
		//1.파라미터로 전달받은 Authentication 객체에 대해 인증처리를 지원하지 않으면 null을 리턴한다.
		if(!supports(authentication.getClass())){
			return null;
		}
		//2.사용자 정보 디비로 부터 조회(UserDetailsService에서 했던 작업)
		String id = authentication.getName();//사용자가 로그인시 입력한 ID 반환 		
		System.out.println("id는 무엇인가 : "+id);
		MemberVO member = memberService.loginSuccessMember(id);
		if(member == null){
			throw new UsernameNotFoundException("회원 아이디가 존재하지 않습니다");
		}
		String password=(String)authentication.getCredentials();//사용자가 입력한 패스워드 반환 
		
		
		//3.패스워드 비교
		/* 비밀번호 암호화를 이용할 경우 
		 이용자가 로그인 폼에서 입력한 비밀번호와 DB로부터 가져온 암호화된 비밀번호를 비교한다 */
        if (!passwordEncoder.matches(password, member.getPassword())) 
                throw new BadCredentialsException("비밀번호가 틀렸습니다.");
		//4.사용자 권한 조회
		List<Authority> list = memberService.selectAuthorityByUsername(id);
		if(list.size() == 0){
			throw new UsernameNotFoundException("권한이 없습니다.");
		}
		
		List<SimpleGrantedAuthority> authorities = new ArrayList<SimpleGrantedAuthority>();
		for(Authority au : list){
			authorities.add(new SimpleGrantedAuthority(au.getAuthority()));
		}
		
		Authentication auth = new UsernamePasswordAuthenticationToken(member, password, authorities);
		
		//로그인 포인트 적립
		String day = null;
		day = pointService.getLogDateById(id);
		String content = "로그인 포인트";
		int lPoint = 50;
		Calendar cal= Calendar.getInstance();
	    SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
    	
	    if(!today.format(cal.getTime()).equals(day)){
	    	pointService.pointSave(id);
	    	pointService.logData(content, lPoint, id);
	    }
		return auth;		
	}

	@Override
	public boolean supports(Class<?> authentication) {
		//Class객체.isAssignableFrom(Class객체) 같은 타입의 객체를 담을 수 있는지 체크ㅡ - 둘이 같은 class로 부터 생성된 Class객체인지 체크
		return  UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication);
	}
}
