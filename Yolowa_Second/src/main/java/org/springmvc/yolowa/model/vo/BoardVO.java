package org.springmvc.yolowa.model.vo;

public class BoardVO {
	private int bNo;
	private String bContent;
	private String bPostdate;
	private String bType;
	private MemberVO mvo;
	private BoardOptionVO bovo;
	private FundVO fvo;
	
	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardVO(int bNo, String bContent, String bPostdate, String bType, MemberVO mvo, BoardOptionVO bovo,
			FundVO fvo) {
		super();
		this.bNo = bNo;
		this.bContent = bContent;
		this.bPostdate = bPostdate;
		this.bType = bType;
		this.mvo = mvo;
		this.bovo = bovo;
		this.fvo = fvo;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbPostdate() {
		return bPostdate;
	}
	public void setbPostdate(String bPostdate) {
		this.bPostdate = bPostdate;
	}
	public String getbType() {
		return bType;
	}
	public void setbType(String bType) {
		this.bType = bType;
	}
	public MemberVO getMvo() {
		return mvo;
	}
	public void setMvo(MemberVO mvo) {
		this.mvo = mvo;
	}
	public BoardOptionVO getBovo() {
		return bovo;
	}
	public void setBovo(BoardOptionVO bovo) {
		this.bovo = bovo;
	}
	public FundVO getFvo() {
		return fvo;
	}
	public void setFvo(FundVO fvo) {
		this.fvo = fvo;
	}
	@Override
	public String toString() {
		return "BoardVO [bNo=" + bNo + ", bContent=" + bContent + ", bPostdate=" + bPostdate + ", bType=" + bType
				+ ", mvo=" + mvo + ", bovo=" + bovo + ", fvo=" + fvo + "]";
	}
}
