package org.springmvc.yolowa.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springmvc.yolowa.model.vo.Authority;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.FriendVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;
import org.springmvc.yolowa.model.vo.PagingBean;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Resource
	private SqlSessionTemplate template;

	@Override
	public MemberVO loginSuccessMember(String id) {
		return template.selectOne("member.successMember", id);
	}

	@Override
	public int memberLogin(MemberVO vo) {
		return template.selectOne("member.memberLogin", vo);
	}

	@Override
	public MemberVO searchId(Map<String, String> vo) {
		return template.selectOne("member.searchId", vo);
	}

	// 친구 추가된 리스트
	@Override
	public List<FriendVO> memberSearchFriends(String id) {
		return template.selectList("member.memberSearchFriends", id);
	}

	@Override
	public List<MessageVO> memberMessageBox(Map<String, Object> msg) {
		return template.selectList("member.memberMessageBox", msg);
	}

	@Override
	public List<MemberVO> memberFriendsList(List<String> friendId) {
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		for (int i = 0; i < friendId.size(); i++) {
			MemberVO member = loginSuccessMember(friendId.get(i));
			ArrayList<CategoryVO> cateList = new ArrayList<CategoryVO>();
			cateList = (ArrayList<CategoryVO>) getMemberType(friendId.get(i));
			member.setCategoryList(cateList);
			memberList.add(member);
		}
		return memberList;
	}

	@Override
	public List<Integer> findInterestById(String id) {
		return template.selectList("member.findInterestById", id);
	}

	@Override
	public List<MemberVO> findRecommendFriends(List<Integer> clist, String id) {
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("list_category", clist);
		listMap.put("id", id);
		return template.selectList("member.findRecommendFriends", listMap);
	}

	@Override
	public List<CategoryVO> searchCategory() {
		return template.selectList("member.searchCategory");
	}

	@Override
	public int idcheck(String id) {
		return template.selectOne("member.idcheck", id);
	}

	@Override
	public void registerMember(MemberVO vo) {
		template.insert("member.registerMember", vo);
	}

	@Override
	public void registerInterest(MemberVO vo, int cNo) {
		Map<String, Object> insertCategory = new HashMap<String, Object>();
		insertCategory.put("id", vo.getId());
		insertCategory.put("cNo", cNo);
		template.insert("member.registerInterest", insertCategory);
	}

	@Override
	public int friendAdd(FriendVO friendVO) {
		return template.insert("member.friendAdd", friendVO);
	}

	@Override
	public void registerPoint(String id) {
		template.insert("member.registerPoint", id);

	}

	@Override
	public void updateProfile(FileVO vo) {
		template.update("member.updateProfile", vo);
	}

	@Override
	public List<FriendVO> memberSearchFollowFriends(String id) {
		return template.selectList("member.memberSearchFollowFriends", id);
	}

	@Override
	public int sendMessage(MessageVO msg) {
		return template.insert("member.sendMessage", msg);
	}

	@Override
	public void modifyMember(MemberVO vo) {
		template.update("member.modifyMember", vo);
		template.delete("member.deleteCategory", vo);
	}

	// 주희 : 검색
	@Override
	public List<String> getMemberIdListByKeyword(String keyword) {
		return template.selectList("member.findMemberListByKeyword", keyword);
	}

	@Override
	public MemberVO getMemberListById(String id) {
		return template.selectOne("member.getMemberById", id);
	}

	@Override
	public List<CategoryVO> getMemberType(String id) {
		return template.selectList("member.getMemberType", id);
	}

	@Override
	public List<FriendVO> requestList(String id) {
		return template.selectList("member.requestList", id);
	}

	@Override
	public MemberVO findMemberById(String sendId) {
		return template.selectOne("member.findMemberById", sendId);
	}

	@Override
	public int requestAccept(FriendVO friendVO) {
		return template.update("member.requestAccept", friendVO);
	}

	@Override
	public List<CategoryVO> getCategoryList(String id) {
		return template.selectList("member.getCategoryList", id);
	}

	// 내가 받은 모든 메세지
	@Override
	public List<MessageVO> myAllReceiveMsg(String myId, PagingBean page) {
		Map<String, Object> pageMsg = new HashMap<String, Object>();
		pageMsg.put("id", myId);
		pageMsg.put("page", page);
		return template.selectList("member.myAllReceiveMsg", pageMsg);
	}

	// 보낸 메세지의 친구들 정보
	@Override
	public List<String> sendMsgMemberInfo(String myId) {
		return template.selectList("member.sendMsgMemberInfo", myId);
	}

	@Override
	public int getTotalMyMsg(String myId) {
		return template.selectOne("member.getTotalMyMsg", myId);
	}

	// 친구삭제
	@Override
	public int friendDelete(FriendVO friendVO) {
		return template.delete("member.friendDelete", friendVO);
	}

	// 친구페이지
	@Override
	public MemberVO findFriendById(String id) {
		return template.selectOne("member.findFriendById", id);
	}

	@Override
	public List<HashMap<String, Object>> getPointList(String id) {
		return template.selectList("member.getPointList", id);
	}

	@Override
	public int getTotalMySendMsg(String id) {
		return template.selectOne("member.getTotalMySendMsg", id);
	}

	@Override
	public List<MessageVO> myAllSendMsg(String id, PagingBean page) {
		Map<String, Object> pageMsg = new HashMap<String, Object>();
		pageMsg.put("id", id);
		pageMsg.put("page", page);
		return template.selectList("member.myAllSendMsg", pageMsg);
	}

	@Override
	public List<String> receiveMsgMemberInfo(String id) {
		return template.selectList("member.receiveMsgMemberInfo", id);
	}

	@Override
	public void deleteReceiveMsg(String deleteNum, String myId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", myId);
		map.put("deleteNum", deleteNum);
		template.update("member.deleteReceiveMsg", map);
	}

	@Override
	public void deleteSendMsg(String deleteNum, String myId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", myId);
		map.put("deleteNum", deleteNum);
		template.update("member.deleteSendMsg", map);
	}

	@Override
	public String checkStatusMessage(String messageNo, String myId) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("mNo", messageNo);
		map.put("id", myId);
		return template.selectOne("member.checkStatusMessage", map);
	}

	@Override
	public void deleteMsg(String messageNo) {
		template.delete("member.deleteMsg", messageNo);
	}

	@Override
	public int requestMsg(String id) {
		return template.selectOne("member.requestMsg", id);

	}

	@Override
	public void readMsg(String mNo) {
		template.update("member.readMsg", Integer.parseInt(mNo));
	}

	@Override
	public List<Authority> selectAuthorityByUsername(String username) {
		return template.selectList("member.selectAuthorityByUsername", username);
	}

	/*
	 * Security를 위해 권한부여를 위해 사용
	 */
	@Override
	public void registerRole(Authority authority) {
		template.insert("member.registerRole", authority);
	}

	@Override
	public void userDeductionPoint(Map<String, Object> map) {
		template.update("member.deductionPoint",map);
	}
	
	@Override
	public void readMsgChat(FriendVO friend) {
		template.update("member.readMsgChat", friend);
	}

	@Override
	public void userIncreasPoint(Map<String, Object> map) {
		template.update("member.increasPoint",map);
	}

	@Override
	public int checkMyPoint(Map<String, Object> map) {
		return template.selectOne("member.checkMyPoint", map);
	}

	@Override
	public void withdrawMember(String id) {
		template.delete("member.withdraw", id);
	}

	@Override
	public MemberVO findMember(Map<String, String> vo) {
		return template.selectOne("member.findMember", vo);
	}

	@Override
	public void changePass(Map<String, Object> map) {
		template.update("member.changePass", map);
	}

}
