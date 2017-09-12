package org.springmvc.yolowa.controller;

import java.nio.file.AccessDeniedException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.WebAttributes;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmvc.yolowa.model.service.BoardService;
import org.springmvc.yolowa.model.service.FundService;
import org.springmvc.yolowa.model.service.MemberService;
import org.springmvc.yolowa.model.service.RankService;
import org.springmvc.yolowa.model.vo.MemberVO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	@Resource
	private FundService fundService;

	@Resource
	private RankService rankService;

	@Resource
	private MemberService service;

	@Resource
	private BoardService boardService;

	@RequestMapping("{viewName}.do")
	public String showView1(@PathVariable String viewName, HttpServletRequest request) {
		System.out.println("@PathVariable : " + viewName);
		HashMap<String, Object> usageCount = (HashMap<String, Object>) boardService.getUsageCount();
		request.setAttribute("usageCount", usageCount);
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		return viewName + ".tiles";
	}

	@RequestMapping("{dirName}/{viewName}.do")
	public String showView2(@PathVariable String dirName, @PathVariable String viewName) {
		System.out.println("@PathVariable : " + dirName + "/" + viewName);
		return dirName + "/" + viewName + ".tiles";
	}

	@RequestMapping("mainAllContent.do")
	public String home(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		request.setAttribute("cList", service.getCategoryList(vo.getId()));
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록

		// 친구 리스트 & 메세지 박스
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			List<HashMap<String, Object>> bList = (List<HashMap<String, Object>>) boardService.getAllBoardList();
			for(int i = 0; i < bList.size(); i++){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", vo.getId());
				map.put("bNo", bList.get(i).get("bNo"));
				int count = (int) boardService.confirmLike(map);
				if(count == 0){
					if(boardService.selectLike(map).size() == 0){
						bList.get(i).put("countlike", "");
					}
					else{
						bList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
					}
				}
				else{
					if((boardService.selectLike(map).size()-1) == 0){
						bList.get(i).put("countlike", vo.getId() + "님");
					}
					else{
						bList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
					}
				}
			}
			request.setAttribute("bList", bList);
		
		return "board/mainAllContent.contentTiles";
	}
	
	@RequestMapping("mainAllFunding.do")
	public String fundHome(HttpServletRequest request) {
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		request.setAttribute("cList", service.getCategoryList(vo.getId()));
		request.setAttribute("fList", fundService.getAllFundList());
		List<HashMap<String, Object>> fList= fundService.getAllFundList();
		int point=0;
		for(int i=0;i<fList.size();i++){
			if(fList.get(i).get("fTitle").equals(0)){
			}
			else{
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", vo.getId());
				map.put("bNo", fList.get(i).get("bNo"));
				Map<String, Object> checkMap =(Map<String, Object>)fundService.checkGoalFunding(map);
				int fpoint = Integer.parseInt(checkMap.get("FPOINT").toString());
				int totalpoint = Integer.parseInt(checkMap.get("TOTALPOINT").toString());
				point=service.checkMyPoint(map);
				int count =	fundService.selectCountFunding(map);
				if(fpoint<=totalpoint){
					fList.get(i).put("applyType", "마감");
				}else{
					if(count==0){
						fList.get(i).put("applyType", "신청");
						vo.setPoint(service.checkMyPoint(map));
					}else{
						fList.get(i).put("applyType", "취소");
						vo.setPoint(service.checkMyPoint(map));
					}
				}
			}
		}
		request.setAttribute("myPoint", point);
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		// 친구 리스트 & 메세지 박스
		if (vo != null) {
			request.setAttribute("friendsList", service.memberSearchFriends(vo.getId()));
			//List<HashMap<String, Object>> bList = (List<HashMap<String, Object>>) boardService.getAllBoardList();
			for(int i = 0; i < fList.size(); i++){
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id", vo.getId());
				map.put("bNo", fList.get(i).get("bNo"));
				int count = (int) boardService.confirmLike(map);
				if(count == 0){
					if(boardService.selectLike(map).size() == 0){
						fList.get(i).put("countlike", "");
					}
					else{
						fList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
					}
				}
				else{
					if((boardService.selectLike(map).size()-1) == 0){
						fList.get(i).put("countlike", vo.getId() + "님");
					}
					else{
						fList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
					}
				}
			}
			
			request.setAttribute("fList", fList);
		}
		
		return "board/mainAllFunding.contentTiles";
	}

	@RequestMapping("mainAllCategory.do")
	public String mainAllCategory(HttpServletRequest request){
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String category = (String)request.getParameter("category");
		List<HashMap<String, Object>> bCList = (List<HashMap<String, Object>>) boardService.getAllBoardListByCategory(category);
		for(int i = 0; i < bCList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", bCList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					bCList.get(i).put("countlike", "");
				}
				else{
					bCList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
			}
			else{
				if((boardService.selectLike(map).size()-1) == 0){
					bCList.get(i).put("countlike", vo.getId() + "님");
				}
				else{
					bCList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
				}
			}
		}
		
		request.setAttribute("bCList", bCList);
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		return "board/mainAllCategory.contentTiles";
	}
	
	@RequestMapping("denied.do")
	public String denied(Model model, Authentication auth, HttpServletRequest req){
	AccessDeniedException ade = (AccessDeniedException) req.getAttribute(WebAttributes.ACCESS_DENIED_403);
	 model.addAttribute("auth", auth);
	 model.addAttribute("errMsg", ade);
	 return "denied";
	} 
	
	@RequestMapping("mainAllCustomizedContent.do")
	public String mainAllCustomizedContent(HttpServletRequest request){
		MemberVO vo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		List<HashMap<String, Object>> cbList = (List<HashMap<String, Object>>) boardService.getAllCustomizedBoardListById(vo.getId());
		for(int i = 0; i < cbList.size(); i++){
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("id", vo.getId());
			map.put("bNo", cbList.get(i).get("bNo"));
			int count = (int) boardService.confirmLike(map);
			if(count == 0){
				if(boardService.selectLike(map).size() == 0){
					cbList.get(i).put("countlike", "");
				}
				else{
					cbList.get(i).put("countlike", boardService.selectLike(map).size() + "명");
				}
			}
			else{
				if((boardService.selectLike(map).size()-1) == 0){
					cbList.get(i).put("countlike", vo.getId() + "님");
				}
				else{
					cbList.get(i).put("countlike", "회원님 외 " + (boardService.selectLike(map).size()-1) + "명");
				}
			}
		}
		request.setAttribute("fList", fundService.getAllFundList());
		request.setAttribute("cbList", cbList);
		request.setAttribute("categoryList", service.searchCategory());   // 왼쪽 팝업 카테고리 목록
		request.setAttribute("rankList", rankService.selectRank());   // 검색어 랭킹 목록
		request.setAttribute("replyList", boardService.getAllListReply());   // 댓글 목록
		return "board/mainAllCustomizedContent.contentTiles";
	}
}
