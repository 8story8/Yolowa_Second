package org.springmvc.yolowa.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.dao.RankDAO;

@Service
public class RankServiceImpl implements RankService {
	@Resource
	private RankDAO rankDAO;

	@Override
	public List<Map<String, String>> selectRank() {
		return rankDAO.selectRank();
	}
	
	@Override
	public void saveRank(String keyword)  {	
		if(rankDAO.selectCountKeyword(keyword)==0)
			rankDAO.insertRank(keyword);			
		else			
			rankDAO.updateRank(keyword);
	}	
	
	@Override
	public List<Map<String, String>> autoKeyword(String keyword) {
		List<Map<String, String>> list=new ArrayList<Map<String, String>>();
		Map<String, String> map=new HashMap<String, String>();
		map.put("KEYWORD", "검색어를 입력하세요");
		list.add(map);
		if(keyword.length()<1)
			return list;
		else
			return rankDAO.autoKeyword(keyword);
	}	
}
