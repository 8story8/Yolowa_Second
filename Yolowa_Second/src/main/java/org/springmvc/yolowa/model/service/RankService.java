package org.springmvc.yolowa.model.service;

import java.util.List;
import java.util.Map;

public interface RankService {
	List<Map<String, String>> selectRank();
	void saveRank(String keyword);
	List<Map<String, String>> autoKeyword(String keyword);
}
