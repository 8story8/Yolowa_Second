package org.springmvc.yolowa.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springmvc.yolowa.model.vo.Authority;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;

public interface MemberService {

	public MemberVO userLogin(MemberVO vo);

	public MemberVO searchId(Map<String, String> vo);

	public Map<String, Object> memberSearchFriends(String id);

	public List<MemberVO> findInterestById(String id);

	public List<CategoryVO> searchCategory();

	int idcheck(String id);

	public List<MemberVO> friendsList(String id, String flag);

	public Map<String, Object> friendsMsgBox(String id, String rId);

	public int friendAdd(String sendId, String receiveId);

	void registerMember(MemberVO vo, String[] category);

	public MemberVO updateProfile(FileVO fvo);

	public MemberVO modifyMember(MemberVO vo, String[] category);

	public int sendMessage(MessageVO msg);

	public List<MemberVO> requestList(String id);

	public int userRequestAccept(String sendId, String receiveId);

	List<MemberVO> findMemberListByKeyword(String keyword);

	public List<CategoryVO> getCategoryList(String id);

	public Map<String, Object> myAllReceiveMsg(String myId, String curPage);

	public int friendDelete(String sendId, String receiveId);

	public MemberVO findFriendById(String id);

	public List<HashMap<String, Object>> getPointList(String id);

	public  Map<String, Object> myAllSendMsg(String id, String curPage);

	public void deleteReceiveMsg(String[] deleteMsg, String myId);

	public void deleteSendMsg(String[] deleteMsg, String myId);

	public	int requestMsg(String id);

	public void readMsg(String mNo);

	public boolean passCheck(String password);
	
	public MemberVO loginSuccessMember(String id);
	
	public List<Authority> selectAuthorityByUsername(String username);

	public void userDeductionPoint(Map<String, Object> map);
	
	public void readMsg(String rId, String sId);

	public void userIncreasPoint(Map<String, Object> map);
	
	public int checkMyPoint(Map<String, Object> map);
	
	public void withdrawMember(String id, String password);

	public MemberVO findMember(Map<String, String> vo);

	public void changePass(String id, String encodedPwd);

}
