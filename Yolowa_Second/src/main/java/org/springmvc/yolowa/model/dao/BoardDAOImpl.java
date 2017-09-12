package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Repository
public class BoardDAOImpl implements BoardDAO {
	@Resource
	private SqlSessionTemplate template; 
	
	
	@Override
	public List<HashMap<String, Object>> getAllBoardList(){
		List<HashMap<String, Object>> bList = template.selectList("board.getAllBoardList");
		for(int i = 0; i < bList.size(); i++){
			if(!bList.get(i).containsKey("fTitle")){
				bList.get(i).put("fTitle", 0);
			}
			
			if(!bList.get(i).containsKey("countlike")){
		            bList.get(i).put("countlike", 0);
		    }
			
			if(!bList.get(i).containsKey("local")){
				bList.get(i).put("local", 0);
			}
			
			if(!bList.get(i).containsKey("filepath")){
				bList.get(i).put("filepath", 0);
			}
		}
		return bList;
	}
	
	@Override
	public List<HashMap<String, Object>> findBoardListByKeyword(String keyword){
		List<HashMap<String, Object>> fbList = template.selectList("board.findBoardListByKeyword", keyword);
		for(int i = 0; i < fbList.size(); i++){
			if(!fbList.get(i).containsKey("fTitle")){
				fbList.get(i).put("fTitle", 0);
			}
			
			if(!fbList.get(i).containsKey("local")){
				fbList.get(i).put("local", 0);
			}
			
			if(!fbList.get(i).containsKey("filepath")){
				fbList.get(i).put("filepath", 0);
			}
		}
		return fbList;
	}

	@Override
	public void writeFunding(Map<String, Object> map) {
		template.insert("board.writeFunding",map);
	}
	
	@Override
	public void writeContext(Map<String, Object> map) {
		template.insert("board.writeContext",map);
		
	}
	
	// 댓글
	@Override
	public List<ReplyVO> getAllListReply(){
		return template.selectList("board.getAllListReply");
	}

	@Override
	public void writeReply(ReplyVO rvo) {
		template.insert("board.writeReply", rvo);
	}

	@Override
	public void deleteReply(String rNo) {
		template.delete("board.deleteReply", rNo);	
	}
	
	@Override
	public void modifyReply(ReplyVO rvo) {
		template.update("board.modifyReply", rvo);	
	}
	
	@Override
	public ReplyVO getReplyByRno(int rNo){
		return template.selectOne("board.getReplyByRno", rNo);
	}
	
	@Override
	public void deleteBoard(String bNo) {
		template.delete("board.deleteBoard",bNo);
	}

	@Override
	public List<HashMap<String, Object>> getAllBoardListByCategory(String category) {
		List<HashMap<String, Object>> bCList = template.selectList("board.getAllBoardListByCategory", category);
		for(int i = 0; i < bCList.size(); i++){
			if(!bCList.get(i).containsKey("fTitle")){
				bCList.get(i).put("fTitle", 0);
			}
			
			if(!bCList.get(i).containsKey("countlike")){
	            bCList.get(i).put("countlike", 0);
			}
			
			if(!bCList.get(i).containsKey("local")){
				bCList.get(i).put("local", 0);
			}
			
			if(!bCList.get(i).containsKey("filepath")){
				bCList.get(i).put("filepath", 0);
			}
		}
		return bCList;
	}

	@Override
	public void insertLike(Map<String, Object> map){
		template.insert("board.insertLike", map);
	}
	
	@Override
	public void deleteLike(Map<String, Object> map){
		template.delete("board.deleteLike", map);
	}
	
	@Override
	public List<HashMap<String, Object>> selectLike(Map<String, Object> map) {
		return template.selectList("board.selectLike", map);
	}

	@Override
	public int confirmLike(Map<String, Object> map) {
		return template.selectOne("board.confirmLike", map);
	}

	@Override
	public HashMap<String, Object> getContenBybNo(int bNo) {
		return template.selectOne("board.getContenBybNo", bNo);
	}

	@Override
	public void modifyContext(Map<String, Object> map) {
		template.update("board.modifyBoard", map);
		template.update("board.modifyBoardopt", map);
	}

	@Override
	public List<HashMap<String, Object>> getAllCustomizedBoardListById(String id) {
		List<HashMap<String, Object>> cbList = template.selectList("board.getAllCustomizedBoardListById", id);
		for(int i = 0; i < cbList.size(); i++){
			if(!cbList.get(i).containsKey("fTitle")){
				cbList.get(i).put("fTitle", 0);
			}
			
			if(!cbList.get(i).containsKey("countlike")){
		            cbList.get(i).put("countlike", 0);
		    }
			
			if(!cbList.get(i).containsKey("local")){
				cbList.get(i).put("local", 0);
			}
			
			if(!cbList.get(i).containsKey("filepath")){
				cbList.get(i).put("filepath", 0);
			}
		}
		return cbList;
	}
	
	@Override
	public void bookMark(Map<String, Object> map) {
		template.insert("board.bookMark", map);
	}
	@Override
	public int checkBook(Map<String, Object> map) {
		return template.selectOne("board.checkBook",map);
	}

	@Override
	public void bookMarkCancle(Map<String, Object> map) {
		template.delete("board.bookMarkCancle",map);
	}

	@Override
	public List<HashMap<String, Object>> bookingList(String id) {
		List<HashMap<String, Object>> bkList=template.selectList("board.bookingList",id);
		for(int i = 0; i < bkList.size(); i++){
			if(!bkList.get(i).containsKey("FTITLE")){
				bkList.get(i).put("FTITLE", 0);
			}
			
			if(!bkList.get(i).containsKey("countlike")){
				bkList.get(i).put("countlike", 0);
			}
			
			if(!bkList.get(i).containsKey("local")){
				bkList.get(i).put("local", 0);
			}
			
			if(!bkList.get(i).containsKey("filepath")){
				bkList.get(i).put("filepath", 0);
			}
		}
		return bkList;
		
	}

	@Override
	public int getMemberCount() {
		return template.selectOne("board.memberCount");
	}

	@Override
	public int getContentCount() {
		return template.selectOne("board.contentCount");
	}

	@Override
	public int getFundingCount() {
		return template.selectOne("board.fundingCount");
	}

	@Override
	public List<HashMap<String, Object>> getMyList(String id) {
		List<HashMap<String, Object>> myList=template.selectList("board.myList",id);
		for(int i = 0; i < myList.size(); i++){
			if(!myList.get(i).containsKey("fTitle")){
				myList.get(i).put("fTitle", 0);
			}
			
			if(!myList.get(i).containsKey("countlike")){
				myList.get(i).put("countlike", 0);
			}
			
			if(!myList.get(i).containsKey("local")){
				myList.get(i).put("local", 0);
			}
			
			if(!myList.get(i).containsKey("filepath")){
				myList.get(i).put("filepath", 0);
			}
		}
		return myList;
	}
}
