package total.basic.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.CommonController;
import total.basic.service.BasicService;

@Controller
@RequestMapping("/common")
public class BasicController extends CommonController{

	
	@Resource(name="BasicService")
	private BasicService service;	
	
	@RequestMapping(value="/showqstdetail")
	public String showqstdetail(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
			System.out.println("showqstdetail {}:  " + paramMap);
			if(paramMap.containsKey("qstIdx")) {
				paramMap.put("qst_index", paramMap.get("qstIdx"));
				service.qstdetail(paramMap);
				System.out.println(service.qstdetail(paramMap));
			}
			model.addAttribute("qstdetail", service.qstdetail(paramMap));
			model.addAttribute("paramMap", paramMap);
			
		return "/main/questiondetail";		
	}
	
	@ResponseBody
	@RequestMapping(value="/setcommentdetail")
	public int setcommentdetail(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
			System.out.println("setcommentdetail {}:  " + paramMap);

			int result = 0;
			String manager = "관리자";
			if("I".equals(paramMap.get("status")) && manager.equals(paramMap.get("member_name")) && paramMap.containsKey("qst_index")) {
				 service.updateqstdetail(paramMap); 
				 result = 1;
			}else {
				result = 0;
			}
			model.addAttribute("paramMap", paramMap);
			System.out.println(result);
		return result;		
	}
	
	
	
}
