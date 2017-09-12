package org.springmvc.yolowa.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmvc.yolowa.model.service.PointService;

@Controller
public class PointController {
	@Resource
	private PointService pointService;
	
	@RequestMapping()
	public void pointSave(){
		
	}
}
