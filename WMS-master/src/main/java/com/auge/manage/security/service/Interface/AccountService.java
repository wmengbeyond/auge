package com.auge.manage.security.service.Interface;

import com.auge.manage.exception.UserAccountServiceException;

import java.util.Map;

/**
 * 账号相关服务
 * @author Ken
 *
 */
public interface AccountService {

	/**
	 * 密码更改
	 * @param userName 用户唯一用户名
	 * @param passwordInfo 更改的密码信息
	 */
	public void passwordModify(String userName, Map<String, Object> passwordInfo) throws UserAccountServiceException;
}
