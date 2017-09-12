package org.springmvc.yolowa.model.dao;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RankDAOImpl implements RankDAO {
	
	@Resource
	private SqlSessionTemplate template;
	
	@Override
	public List<Map<String, String>> selectRank(){
		return template.selectList("rank.selectRank");
	}
	
	@Override
	public int selectCountKeyword(String keyword){
		return template.selectOne("rank.selectCountKeyword", keyword);
	}
	
	@Override
	public void insertRank(String keyword)  {
		template.insert("rank.insertRank", keyword);
	}	
	
	@Override
	public void updateRank(String keyword)  {
		template.update("rank.updateRank", keyword);
	}
	
	@Override
	public List<Map<String, String>> autoKeyword(String keyword) {
		return template.selectList("rank.autoKeyword", keyword);
	}
}
