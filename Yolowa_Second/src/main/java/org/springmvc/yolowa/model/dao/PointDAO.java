package org.springmvc.yolowa.model.dao;

public interface PointDAO {

	void pointSave(String id);

	void logData(String content, int point, String id);

	String getLogDateById(String id);

}