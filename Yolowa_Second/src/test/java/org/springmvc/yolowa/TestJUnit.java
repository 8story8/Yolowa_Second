package org.springmvc.yolowa;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springmvc.yolowa.model.dao.MemberDAO;
import org.springmvc.yolowa.model.dao.PointDAO;
import org.springmvc.yolowa.model.dao.RankDAO;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.MemberVO;

/*
 *    TDD : 테스트 주도 개발(test-driven development, TDD)은 
 *            매우 짧은 개발 사이클을 반복하는 소프트웨어 개발 프로세스
 *            
 *    JUnit: 자바 단위 테스트를 위한 TDD 프레임워크
 *    
 *    아래 라이브러리가 maven의 pom.xml에 추가되어야 한다. 
       <!-- spring junit  -->
  <dependency>
            <groupId>org.springframework</groupId>
            <artifactId>spring-test</artifactId>
            <version>${org.springframework-version}</version>            
        </dependency>
        <!-- Test : 기존 4.7에서 4.9로 수정 -->
  <dependency>
   <groupId>junit</groupId>
   <artifactId>junit</artifactId>
   <version>4.9</version>
   <scope>test</scope>
  </dependency>  
 */  
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations={"file:src/main/webapp/WEB-INF/spring-model.xml"})
public class TestJUnit {
	@Resource
	private MemberService service;
	
	@Resource
	private FundService fservice;
	
	@Resource
	private RankService rankService;
	
	@Resource
	private BoardService boardService;
	
	@Resource
	private RankDAO dao;
	
	@Resource
	private MemberDAO mdao;
	
	@Resource
	private PointDAO pointDAO;
	@Test
	public void test(){
		/*Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", "winfog");
		map.put("bNo", 149);
		System.out.println(fservice.checkGoalFunding(map));*/
		MemberVO mvo=mdao.getMemberListById("java");
		System.out.println(mvo.toString());
	}
}