package org.springmvc.yolowa.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springmvc.yolowa.model.vo.Authority;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.FriendVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;
import org.springmvc.yolowa.model.vo.PagingBean;

public interface MemberDAO {

	public int memberLogin(MemberVO vo);

	public MemberVO loginSuccessMember(String id);

	public MemberVO searchId(Map<String, String> vo);

	public List<FriendVO> memberSearchFriends(String id);

	public List<MessageVO> memberMessageBox(Map<String, Object> msg);

	public List<Integer> findInterestById(String id);

	public List<MemberVO> findRecommendFriends(List<Integer> clist, String id);

	public List<CategoryVO> searchCategory();

	int idcheck(String id);

	public void registerMember(MemberVO vo);

	void registerInterest(MemberVO vo, int i);

	public void registerPoint(String id);

	public int friendAdd(FriendVO friendVO);

	public void updateProfile(FileVO fvo);

	List<MemberVO> memberFriendsList(List<String> friendId);

	public List<FriendVO> memberSearchFollowFriends(String id);

	public int sendMessage(MessageVO msg);

	public void modifyMember(MemberVO vo);
	
	List<String> getMemberIdListByKeyword(String keyword);
	
	MemberVO getMemberListById(String id);

	List<CategoryVO> getMemberType(String id);

	public List<FriendVO> requestList(String id);

	public MemberVO findMemberById(String sendId);

	public int requestAccept(FriendVO friendVO);

	public List<CategoryVO> getCategoryList(String id);

	public List<MessageVO> myAllReceiveMsg(String myId, PagingBean page);

	public List<String> sendMsgMemberInfo(String myId);

	public int getTotalMyMsg(String myId);
	
	public int friendDelete(FriendVO friendVO);

	public MemberVO findFriendById(String id);

	public List<HashMap<String, Object>> getPointList(String id);

	public int getTotalMySendMsg(String id);

	public List<MessageVO> myAllSendMsg(String id, PagingBean page);

	public List<String> receiveMsgMemberInfo(String id);

	public void deleteReceiveMsg(String string, String myId);

	public void deleteSendMsg(String string, String myId);

	public String checkStatusMessage(String string, String myId);

	public void deleteMsg(String messageNo);

	public int requestMsg(String id);

	public void readMsg(String mNo);

	public List<Authority> selectAuthorityByUsername(String username);

	void registerRole(Authority authority);

	public void userDeductionPoint(Map<String, Object> map);
	
	public void readMsgChat(FriendVO friend);

	public void userIncreasPoint(Map<String, Object> map);

	public int checkMyPoint(Map<String, Object> map);
	
	public void withdrawMember(String id);

	public MemberVO findMember(Map<String, String> vo);

	public void changePass(Map<String, Object> map);
	
}
