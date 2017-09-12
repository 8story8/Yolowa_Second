package org.springmvc.yolowa.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springmvc.yolowa.model.dao.MemberDAO;
import org.springmvc.yolowa.model.dao.PointDAO;
import org.springmvc.yolowa.model.vo.Authority;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.FriendVO;
import org.springmvc.yolowa.model.vo.ListVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;
import org.springmvc.yolowa.model.vo.PagingBean;

@Service
public class MemberServiceImpl implements MemberService {

	@Resource
	private MemberDAO dao;

	@Resource
	private PointDAO pointDAO;

	// 회원정보수정시 비밀번호 암호화처리를 위한 객체를 주입받는다
	@Resource
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public MemberVO userLogin(MemberVO vo) {
		if (dao.memberLogin(vo) > 0) {
			MemberVO member = dao.loginSuccessMember(vo.getId());
			return member;
		} else {
			return null;
		}
	}

	@Override
	public Map<String, Object> memberSearchFriends(String id) {
		Map<String, Object> mapList = new HashMap<String, Object>();
		// 친구 추가된 ID 리스트
		List<MemberVO> memberIdList = friendsList(id, "My");
		mapList.put("friends", memberIdList);
		return mapList;
	}

	@Override
	public MemberVO searchId(Map<String, String> vo) {
		return dao.searchId(vo);
	}

	@Override
	public List<MemberVO> findInterestById(String id) {
		// 관심사항 수
		List<Integer> clist = dao.findInterestById(id);
		// 친구 추천 리스트
		List<MemberVO> member = dao.findRecommendFriends(clist, id);

		// 모든 follow 테이블에 있는 Member
		List<MemberVO> flist = friendsList(id, "All");

		// new List
		List<MemberVO> rlist = new ArrayList<MemberVO>();

		for (int i = 0; i < member.size(); i++) {
			boolean flag = false;
			for (int j = 0; j < flist.size(); j++) {
				if (member.get(i).getId().equals(flist.get(j).getId())) {
					flag = true;
					break;
				}
			}
			if (flag == false) {
				rlist.add(member.get(i));
			}
		}
		return rlist;
	}

	@Override
	public List<CategoryVO> searchCategory() {
		return dao.searchCategory();
	}

	@Transactional
	@Override
	public void registerMember(MemberVO vo, String[] category) {
		// 비밀번호를 bcrypt 알고리듬으로 암호화하여 DB에 저장한다
		String encodedPwd = passwordEncoder.encode(vo.getPassword());
		vo.setPassword(encodedPwd);

		String content = "회원가입 포인트";
		int point = 100;
		try {
			vo.setFilePath("resources/asset/img/avatar.jpg");
			// 회원 정보 insert
			dao.registerMember(vo);

			Authority authority = new Authority(vo.getId(), "ROLE_MEMBER");
			System.out.println(authority.toString());
			dao.registerRole(authority);

			// 회원 포인트 insert
			dao.registerPoint(vo.getId());

			// 회원 로그 insert
			pointDAO.logData(content, point, vo.getId());

			// 회원 관심사항 insert
			for (int i = 0; i < category.length; i++) {
				dao.registerInterest(vo, Integer.parseInt(category[i]));
			}
		} finally {

		}

	}

	@Override
	public int idcheck(String id) {
		return dao.idcheck(id);
	}

	@Override
	public int friendAdd(String sendId, String receiveId) {
		FriendVO friendVO = new FriendVO(sendId, receiveId);
		return dao.friendAdd(friendVO);
	}

	// 회원사진 수정
	@Override
	public MemberVO updateProfile(FileVO fvo) {
		dao.updateProfile(fvo);
		String id = fvo.getUserInfo();
		return dao.loginSuccessMember(id);
	}

