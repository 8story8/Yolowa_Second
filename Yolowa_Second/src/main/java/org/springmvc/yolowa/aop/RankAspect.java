package org.springmvc.yolowa.aop;

import java.util.List;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springmvc.yolowa.model.service.RankService;

@Component
@Aspect
public class RankAspect {
	@Resource
	private RankService rankService;
	@Around("execution(public java.util.List org.springmvc.yolowa.model.service.*Service.find*List*(..))")
	public Object rank(ProceedingJoinPoint point) throws Throwable {
		Object retValue = null;
		retValue = point.proceed();
		@SuppressWarnings("rawtypes")
		List list = (List)retValue;
		if(!list.isEmpty()){
			Object param[]=point.getArgs();// 메서드 인자값 - 매개변수
			rankService.saveRank(param[0].toString());	
		}				
		return retValue;
	}
}
