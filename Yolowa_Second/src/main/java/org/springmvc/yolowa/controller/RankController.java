package org.springmvc.yolowa.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springmvc.yolowa.model.service.RankService;

@Controller
public class RankController {
	@Resource
	private RankService rankService;
	
	@RequestMapping("autoKeyword.do")
	@ResponseBody
	public Object autoKeyword(String keyword){
		return rankService.autoKeyword(keyword);
	}
	
}
