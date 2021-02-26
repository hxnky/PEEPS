package com.gnjk.post.mypost.domain;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class LikeRequest {

   // 21.02.24 한경 추가
   private int m_idx;
   private String id;
   private String m_photo;
   private int followChk;
   private String loginType;

   @Override
   public String toString() {
      return "LikeRequest [m_idx=" + m_idx + ", id=" + id + ", m_photo=" + m_photo + ", followChk=" + followChk
            + ", loginType=" + loginType + "]";
   }

}
