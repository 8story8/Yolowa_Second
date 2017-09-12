package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FundDAOImpl implements FundDAO {
	@Resource
	private SqlSessionTemplate template;

	@Override
	public HashMap<String, Object> getFundingBybNo(int bNo) {
		return template.selectOne("fund.getFundingBybNo",bNo);
	}
	@Override
	public void modifyFunding(Map<String, Object> map) {
		template.update("fund.modifyBoard", map);
		template.update("fund.modifyBoardopt", map);
		template.update("fund.modifyFunding", map);
	}
	@Override
	public int selectCountFunding(Map<String, Object> map) {
		int count=template.selectOne("fund.selectCountFunding",map);
		return count;
	}
	@Override
	public void applyFunding(Map<String, Object> map) {
		template.insert("fund.applyFunding",map);
	}
	@Override
	public List<HashMap<String, Object>> getAllFundList() {
		List<HashMap<String, Object>> fList = template.selectList("fund.getAllFundList");
		for(int i = 0; i < fList.size(); i++){
			if(!fList.get(i).containsKey("fTitle")){
				fList.get(i).put("fTitle", 0);
			}
			
			if(!fList.get(i).containsKey("countlike")){
				fList.get(i).put("countlike", 0);
		    }
			
			if(!fList.get(i).containsKey("local")){
				fList.get(i).put("local", 0);
			}
			
			if(!fList.get(i).containsKey("filepath")){
				fList.get(i).put("filepath", 0);
			}
		}
		return fList;
	}
	@Override
	public void deleteFund(String bNo) {
		template.delete("fund.deleteFund",bNo);
	}
	@Override
	public HashMap<String, Object> getPointandPeopleBybNo(Map<String, Object> map) {
		return template.selectOne("fund.getPointandPeopleBybNo",map);
	}
	@Override
	public void cancleFunding(Map<String, Object> map) {
		template.delete("fund.cancleFunding",map);
	}
	@Override
	public Map<String, Object> checkGoalFunding(Map<String, Object> map) {
		Map<String, Object> checkMap = template.selectOne("fund.checkGoalFunding",map);
		if(checkMap.get("TOTALPOINT")==null){
			checkMap.put("TOTALPOINT",0);
		}
		if(checkMap.get("COUNT")==null){
			checkMap.put("COUNT", 0);
		}
		return checkMap;
	}
}
