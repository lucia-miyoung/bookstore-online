package total.login.web;

import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import javax.annotation.Resource;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.CommonController;
import common.EncryptUtil;
import total.login.service.LoginService;


@Controller
public class LoginController extends CommonController {


	protected ModelAndView mv = null;
	
	
	@Resource(name="LoginService")
	 private LoginService service;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	@RequestMapping(value="/")
	public String home(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		return "/login/signin";
	}
	

	@ResponseBody
	@RequestMapping(value="/loginChk.do")
	public HashMap<String,Object> loginUser(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("loginChk.do : {} " + paramMap );
		int loginChk = service.memberloginChk(paramMap);
		String login_ip = req.getHeader("X_FORWARDED_FOR"); 
		 if(login_ip == null) { login_ip = req.getRemoteAddr(); } 
		  paramMap.put("access_ip", login_ip); 

		  if(loginChk > 0) {
			HttpSession session = req.getSession();
			service.getMemberList(paramMap);
			String nickName = (String) service.getMemberInfo(paramMap).get("member_name");
			session.setAttribute("userId", nickName);	
			System.out.println("loginChk: " +loginChk);
		}		

		HashMap rsMap = new HashMap();
		rsMap.put("paramMap", service.getMemberInfo(paramMap));
		rsMap.put("loginCheck", loginChk);
		
		return rsMap;
	}
	
	@RequestMapping(value="/login")
	public String login(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception {
		model.addAttribute("paramMap", paramMap);
		
		return "/login/signin";
	}
	
	@ResponseBody
	@RequestMapping(value="/logout")
	public String logout(HttpServletRequest req, @RequestParam HashMap paramMap,ModelMap model) throws Exception {
		model.addAttribute("paramMap", paramMap);
		System.out.println("paramMap "+paramMap);
		HttpSession session = req.getSession();
	         session.invalidate();
	      String cp = req.getContextPath();
			System.out.println("로그아웃 완료");
		return "success";
	}

	@RequestMapping(value="/signup")
	public String signup(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception {
		
		System.out.println("signup {} : " + paramMap);
		model.addAttribute("paramMap", paramMap);
		return "/login/signup";
	}
	
	@RequestMapping(value="/signupSubmit")
	public String signupSubmit(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception {	
		System.out.println("signupSubmit {} : " + paramMap);	
		
		if("signup".equals(paramMap.get("kind"))) {
			service.membersignup(paramMap);
			service.insertdatabox(paramMap);
		}
		model.addAttribute("paramMap", paramMap);	
		return "/login/signin";
	}
	
	@ResponseBody
	@RequestMapping(value="/signupCheck")
	public HashMap<String, Object> signupCheck(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception {
		System.out.println("signupCheck {} : " + paramMap);
		
		HashMap rsMap = new HashMap(paramMap);
		if(paramMap.containsKey("member_email")) {
		int emailChk = service.emaildupCheck(paramMap);
			System.out.println(service.emaildupCheck(paramMap));
			rsMap.put("emailCheck", emailChk);
		}

		if(paramMap.containsKey("member_name")) {
		int namechk = service.namedupCheck(paramMap);
			rsMap.put("nameCheck", namechk);
		}		
		model.addAttribute("paramMap", paramMap);

		return rsMap;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/emailAuthentication")
	public String emailAuthentication(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception {

	
		Random random = new Random(); 
		int checkNum = random.nextInt(888888) + 111111;

		
		String setFrom = "cfvn1004@naver.com";
		String toMail = (String)paramMap.get("member_email");
		String title = "회원가입 인증 메일입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다."
				+ "<br><br>" + "인증 번호는" + checkNum + " 입니다."
				+ "<br>" + "해당 인증번호를 인증번호 확인란에 기입해주세요.";
		
		 try { 
		MimeMessage msg = mailSender.createMimeMessage(); 
		 MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8"); 
		 helper.setFrom(setFrom);
		 helper.setTo(toMail); 
		 helper.setSubject(title); 
		 helper.setText(content, true); 
		 mailSender.send(msg);
		 
		 } catch(Exception e) { 
			 e.printStackTrace(); 
		 }
		 
		 String num = Integer.toString(checkNum);
		 
		return num;
	}
}
