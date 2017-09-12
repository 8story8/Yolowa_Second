package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springmvc.yolowa.model.dao.BoardDAO;
import org.springmvc.yolowa.model.dao.MemberDAO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Resource
	private BoardDAO boardDAO;
	
	@Resource
	private MemberDAO memberDAO;

	@Override
	public List<HashMap<String, Object>> getAllBoardList() {
		return boardDAO.getAllBoardList();
	}

	@Override
	public List<HashMap<String, Object>> findBoardListByKeyword(String keyword) {
		return boardDAO.findBoardListByKeyword(keyword);
	}

	@Override
	public void writeFunding(Map<String, Object> map) {
		boardDAO.writeFunding(map);
	}

	// 댓글
	@Override
	public List<ReplyVO> getAllListReply() {
		List<ReplyVO> list=boardDAO.getAllListReply();
		MemberVO mvo=new MemberVO();
		for(int i=0; i<list.size(); i++){
			mvo=memberDAO.getMemberListById(list.get(i).getMemberVO().getId());
			list.get(i).setMemberVO(mvo);
		}
		return list;
	}

	@Override
	public void writeReply(ReplyVO rvo) {
		boardDAO.writeReply(rvo);
	}
	
	@Override
	public void deleteReply(String rNo){
		boardDAO.deleteReply(rNo);
	}
	
	@Override
	public ReplyVO modifyReply(ReplyVO rvo){
		boardDAO.modifyReply(rvo);
		return boardDAO.getReplyByRno(rvo.getrNo());
	}

	@Override
	public void userWriteContext(Map<String, Object> map) {
		boardDAO.writeContext(map);

	}

	@Override
	public void deleteBoard(String bNo) {
		boardDAO.deleteBoard(bNo);

	}

	@Override
	public HashMap<String, Object> getContenBybNo(int bNo) {
		return boardDAO.getContenBybNo(bNo);
	}

	@Override
	public void modifyContext(Map<String, Object> map) {
		boardDAO.modifyContext(map);
	}
	public List<HashMap<String, Object>> getAllBoardListByCategory(String category) {
		return boardDAO.getAllBoardListByCategory(category);
	}


	@Override
	public List<HashMap<String, Object>> selectLike(Map<String, Object> map) {
		return boardDAO.selectLike(map);
	}

	@Override
	public void insertLike(Map<String, Object> map) {
		boardDAO.insertLike(map);
	}

	@Override
	public void deleteLike(Map<String, Object> map) {
		boardDAO.deleteLike(map);
	}

	@Override
	public int confirmLike(Map<String, Object> map) {
		return boardDAO.confirmLike(map);
	}

	@Override
	public List<HashMap<String, Object>> getAllCustomizedBoardListById(String id) {
		return boardDAO.getAllCustomizedBoardListById(id);
	}
	@Override
	public void bookMark(Map<String, Object> map) {
		boardDAO.bookMark(map);
	}

	@Override
	public int checkBook(Map<String, Object> map) {
		return boardDAO.checkBook(map);
	}

	@Override
	public void bookMarkCancle(Map<String, Object> map) {
		boardDAO.bookMarkCancle(map);
	}

	@Override
	public List<HashMap<String, Object>> bookingList(String id) {
		return boardDAO.bookingList(id);
	}

	@Override
	public HashMap<String, Object> getUsageCount(){
		HashMap<String, Object> usageCount = new HashMap<String, Object>();
		usageCount.put("memberCount", boardDAO.getMemberCount());
		usageCount.put("contentCount", boardDAO.getContentCount());
		usageCount.put("fundingCount", boardDAO.getFundingCount());
		return usageCount;
	}

	@Override
	public List<HashMap<String, Object>> getMyList(String id) {
		return boardDAO.getMyList(id);
	}
}


