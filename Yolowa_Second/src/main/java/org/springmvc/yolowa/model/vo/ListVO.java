package org.springmvc.yolowa.model.vo;

import java.util.List;

public class ListVO {
	private List<MessageVO> messageList;
	private PagingBean pagingBean;

	public ListVO() {
		super();
	}

	public ListVO(List<MessageVO> messageList, PagingBean pagingBean) {
		super();
		this.messageList = messageList;
		this.pagingBean = pagingBean;
	}

	public List<MessageVO> getMessageList() {
		return messageList;
	}

	public void setMessageList(List<MessageVO> messageList) {
		this.messageList = messageList;
	}

	public PagingBean getPagingBean() {
		return pagingBean;
	}

	public void setPagingBean(PagingBean pagingBean) {
		this.pagingBean = pagingBean;
	}

	@Override
	public String toString() {
		return "ListVO [messageList=" + messageList + ", pagingBean=" + pagingBean + "]";
	}

}
