package org.springmvc.yolowa.model.service;

public interface PointService {

	void pointSave(String id);

	void logData(String content, int point, String id);

	String getLogDateById(String id);

}