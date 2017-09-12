package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springmvc.yolowa.model.vo.ReplyVO;

public interface BoardDAO {
	List<HashMap<String, Object>> getAllBoardList();

	List<HashMap<String, Object>> findBoardListByKeyword(String keyword);

	void writeFunding(Map<String, Object> map);

	List<ReplyVO> getAllListReply();

	ReplyVO getReplyByRno(int rNo);

	void writeReply(ReplyVO rvo);

	
	void deleteReply(String rNo);
	
	void modifyReply(ReplyVO rvo);

	void writeContext(Map<String, Object> map);

	void deleteBoard(String bNo);

	HashMap<String, Object> getContenBybNo(int bNo);

	void modifyContext(Map<String, Object> map);

	List<HashMap<String, Object>> getAllBoardListByCategory(String category);

	int confirmLike(Map<String, Object> map);

	List<HashMap<String, Object>> selectLike(Map<String, Object> map);
	
	 void insertLike(Map<String, Object> map);
	 
	 void deleteLike(Map<String, Object> map);

	 
	 List<HashMap<String, Object>> getAllCustomizedBoardListById(String id);

	void bookMark(Map<String, Object> map);

	int checkBook(Map<String, Object> map);

	void bookMarkCancle(Map<String, Object> map);

	List<HashMap<String, Object>> bookingList(String id);
	
	List<HashMap<String, Object>> getMyList(String id);
	
	int getMemberCount();
	
	int getContentCount();
	
	int getFundingCount();

}
