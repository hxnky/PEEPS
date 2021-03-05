package com.gnjk.peeps.weather;

public class WeatherVo {
   int seq;
   String baseDate;
   String baseTime;
   String SKY;
   String PTY;
   String T3H;

   public WeatherVo() {
   }
   
   public WeatherVo(int seq,String baseDate, String baseTime, String SKY, String PTY, String T3H) {
      super();
      this.seq = seq;
      this.baseDate = baseDate;
      this.baseTime = baseTime;
      this.SKY = SKY;
      this.PTY = PTY;
      this.T3H = T3H;
   }

   public int getSeq() {
      return seq;
   }
   public void setSeq(int seq) {
      this.seq = seq;
   }
   public String getBaseDate() {
      return baseDate;
   }
   public void setBaseDate(String baseDate) {
      this.baseDate = baseDate;
   }
   public String getBaseTime() {
      return baseTime;
   }
   public void setBaseTime(String baseTime) {
      this.baseTime = baseTime;
   }
   public String getSKY() {
      return SKY;
   }
   public void setSKY(String SKY) {
      this.SKY= SKY;
   }
   public String getPTY() {
      return PTY;
   }
   public void setPTY(String PTY) {
      this.PTY = PTY;
   }
   public String getT3H() {
      return T3H;
   }
   public void setT3H(String T3H) {
      this.T3H = T3H;
   }
}