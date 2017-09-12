package org.springmvc.yolowa.model.vo;

public class BoardOptionVO {
	private int bNo;
	private String local;
	private String filepath;
	
	public BoardOptionVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public BoardOptionVO(int bNo, String local, String filepath) {
		super();
		this.bNo = bNo;
		this.local = local;
		this.filepath = filepath;
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getLocal() {
		return local;
	}
	public void setLocal(String local) {
		this.local = local;
	}
	public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
	@Override
	public String toString() {
		return "BoardOptionVO [bNo=" + bNo + ", local=" + local + ", filepath=" + filepath + "]";
	}
}
