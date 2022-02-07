package total.login.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.EncryptUtil;
import total.login.mapper.LoginMapper;
import total.login.service.LoginService;

@Service("LoginService")
public class LoginServiceImpl implements LoginService{

	@Autowired
	private LoginMapper mapper;
	
	@Override
	public int emaildupCheck(HashMap paramMap) throws Exception {
		return mapper.emaildupCheck(paramMap);
	}
	
	@Override 
	public int namedupCheck(HashMap paramMap) throws Exception {
		return mapper.namedupCheck(paramMap);
	}
	
	@Override
	public HashMap membersignup(HashMap paramMap) throws Exception {
		String userPW = (String) paramMap.get("member_pw");
		String userNewPW = EncryptUtil.encryptSha256(userPW);
		paramMap.put("member_new_pw", userNewPW);
		return mapper.membersignup(paramMap);
	}
	
	@Override
	public void insertdatabox(HashMap paramMap) throws Exception {
		mapper.insertdatabox(paramMap);
	}
	
	@Override
	public int memberloginChk(HashMap paramMap) throws Exception {
		String userPW = (String) paramMap.get("member_pw");
		String userNewPW = EncryptUtil.encryptSha256(userPW);
		paramMap.put("member_new_pw", userNewPW);
		return mapper.memberloginChk(paramMap);
	}

	@Override
	public HashMap getMemberList(HashMap paramMap) throws Exception {
		String userPW = (String) paramMap.get("member_pw");
		String userNewPW = EncryptUtil.encryptSha256(userPW);
		paramMap.put("member_new_pw", userNewPW);
		mapper.insertLoginHistory(paramMap);
		
		return mapper.getMemberList(paramMap);
	}
	
	@Override
	public HashMap getMemberInfo(HashMap paramMap) throws Exception {
		return mapper.getMemberInfo(paramMap);
	}
	/*
	 * @Override public HashMap insertLoginHistory(HashMap paramMap) throws
	 * Exception { return mapper.insertLoginHistory(paramMap); }
	 */
	
}
