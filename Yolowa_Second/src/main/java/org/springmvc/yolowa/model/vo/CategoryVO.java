package org.springmvc.yolowa.model.vo;

public class CategoryVO {
	private int cNO;
	private String cType;

	public CategoryVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public CategoryVO(int cNO, String cType) {
		super();
		this.cNO = cNO;
		this.cType = cType;
	}
	public int getcNO() {
		return cNO;
	}
	public void setcNO(int cNO) {
		this.cNO = cNO;
	}
	public String getcType() {
		return cType;
	}
	public void setcType(String cType) {
		this.cType = cType;
	}
	@Override
	public String toString() {
		return "CategoryVO [cNO=" + cNO + ", cType=" + cType + "]";
	}
}
