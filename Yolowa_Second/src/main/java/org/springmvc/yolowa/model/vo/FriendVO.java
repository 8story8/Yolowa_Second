package org.springmvc.yolowa.model.vo;

public class FriendVO {
   private String sendId;
   private String receiveId;
   private String fcheck;

   public FriendVO() {
      super();
   }

   public FriendVO(String sendId, String receiveId){
	   super();
	   this.sendId = sendId;
	   this.receiveId = receiveId;
   }
   
   public FriendVO(String sendId, String receiveId, String fcheck) {
      super();
      this.sendId = sendId;
      this.receiveId = receiveId;
      this.fcheck = fcheck;
   }

   public String getSendId() {
      return sendId;
   }

   public void setSendId(String sendId) {
      this.sendId = sendId;
   }

   public String getReceiveId() {
      return receiveId;
   }

   public void setReceiveId(String receiveId) {
      this.receiveId = receiveId;
   }

   public String getFcheck() {
      return fcheck;
   }

   public void setFcheck(String fcheck) {
      this.fcheck = fcheck;
   }

   @Override
   public String toString() {
      return "FriendVO [sendId=" + sendId + ", receiveId=" + receiveId + ", fcheck=" + fcheck + "]";
   }
}
