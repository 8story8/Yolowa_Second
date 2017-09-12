package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class PointDAOImpl implements PointDAO {
	@Resource
	private SqlSessionTemplate template;

	@Override
	public void pointSave(String id) {
		template.update("member.pointSave", id);
	}

	@Override
	public void logData(String content, int point, String id) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("content", content);
		data.put("point", point);
		data.put("id", id);
		template.insert("member.logData", data);
	}

	@Override
	public String getLogDateById(String id) {
		return template.selectOne("member.getLogDateById", id);
	}
	
}