	// 회원정보 수정
	@Override
	public MemberVO modifyMember(MemberVO vo, String[] category) {
		dao.modifyMember(vo);
		for (int i = 0; i < category.length; i++) {
			dao.registerInterest(vo, Integer.parseInt(category[i]));
		}
		String id = vo.getId();
		return dao.loginSuccessMember(id);

	}

	@Override
	public List<MemberVO> friendsList(String id, String flag) {
		List<FriendVO> friends = null;
		if (flag.equals("My")) {
			friends = dao.memberSearchFriends(id);
		} else if (flag.equals("All")) {
			friends = dao.memberSearchFollowFriends(id);
		}

		List<String> friendId = new ArrayList<String>();
		for (int i = 0; i < friends.size(); i++) {
			if (friends.get(i).getSendId().equals(id)) {
				friendId.add(friends.get(i).getReceiveId());
			} else if (friends.get(i).getReceiveId().equals(id)) {
				friendId.add(friends.get(i).getSendId());
			}
		}
		return dao.memberFriendsList(friendId);
	}

	@Override
	public Map<String, Object> friendsMsgBox(String sId, String rId) {
		// sId = session Id, rId = request Id
		Map<String, Object> msg = new HashMap<String, Object>();
		msg.put("sId", sId);
		msg.put("rId", rId);
		Map<String, Object> friendsMsg = new HashMap<String, Object>();
		friendsMsg.put("friend", dao.loginSuccessMember(rId));
		friendsMsg.put("msgBox", dao.memberMessageBox(msg));
		return friendsMsg;
	}

	// 내가 받은 전체 메세지
	@Override
	public Map<String, Object> myAllReceiveMsg(String myId, String curPage) {
		ListVO list = new ListVO();
		// 내가 받은 전체 메세지 수
		int getTotalMyMsg = dao.getTotalMyMsg(myId);
		// 현재 페이지 번호
		int nowPage = Integer.parseInt(curPage);
		PagingBean page = new PagingBean(getTotalMyMsg, nowPage);
		List<MessageVO> myAllMsgList = dao.myAllReceiveMsg(myId, page);
		List<MemberVO> memberInfo = dao.memberFriendsList(dao.sendMsgMemberInfo(myId));
		list.setMessageList(myAllMsgList);
		list.setPagingBean(page);
		Map<String, Object> receiveMsg = new HashMap<String, Object>();
		receiveMsg.put("myAllMsgList", list);
		receiveMsg.put("memberInfo", memberInfo);
		return receiveMsg;
	}

	// sendMessage 기능
	@Override
	public int sendMessage(MessageVO msg) {
		return dao.sendMessage(msg);
	}

	@Override
	public List<MemberVO> requestList(String id) {
		List<FriendVO> sendId = dao.requestList(id);
		List<MemberVO> relist = new ArrayList<MemberVO>();
		for (int i = 0; i < sendId.size(); i++) {
			relist.add(dao.findMemberById(sendId.get(i).getSendId()));
		}
		return relist;
	}

	@Override
	public int userRequestAccept(String sendId, String receiveId) {
		FriendVO friendVO = new FriendVO(sendId, receiveId);
		return dao.requestAccept(friendVO);
	}

	// 주희 : 검색
	@Override
	public List<MemberVO> findMemberListByKeyword(String keyword) {
		List<String> list = dao.getMemberIdListByKeyword(keyword);
		List<MemberVO> memberList = new ArrayList<MemberVO>();
		for (int i = 0; i < list.size(); i++) {
			MemberVO mvo = dao.getMemberListById(list.get(i));
			ArrayList<CategoryVO> cateList = new ArrayList<CategoryVO>();
			cateList = (ArrayList<CategoryVO>) dao.getMemberType(list.get(i));
			mvo.setCategoryList(cateList);
			memberList.add(mvo);
		}
		return memberList;
	}

	@Override
	public List<CategoryVO> getCategoryList(String id) {
		return dao.getCategoryList(id);
	}

