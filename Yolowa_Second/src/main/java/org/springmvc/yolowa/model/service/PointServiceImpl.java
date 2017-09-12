package org.springmvc.yolowa.model.service;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.dao.PointDAO;

@Service
public class PointServiceImpl implements PointService {
	@Resource
	private PointDAO pointDAO;

	@Override
	public void pointSave(String id) {
		pointDAO.pointSave(id);
	}

	@Override
	public void logData(String content, int point, String id) {
		pointDAO.logData(content, point, id);
	}

	@Override
	public String getLogDateById(String id) {
		return pointDAO.getLogDateById(id);
	}
	
}
