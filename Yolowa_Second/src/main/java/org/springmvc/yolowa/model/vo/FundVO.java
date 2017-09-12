package org.springmvc.yolowa.model.vo;

public class FundVO {
	private String fTitle;
	private int fPoint;
	private String fDeadLine;
	private int fPeople;

	public FundVO() {
		super();

	}

	public FundVO(String fTitle, int fPoint, String fDeadLine, int fPeople) {
		super();
		this.fTitle = fTitle;
		this.fPoint = fPoint;
		this.fDeadLine = fDeadLine;
		this.fPeople = fPeople;
	}

	public String getfTitle() {
		return fTitle;
	}

	public void setfTitle(String fTitle) {
		this.fTitle = fTitle;
	}

	public int getfPoint() {
		return fPoint;
	}

	public void setfPoint(int fPoint) {
		this.fPoint = fPoint;
	}

	public String getfDeadLine() {
		return fDeadLine;
	}

	public void setfDeadLine(String fDeadLine) {
		this.fDeadLine = fDeadLine;
	}

	public int getfPeople() {
		return fPeople;
	}

	public void setfPeople(int fPeople) {
		this.fPeople = fPeople;
	}

	@Override
	public String toString() {
		return "FundVO [fTitle=" + fTitle + ", fPoint=" + fPoint + ", fDeadLine=" + fDeadLine + ", fPeople=" + fPeople
				+ "]";
	}

}
