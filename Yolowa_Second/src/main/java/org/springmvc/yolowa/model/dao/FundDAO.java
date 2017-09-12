package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface FundDAO {

	HashMap<String, Object> getFundingBybNo(int bNo);

	void modifyFunding(Map<String, Object> map);

	void applyFunding(Map<String, Object> map);

	int selectCountFunding(Map<String, Object> map);

	List<HashMap<String, Object>> getAllFundList();

	void deleteFund(String bNo);

	HashMap<String, Object> getPointandPeopleBybNo(Map<String, Object> map);

	void cancleFunding(Map<String, Object> map);

	Map<String, Object> checkGoalFunding(Map<String, Object> map);

}
