package total.login.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

public interface LoginService {

	public int emaildupCheck(HashMap paramMap) throws Exception;
	
	public int namedupCheck(HashMap paramMap) throws Exception;
	
	public HashMap membersignup(HashMap paramMap) throws Exception;
	
	public void insertdatabox(HashMap paramMap) throws Exception;
	 
	public int memberloginChk(HashMap paramMap) throws Exception;
	
	public HashMap getMemberList(HashMap paramMap) throws Exception;

	public HashMap getMemberInfo(HashMap paramMap) throws Exception;

}



