package org.springmvc.yolowa.model.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileVO {
	private String userInfo;
	private List<MultipartFile> file;
	private String path;
	public FileVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public FileVO(String userInfo, List<MultipartFile> file) {
		super();
		this.userInfo = userInfo;
		this.file = file;
	}

	public FileVO(String userInfo, List<MultipartFile> file, String path) {
		super();
		this.userInfo = userInfo;
		this.file = file;
		this.path = path;
	}
	public String getUserInfo() {
		return userInfo;
	}
	public void setUserInfo(String userInfo) {
		this.userInfo = userInfo;
	}
	public List<MultipartFile> getFile() {
		return file;
	}
	public void setFile(List<MultipartFile> file) {
		this.file = file;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	@Override
	public String toString() {
		return "FileVO [userInfo=" + userInfo + ", file=" + file + ", path=" + path + "]";
	}

	
}