	@Override
	public int friendDelete(String sendId, String receiveId) {
		FriendVO friendVO = new FriendVO(sendId, receiveId);
		return dao.friendDelete(friendVO);
	}

	// 친구페이지 상세내용
	@Override
	public MemberVO findFriendById(String id) {
		return dao.findFriendById(id);
	}

	@Override
	public List<HashMap<String, Object>> getPointList(String id) {
		return dao.getPointList(id);
	}

	@Override
	public Map<String, Object> myAllSendMsg(String id, String curPage) {
		ListVO list = new ListVO();

		// 내가 받은 전체 메세지 수
		int getTotalMySendMsg = dao.getTotalMySendMsg(id);

		System.out.println("현재 페이지 번호 : " + curPage);
		// 현재 페이지 번호
		int nowPage = Integer.parseInt(curPage);

		System.out.println("메세지 수: " + getTotalMySendMsg + "   " + nowPage);

		PagingBean page = new PagingBean(getTotalMySendMsg, nowPage);
		List<MessageVO> myAllSendMsgList = dao.myAllSendMsg(id, page);

		List<MemberVO> memberInfo = dao.memberFriendsList(dao.receiveMsgMemberInfo(id));

		list.setMessageList(myAllSendMsgList);
		list.setPagingBean(page);

		Map<String, Object> sendMsg = new HashMap<String, Object>();
		sendMsg.put("myAllMsgList", list);
		sendMsg.put("memberInfo", memberInfo);
		return sendMsg;
	}

	@Override
	public void deleteReceiveMsg(String[] deleteMsg, String myId) {
		for (int i = 0; i < deleteMsg.length; i++) {
			String status = dao.checkStatusMessage(deleteMsg[i], myId);
			if (status.equals("SD") == false) {
				dao.deleteReceiveMsg(deleteMsg[i], myId);
			} else {
				dao.deleteMsg(deleteMsg[i]);
			}
		}

	}

	@Override
	public void deleteSendMsg(String[] deleteMsg, String myId) {
		for (int i = 0; i < deleteMsg.length; i++) {
			String status = dao.checkStatusMessage(deleteMsg[i], myId);
			if (status.equals("RD") == false) {
				dao.deleteSendMsg(deleteMsg[i], myId);
			} else {
				dao.deleteMsg(deleteMsg[i]);
			}
		}
	}

	@Override
	public int requestMsg(String id) {
		return dao.requestMsg(id);
	}

	@Override
	public void readMsg(String mNo) {
		dao.readMsg(mNo);

	}

	@Override
	public boolean passCheck(String password) {
		MemberVO member = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return passwordEncoder.matches(password, member.getPassword());
	}

	@Override
	public MemberVO loginSuccessMember(String id) {
		return dao.loginSuccessMember(id);
	}

	@Override
	public List<Authority> selectAuthorityByUsername(String username) {
		return dao.selectAuthorityByUsername(username);
	}

	@Override
	public void readMsg(String rId, String sId) {
		FriendVO friends = new FriendVO(sId, rId);
		dao.readMsgChat(friends);
	}

	@Override
	public void userDeductionPoint(Map<String, Object> map) {
		dao.userDeductionPoint(map);
	}

	@Override
	public void userIncreasPoint(Map<String, Object> map) {
		dao.userIncreasPoint(map);
	}

	@Override
	public int checkMyPoint(Map<String, Object> map) {
		return dao.checkMyPoint(map);
	}

	@Override
	public void withdrawMember(String id, String password) {
		MemberVO member = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		if (!passwordEncoder.matches(password, member.getPassword())) {
			throw new BadCredentialsException("비밀번호 불일치~~~");
		} else {
			dao.withdrawMember(id);
		}
	}

	@Override
	public MemberVO findMember(Map<String, String> vo) {
		return dao.findMember(vo);
	}

	@Override
	public void changePass(String id, String pass) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("password", pass);
		dao.changePass(map);
	}
}
