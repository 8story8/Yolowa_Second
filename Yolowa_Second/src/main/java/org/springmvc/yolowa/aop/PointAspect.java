package org.springmvc.yolowa.aop;

import java.util.Map;

import javax.annotation.Resource;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springmvc.yolowa.model.service.PointService;

@Component
@Aspect
public class PointAspect {
	
	@Resource
	private PointService pointService;
	
	@Around("execution(public * org.springmvc.yolowa.model.service.*Service.user*(..))")
	public Object pointLog(ProceedingJoinPoint point) throws Throwable {
		String mn = point.getSignature().getName();
		String content = null;// 로그 내용
		int lPoint = 50;
		int fPoint = 100;
		Object retValue = null;//login-id
		Object param[]=point.getArgs();//method인자값
		
		retValue = point.proceed();
		
		if(mn.equals("userRequestAccept")){
			content = "친구추가 포인트";
			
			for(int i = 0; i<param.length; i++){
				pointService.pointSave(param[i].toString());
				pointService.logData(content, lPoint, param[i].toString());
			}
		} else if(mn.equals("userWriteContext")){
	         content = "글작성 포인트";
	         @SuppressWarnings("unchecked")
	         Map<String,Object> list = (Map<String, Object>) param[0];
	         
	         pointService.pointSave(list.get("id").toString());
	         pointService.logData(content, lPoint, list.get("id").toString());
	      }
			else if(mn.equals("userDeductionPoint")){
			content = "펀딩 참가 포인트";
			System.out.println("retValue: "+retValue);
			@SuppressWarnings("unchecked")
			Map<String,Object> list = (Map<String, Object>) param[0];
			pointService.logData(content, -fPoint, list.get("id").toString());
		} 
			else if(mn.equals("userIncreasPoint")){
			content = "펀딩 취소 포인트";
			System.out.println("retValue: "+retValue);
			@SuppressWarnings("unchecked")
			Map<String,Object> list = (Map<String, Object>) param[0];
			pointService.logData(content, fPoint, list.get("id").toString());
		} 
		
		return retValue;
	}
}
