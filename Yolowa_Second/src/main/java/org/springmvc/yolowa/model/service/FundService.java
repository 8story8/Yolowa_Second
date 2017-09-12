package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface FundService {

	List<HashMap<String, Object>> getAllFundList();

	HashMap<String, Object> getFundingBybNo(int bNo);

	void modifyFunding(Map<String, Object> map);

	int selectCountFunding(Map<String, Object> map);
	
	void applyFunding(Map<String, Object> map);

	void deleteFund(String bNo);

	HashMap<String, Object> getPointandPeopleBybNo(Map<String, Object> map);

	void cancleFunding(Map<String, Object> map);

	Map<String, Object> checkGoalFunding(Map<String, Object> map);

}
