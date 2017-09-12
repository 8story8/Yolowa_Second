package org.springmvc.yolowa.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSeparatorUI;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.ReplyVO;

@Controller
public class BoardController {
	@Resource
	private FundService fundService;

	@Resource
	private RankService rankService;

	@Resource
	private MemberService service;

	@Resource
	private BoardService boardService;

	@RequestMapping("searchListByKeyword.do")
	public String searchListByKeyword(String keyword, HttpServletRequest request, HttpSession session) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<HashMap<String, Object>> sList = (List<HashMap<String, Object>>) boardService
				.findBoardListByKeyword(keyword);
		for (int i = 0; i < sList.size(); i++) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", sList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if (count == 0) {
				if (boardService.selectLike(map).size() == 0) {
					sList.get(i).put("countlike", "");
				} else {
					sList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
			} else {
				if ((boardService.selectLike(map).size() - 1) == 0) {
					sList.get(i).put("countlike", vo.getId() + "님");
				} else {
					sList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size() - 1) + "명");
				}
			}
		}
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("keyword", keyword);
		request.setAttribute("searchList", sList);
		request.setAttribute("searchMemberList", service.findMemberListByKeyword(keyword));
		request.setAttribute("bList", boardService.getAllBoardList());
		request.setAttribute("categoryList", service.searchCategory()); // 왼쪽 팝업
																		// 카테고리
																		// 목록
		request.setAttribute("rankList", rankService.selectRank()); // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		request.setAttribute("friendsList", service.friendsList(vo.getId(), "All"));
		return "board/searchResult.contentTiles";
	}

	@RequestMapping("mypage.do")
	public String mypage(HttpServletRequest request, Model model, String id) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		List<HashMap<String, Object>> myList = (List<HashMap<String, Object>>) boardService.getMyList(id);
		for(int i = 0; i < myList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", myList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					myList.get(i).put("countlike", "");
				}
				else{
					myList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
			}
			else{
				if((boardService.selectLike(map).size()-1) == 0){
					myList.get(i).put("countlike", vo.getId() + "님");
				}
				else{
					myList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
				}
			}
		}
		request.setAttribute("requestList",service.memberSearchFriends(id));
		request.setAttribute("plist", service.getPointList(id));	// point list
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		request.setAttribute("bList", myList);
		String url = "";
		
		Map<String, Object> fMap = new HashMap<String, Object>();
		fMap.put("id", id);
		if (id.equals(vo.getId())) {
			request.setAttribute("ID", vo.getId());
			List<MemberVO> List = service.friendsList(vo.getId(), "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			vo.setPoint(service.checkMyPoint(fMap));
			url = "board/mypage.myTiles";
		} else {
			request.setAttribute("ID", id);
			model.addAttribute("fvo", service.findFriendById(id));
			List<MemberVO> List = service.friendsList(id, "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			vo.setPoint(service.checkMyPoint(fMap));
			url = "board/mypage.myTiles";
		}
		return url;
	}

	@RequestMapping("myMessagePage.do")
	public String myMessagePage(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String curPage = request.getParameter("curPage");
		System.out.println(curPage);
		if (curPage == null) {
			curPage = "1";
		}
		request.setAttribute("myReceiveMsg", service.myAllReceiveMsg(vo.getId(), curPage));
		return "board/messagePage.myTiles";
	}

	@RequestMapping("sendMessagePage.do")
	public String sendMessagePage(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String curPage = request.getParameter("curPage");
		System.out.println(curPage);
		if (curPage == null) {
			curPage = "1";
		}
		request.setAttribute("mySendMsg", service.myAllSendMsg(vo.getId(), curPage));
		return "board/sendMessage.myTiles";
	}

	// 댓글작성
	@RequestMapping("writeReply.do")
	@ResponseBody
	public Object writeReply(ReplyVO rvo) {
		boardService.writeReply(rvo);
		return boardService.getAllListReply();
	}

	// 댓글 삭제
	@RequestMapping("deleteReply.do")
	@ResponseBody
	public Object deleteReply(String rNo) {
		boardService.deleteReply(rNo);
		return boardService.getAllListReply();
	}

	// 댓글 수정
	@RequestMapping("modifyReply.do")
	@ResponseBody
	public Object modifyReply(ReplyVO rvo) {
		return boardService.modifyReply(rvo);
	}

	@RequestMapping("writeContentView.do")
	public String writeContentView(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		request.setAttribute("categoryList", service.searchCategory()); // 왼쪽 팝업
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("rankList", rankService.selectRank()); // 검색어 랭킹 목록
		request.setAttribute("bList", boardService.getAllBoardList());
		String keyword = request.getParameter("keyword");

		// 검색
		if (keyword != null)
			request.setAttribute("searchList", boardService.findBoardListByKeyword(keyword));

		// 친구 리스트 & 메세지 박스
		request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
		request.setAttribute("bList", boardService.getAllBoardList());
		return "board/writeContentView.contentTiles";
	}

	// 일반글 넘기기
	private String uploadPath;
	@RequestMapping(value = "writeContext.do", method = RequestMethod.POST)
	public String writeContent(@RequestPart(required = false, value = "file") List<MultipartFile> imageFile,
			HttpServletRequest request) {
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		String filepath = "";
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < imageFile.size(); i++) {
			String fileName = imageFile.get(i).getOriginalFilename();
			try {imageFile.get(i).transferTo(new File(uploadPath + fileName));
				if (i == (imageFile.size() - 1)) {
					nameList.add(fileName);
				} else {
					nameList.add(fileName + "/");
				}
				System.out.println("업로드 완료 " + fileName);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}}
		for (int i = 0; i < nameList.size(); i++) {
			filepath += nameList.get(i);}
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("bType", request.getParameter("bType"));
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		boardService.userWriteContext(map);
		return "redirect:mainAllContent.do";
	}

	// 게시글 삭제
	@RequestMapping("deleteBoard.do")
	public String deleteBoard(String bNo, String type, HttpSession session) {
		boardService.deleteBoard(bNo);
		return "redirect:mainAllContent.do";
	}
	// content 수정
	@RequestMapping("modifyContentView.do")
	public String modifyContentView(HttpServletRequest request, String type) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		request.setAttribute("mList", boardService.getContenBybNo(bNo));	
		request.setAttribute("categoryList", service.searchCategory());
		request.setAttribute("fList", fundService.getAllFundList());
		String keyword = request.getParameter("keyword");
		request.setAttribute("rankList", rankService.selectRank());// rankList
		// 검색
		if (keyword != null)
			request.setAttribute("searchList", boardService.findBoardListByKeyword(keyword));
		// 친구 리스트 & 메세지 박스
		request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
		request.setAttribute("bList", boardService.getAllBoardList());
		request.setAttribute("type", type);
		
		return "board/modifyContentView.contentTiles";
	}
	//mypage 게시글 삭제
		@RequestMapping("deleteMypage.do")
		public String deleteMypage(String bNo) {
			MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			boardService.deleteBoard(bNo);
			return "redirect:mypage.do?id=" + vo.getId();
		}

	// 일반 글 수정
	@RequestMapping(value = "modifyContext.do", method = RequestMethod.POST)
	public String modifyContext(@RequestPart(required = false, value = "imageFile") List<MultipartFile> imageFile,HttpServletRequest request, String type) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int bNo = Integer.parseInt(request.getParameter("bNo"));
		String path;
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		String filepath = "";
		ArrayList<String> nameList = new ArrayList<String>();
		String[] photo = null;
		photo = request.getParameterValues("file");
		if (photo != null) {
			for (int i = 1; i < photo.length; i++) {
				System.out.println(photo[i]);
				nameList.add(photo[i] + "/");
			}}
		for (int i = 0; i < imageFile.size(); i++) {
			String fileName = imageFile.get(i).getOriginalFilename();
			try {
				imageFile.get(i).transferTo(new File(uploadPath + fileName));
				if (i == (imageFile.size() - 1)) {
					nameList.add(fileName);
				} else {
					nameList.add(fileName + "/");
				}
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}}
		for (int i = 0; i < nameList.size(); i++) {
			filepath += nameList.get(i);
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", vo.getId());
		map.put("bType", request.getParameter("bType"));
		map.put("bContent", request.getParameter("bContent"));
		map.put("local", request.getParameter("dest"));
		map.put("filepath", filepath);
		map.put("bNo", bNo);
		boardService.modifyContext(map);
		if(type.equals("mypage")){
			path="redirect:mypage.do?id=" + vo.getId();;
		}else{
			path="redirect:mainAllContent.do";
		}
		return path;
	}

	// 북마크 체크
	@RequestMapping("bookMarkCheck.do")
	@ResponseBody
	public int bookMarkCheck(String id, int bNo) {
		System.out.println(id+bNo);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("bNo", bNo);
		int i = boardService.checkBook(map);
		System.out.println(map);
		return i;
	}
	// 북마크 추가,삭제
	@RequestMapping("bookMark.do")
	@ResponseBody
	public String bookMark(String id, int bNo, String type) {
		System.out.println("수정전:"+type);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", id);
		map.put("bNo", bNo);
		if (type.equals("즐겨찾기")) {
			boardService.bookMark(map);
			type = "1";
			System.out.println("수정후:"+type);
		} else {
			boardService.bookMarkCancle(map);
			type = "0";
			System.out.println("수정후:"+type);	
		}
		return type;
	}

	@RequestMapping("myBookingPage.do")
	public String myBookingPage(HttpServletRequest request, String id, Model model) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<HashMap<String, Object>> bookingList = boardService.bookingList(id);
		for(int i = 0; i < bookingList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", bookingList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					bookingList.get(i).put("countlike", "");
				}else{
					bookingList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
				}else{
				if((boardService.selectLike(map).size()-1) == 0){
					bookingList.get(i).put("countlike", vo.getId() + "님");
				}
				else{
					bookingList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
				}}}
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("plist", service.getPointList(id));	// point list
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		request.setAttribute("bList", bookingList);
		request.setAttribute("ID", vo.getId());
		List<MemberVO> List = service.friendsList(vo.getId(), "My");
		model.addAttribute("friendList", List.size());
		return "board/myBookingPage.myTiles";
	}

	@RequestMapping("adminLike.do")
	@ResponseBody
	public List<HashMap<String, Object>> adminLike(HttpServletRequest request) {
		System.out.println("아이디 : " + request.getParameter("id"));
		System.out.println("글번호 : " + request.getParameter("bNo"));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("id", request.getParameter("id"));
		map.put("bNo", request.getParameter("bNo"));
		int count = (int) boardService.confirmLike(map);
		if (count == 0) {
			boardService.insertLike(map);
		} else {
			boardService.deleteLike(map);
		}
		return boardService.selectLike(map);
	}

	@RequestMapping("deleteMessage.do")
	public String deleteMessage(String[] deleteMsg, String type, String myId) {
		if (type.equals("receive")) {
			service.deleteReceiveMsg(deleteMsg, myId);
			return "redirect:myMessagePage.do";
		} else {
			service.deleteSendMsg(deleteMsg, myId);
			return "redirect:sendMessagePage.do";
		}
	}

	@RequestMapping("readMsg.do")
	@ResponseBody
	public void readMsg(String mNo) {
		service.readMsg(mNo);
	}
	@RequestMapping("writeFormMessage.do")
	public String writeMessage(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		request.setAttribute("friends", service.friendsList(vo.getId(), "My"));
		return "board/writeFormMessage.myTiles";
	}
}
