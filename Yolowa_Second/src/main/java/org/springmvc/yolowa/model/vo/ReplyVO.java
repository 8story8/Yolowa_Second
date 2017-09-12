package org.springmvc.yolowa.model.vo;

public class ReplyVO {
	private int rNo;
	private String rContent;
	private int groupNo;
	private int parentsNo;
	private int depth;
	private int rOrder;
	private MemberVO memberVO;
	private BoardVO boardVO;
	public ReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public ReplyVO(int rNo, String rContent, int groupNo, int parentsNo, int depth, int rOrder, MemberVO memberVO,
			BoardVO boardVO) {
		super();
		this.rNo = rNo;
		this.rContent = rContent;
		this.groupNo = groupNo;
		this.parentsNo = parentsNo;
		this.depth = depth;
		this.rOrder = rOrder;
		this.memberVO = memberVO;
		this.boardVO = boardVO;
	}
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public int getGroupNo() {
		return groupNo;
	}
	public void setGroupNo(int groupNo) {
		this.groupNo = groupNo;
	}
	public int getParentsNo() {
		return parentsNo;
	}
	public void setParentsNo(int parentsNo) {
		this.parentsNo = parentsNo;
	}
	public int getDepth() {
		return depth;
	}
	public void setDepth(int depth) {
		this.depth = depth;
	}
	public int getrOrder() {
		return rOrder;
	}
	public void setrOrder(int rOrder) {
		this.rOrder = rOrder;
	}
	public MemberVO getMemberVO() {
		return memberVO;
	}
	public void setMemberVO(MemberVO memberVO) {
		this.memberVO = memberVO;
	}
	public BoardVO getBoardVO() {
		return boardVO;
	}
	public void setBoardVO(BoardVO boardVO) {
		this.boardVO = boardVO;
	}
	@Override
	public String toString() {
		return "ReplyVO [rNo=" + rNo + ", rContent=" + rContent + ", groupNo=" + groupNo + ", parentsNo=" + parentsNo
				+ ", depth=" + depth + ", rOrder=" + rOrder + ", memberVO=" + memberVO + ", boardVO=" + boardVO + "]";
	}
}