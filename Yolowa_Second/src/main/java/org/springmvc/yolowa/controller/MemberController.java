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

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.vo.CategoryVO;
import org.springmvc.yolowa.model.vo.FileVO;
import org.springmvc.yolowa.model.vo.MemberVO;
import org.springmvc.yolowa.model.vo.MessageVO;

@Controller
public class MemberController {
	private String uploadPath;
	@Resource
	private MemberService service;

	@Resource
	private BCryptPasswordEncoder passwordEncoder; 
	
	@RequestMapping("loginView")
	public String loginView() {
		return "member/loginView";
	}
	
	@RequestMapping("login_success.do")
	public String loginSuccess(){
		return "redirect:mainAllContent.do";
	}

	@RequestMapping("error.do")
	public String error() {
		return "member/error";
	}

	@RequestMapping("registerView.do")
	public ModelAndView registerView(HttpServletRequest request) {
		request.setAttribute("categoryList", service.searchCategory());
		return new ModelAndView("member/registerView");
	}

	@RequestMapping("forgotIdView.do")
	public String forgotIdView() {
		return "member/forgotId";
	}

	//회원정보 check
	@RequestMapping("changePassCheck")
	public String changePassCheck(){
		return "member/changePassCheck";
	}

	@RequestMapping("login_fail.do")
	public String loginFail() {
		return "member/login_fail";
	}

	@RequestMapping("logOn.do")
	public String logOn() {
		return "member/logOn";
	}
	
	// 아이디찾기
	@RequestMapping("forgotId.do")
	public String forgotId(String name, String phone1, String phone2, String phone3, Model model) {
		String phone = "";
		phone += phone1+"-";
		phone += phone2+"-";
		phone += phone3;
		System.out.println(name);
		System.out.println(phone);
		Map<String, String> vo;
		vo = new HashMap<String, String>();
		vo.put("name", name);
		vo.put("phone", phone);
		MemberVO member = service.searchId(vo);
		model.addAttribute("id", member);
		return "member/forgot_result";
	}
	
	// 패스워드(회원) 확인
	@RequestMapping("changePassView.do")
	public String forgotPass(String id, String name, String phone1, String phone2, String phone3, Model model) {
		String url = "";
		String phone = "";
		phone += phone1+"-";
		phone += phone2+"-";
		phone += phone3;
		Map<String, String> vo;
		vo = new HashMap<String, String>();
		vo.put("id", id);
		vo.put("name", name);
		vo.put("phone", phone);
		//MemberVO member = service.searchPass(vo);
		MemberVO member = service.findMember(vo);
		if(member != null){
			model.addAttribute("member", member);
			url = "member/changePassView";
		} else {
			url = "member/changePassCheck_fail";
		}
		return url;
	}
	
	//패스워드 변경
	@RequestMapping("changePass.do")
	public String changePass(String id, String password){
		String pass = passwordEncoder.encode(password);
		service.changePass(id, pass);
		return "member/changePass_result";
	}

	// 친구추천
	@RequestMapping("recommend.do")
	@ResponseBody
	public Object recommend(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<MemberVO> mlist = null;
		mlist = service.findInterestById(vo.getId());
		return mlist;
	}

	// 카테고리 로딩
	@RequestMapping("searchCategory.do")
	public List<CategoryVO> searchCategory(HttpServletRequest request) {
		List<CategoryVO> list = service.searchCategory();
		return list;
	}

	// 아이디 중복체크
	@RequestMapping("idcheckAjax.do")
	@ResponseBody
	public String idcheckAjax(String id) {
		int count = service.idcheck(id);
		return (count == 0) ? "ok" : "fail";
	}

	// 회원 정보, 카테고리, 포인트 등록
	@RequestMapping(value = "registerMember.do", method = RequestMethod.POST)
	public String registerMember(MemberVO vo, HttpServletRequest request) throws IOException {
		System.out.println("하하");
		System.out.println("에러 : "+vo.toString());
		String category[] = request.getParameterValues("cNo");
		service.registerMember(vo, category);
		return "redirect:registerResultView.do";
	}

	// 회원가입 결과
	@RequestMapping("registerResultView.do")
	public ModelAndView registerResultView() {
		return new ModelAndView("member/register_result");
	}

	// 회원정보 수정화면 전환
	@RequestMapping("modifyView.do")
	public String modifyView(HttpServletRequest request, String id) {
		request.setAttribute("categoryList", service.searchCategory());
		List<CategoryVO> cList = service.getCategoryList(id);
		request.setAttribute("categoryList", service.searchCategory());
		request.setAttribute("cList", cList);
		return "member/modifyView";
	}

