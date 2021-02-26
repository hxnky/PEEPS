package com.gnjk.peeps.Member.Service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.StringRedisSerializer;
import org.springframework.stereotype.Service;

import com.gnjk.peeps.Member.domain.LoginInfo;

@Service
public class RedisService {

//	private Logger logger = LoggerFactory.getLogger(this.getClass().getName());
//
//	private String TAG = this.getClass().getName();

	// 리스트나 맵의 형식을 그대로 저장
	@Autowired
	private RedisTemplate<String, Object> redisTemplate;

	/**
	 * Redis 에 사용자 정보를 등록한다.
	 * 
	 * @param LoginInfo
	 */

	public void setUserInformation(LoginInfo loginInfo, HttpSession session) {

		// logger.debug("> setUserInformation", TAG);

		redisTemplate.setKeySerializer(new StringRedisSerializer());
		redisTemplate.setValueSerializer(new StringRedisSerializer());

		String key = session.getId();

		Map<String, Object> mapMemberInfo = new HashMap<String, Object>();
		mapMemberInfo.put("m_idx", loginInfo.getM_idx());
		mapMemberInfo.put("email", loginInfo.getEmail());
		mapMemberInfo.put("name", loginInfo.getName());
		mapMemberInfo.put("loginType", loginInfo.getLoginType());
		mapMemberInfo.put("id", loginInfo.getId());
		mapMemberInfo.put("m_photo", loginInfo.getM_photo());
		redisTemplate.opsForHash().putAll(key, mapMemberInfo);

		session.setAttribute("m_idx", loginInfo.getM_idx());
		session.setAttribute("email", loginInfo.getEmail());
		session.setAttribute("name", loginInfo.getName());
		session.setAttribute("loginType", loginInfo.getLoginType());
		session.setAttribute("m_photo", loginInfo.getM_photo());
		session.setAttribute("id", loginInfo.getId());

	}

	/**
	 * Redis 에서 사용자 정보를 가져온다.
	 * 
	 * @param loginInfo
	 * @return
	 */

	public LoginInfo getUserInformation(String sessionId) {

		// logger.debug("> getUserInformation", TAG);

		String key = sessionId;

		LoginInfo result = new LoginInfo((int) redisTemplate.opsForHash().get(key, "m_idx"),
				(String) redisTemplate.opsForHash().get(key, "email"),
				(String) redisTemplate.opsForHash().get(key, "name"),
				(String) redisTemplate.opsForHash().get(key, "loginType"),
				(String) redisTemplate.opsForHash().get(key, "m_photo"),
				(String) redisTemplate.opsForHash().get(key, "id"));

		return result;

	}

}
