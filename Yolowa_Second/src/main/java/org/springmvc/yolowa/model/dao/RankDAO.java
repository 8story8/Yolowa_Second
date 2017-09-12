package org.springmvc.yolowa.model.dao;

import java.util.List;
import java.util.Map;

public interface RankDAO {
	List<Map<String, String>> selectRank();
	int selectCountKeyword(String keyword);
	void insertRank(String keyword);
	void updateRank(String keyword);
	List<Map<String, String>> autoKeyword(String keyword);
}