	// 회원정보 수정
	@RequestMapping("modifyMember.do")
	public ModelAndView modifyMember(HttpServletRequest request,MemberVO modifyMember) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String category[] = request.getParameterValues("cNo");
		String encodedPwd = passwordEncoder.encode(modifyMember.getPassword());
		modifyMember.setPassword(encodedPwd);
		MemberVO mvo = service.modifyMember(modifyMember, category);
		vo.setAddress(mvo.getAddress());
		vo.setFilePath(mvo.getFilePath());
		vo.setPassword(mvo.getPassword());
		vo.setPhone(mvo.getPhone());
		vo.setName(mvo.getName());
		return new ModelAndView("redirect:mypage.do?id="+vo.getId());
	}

	// 프로필사진 업로드
	@RequestMapping("multifileupload.do")
	public String fileUpload(FileVO fvo, HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		// 실제 운영시에 사용할 서버 업로드 경로
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/asset/upload/");
		// System.out.println(uploadPath);
		// 개발시에는 워크스페이스 업로드 경로로 준다
		System.out.println("multifile controller " + fvo.toString());
		//uploadPath = "C:\\Users\\KOSTA\\git\\yolowa\\yolowa\\src\\main\\webapp\\resources\\asset\\upload\\";
		List<MultipartFile> list = fvo.getFile();
		fvo.setUserInfo(vo.getId());
		ArrayList<String> nameList = new ArrayList<String>();
		for (int i = 0; i < list.size(); i++) {
			String fileName = list.get(i).getOriginalFilename();
			if (fileName.equals("") == false) {
				try {
					list.get(i).transferTo(new File(uploadPath + fileName));
					nameList.add(fileName);
					fvo.setPath("resources/asset/upload/" + fileName);
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
			}
		}
		vo.setFilePath(service.updateProfile(fvo).getFilePath());
		return "redirect:mypage.do?id="+vo.getId();
	}

	// aJax 친구 추가된 리스트
	@RequestMapping("friendsList.do")
	@ResponseBody
	public List<MemberVO> friendsList(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		return service.friendsList(vo.getId(), "My");
	}

	@RequestMapping("friendsMsgBox.do")
	@ResponseBody
	public Map<String, Object> friendsMsgBox(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String sId=request.getParameter("rId");
		service.readMsg(vo.getId(),sId);
		return service.friendsMsgBox(vo.getId(), sId);
	}

	// 친구 신청
	@RequestMapping("friendAdd.do")
	@ResponseBody
	public String friendAdd(String id, HttpServletRequest request) {
		int success = 0;
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String sendId = vo.getId();
		String receiveId = id;
		success = service.friendAdd(sendId, receiveId);
		return (success == 0) ? "fail" : "ok";
	}

	// SendMessage
	@RequestMapping("sendMessage.do")
	@ResponseBody
	public String sendMessage(MessageVO msg) {
		System.out.println(msg.toString());
		int success = service.sendMessage(msg);
		return (success == 0) ? "fail" : "ok";
	}

	// Friend Request List
	@RequestMapping("requestList.do")
	@ResponseBody
	public Object requestList(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<MemberVO> relist = null;
		relist = service.requestList(vo.getId());
		return relist;
	}

	// Friend Request Check
	@RequestMapping("friendCheck.do")
	@ResponseBody
	public String friendCheck(String id, HttpServletRequest request) {
		int success = 0;
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		success = service.userRequestAccept(id, vo.getId());
		return (success == 0) ? "fail" : "ok";
	}

	// Friend Delete
	@RequestMapping("friendDelete.do")
	@ResponseBody
	public String friendDelete(String id, HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int success = 0;
		String sendId = id;
		String receiveId = vo.getId();
		success = service.friendDelete(sendId, receiveId);
		return (success == 0) ? "fail" : "ok";
	}

	// Friend List Page
	@RequestMapping("MyListPage.do")
	public String friendListPage(String id, Model model, HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String url = "";
		if (id.equals(vo.getId())) {
			request.setAttribute("ID", vo.getId());
			List<MemberVO> List = service.friendsList(vo.getId(), "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			model.addAttribute("flist", service.friendsList(id, "My"));
			model.addAttribute("plist", service.getPointList(id));
			url = "member/MyListPage.myTiles";
		} else {
			request.setAttribute("ID", id);
			model.addAttribute("fvo", service.findFriendById(id));
			List<MemberVO> List = service.friendsList(id, "My");
			System.out.println(List.size());
			model.addAttribute("friendList", List.size());
			model.addAttribute("flist", service.friendsList(id, "My"));
			model.addAttribute("plist", service.getPointList(id));
			url = "member/MyListPage.myTiles";
		}
		return url;
	}

	@RequestMapping("requestMsg.do")
	@ResponseBody
	public int requestMsg(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		int newMsg = 0;
		newMsg = service.requestMsg(vo.getId());
		return newMsg;
	}

	@RequestMapping("withdrawView.do")
	public String whithdrawView() {
		return "member/withdrawView";
	}

	// 비밀번호 체크
	@RequestMapping("passCheckAjax.do")
	@ResponseBody
	public String passCheckAjax(String password) {
		System.out.println("pass: "+password);
		boolean flag = service.passCheck(password);
		System.out.println(flag);
		return (flag == true) ? "ok" : "fail";
	}
	
	// 회원 탈퇴
	@RequestMapping(value = "withdraw.do", method = RequestMethod.POST)
	public String withdrawMember(String id, String password, HttpServletRequest request){
		service.withdrawMember(id,password);
		HttpSession session = request.getSession(false);
		session.invalidate();
		return "redirect:withdrawResultView.do";
	}
	
	// 회원탈퇴 결과
	@RequestMapping("withdrawResultView.do")
	public ModelAndView withdrawResultView() {
		return new ModelAndView("member/withdraw_result");
	}
}
