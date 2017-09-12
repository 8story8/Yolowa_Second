package org.springmvc.yolowa.model.vo;

public class MessageVO {

	private int mNo;
	private String rId;
	private String sId;
	private String message;
	private String mPostdate;
	private String mCheck;

	public MessageVO() {
		super();
	}

	public MessageVO(int mNo, String rId, String sId, String message, String mPostdate, String mCheck) {
		super();
		this.mNo = mNo;
		this.rId = rId;
		this.sId = sId;
		this.message = message;
		this.mPostdate = mPostdate;
		this.mCheck = mCheck;
	}

	public int getmNo() {
		return mNo;
	}

	public void setmNo(int mNo) {
		this.mNo = mNo;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public String getsId() {
		return sId;
	}

	public void setsId(String sId) {
		this.sId = sId;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getmPostdate() {
		return mPostdate;
	}

	public void setmPostdate(String mPostdate) {
		this.mPostdate = mPostdate;
	}

	public String getmCheck() {
		return mCheck;
	}

	public void setmCheck(String mCheck) {
		this.mCheck = mCheck;
	}

	@Override
	public String toString() {
		return "MessageVO [mNo=" + mNo + ", rId=" + rId + ", sId=" + sId + ", message=" + message + ", mPostdate="
				+ mPostdate + ", mCheck=" + mCheck + "]";
	}

}
