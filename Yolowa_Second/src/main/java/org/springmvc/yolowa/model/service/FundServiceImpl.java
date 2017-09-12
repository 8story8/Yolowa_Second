package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.dao.FundDAO;

@Service
public class FundServiceImpl implements FundService {
	@Resource
	private FundDAO fundDAO;

	@Override
	public HashMap<String, Object> getFundingBybNo(int bNo) {
		return fundDAO.getFundingBybNo(bNo);
	}

	@Override
	public void modifyFunding(Map<String, Object> map) {
		fundDAO.modifyFunding(map);

	}

	@Override
	public int selectCountFunding(Map<String, Object> map) {
		return fundDAO.selectCountFunding(map);
	}

	@Override
	public void applyFunding(Map<String, Object> map) {
		fundDAO.applyFunding(map);
	}

	@Override
	public List<HashMap<String, Object>> getAllFundList() {
		return fundDAO.getAllFundList();
	}

	@Override
	public void deleteFund(String bNo) {
		fundDAO.deleteFund(bNo);
	}

	@Override
	public HashMap<String, Object> getPointandPeopleBybNo(Map<String, Object> map) {
		return fundDAO.getPointandPeopleBybNo(map);
	}

	@Override
	public void cancleFunding(Map<String, Object> map) {
		fundDAO.cancleFunding(map);
	}

	@Override
	public Map<String, Object> checkGoalFunding(Map<String, Object> map) {
		return fundDAO.checkGoalFunding(map);
	}

}
