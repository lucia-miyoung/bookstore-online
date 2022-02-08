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
import common.PageUtil;
import total.basic.service.BasicService;
import total.member.service.MemberService;

@Controller
@RequestMapping("/common")
public class BasicController extends CommonController{

	@Resource(name = "pageUtil")
	private PageUtil pageUtil;
	
	@Resource(name = "MemberService")
	private MemberService memService;
	
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
	@RequestMapping(value="/showqstlist")
	public String showqstlist(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
			System.out.println("showqstlist {}:  " + paramMap);
			int totalCnt = service.qstTotalListCnt(paramMap);

			if(paramMap.get("currPage")==null) {
				paramMap.put("currPage" , '1');
			}		
			paramMap.put("listCnt", totalCnt);
			pageUtil.setPage(paramMap); 
			pageUtil.setListCnt(totalCnt);
			System.out.println("페이지 시작: " + pageUtil.getStartPage());
			System.out.println("페이지 끝: " + pageUtil.getEndPage());
			System.out.println("페이지 수: " + pageUtil.getPageCnt());
			System.out.println("총 개수: " + totalCnt);
			HashMap rsMap = new HashMap(paramMap);
			rsMap.put("pageCnt", pageUtil.getPageCnt());
			rsMap.put("startPage", pageUtil.getStartPage());
			rsMap.put("endPage", pageUtil.getEndPage());
			rsMap.put("preBtn", pageUtil.isPrev());
			rsMap.put("nextBtn", pageUtil.isNext());
			rsMap.put("rowNum", pageUtil.getRowNum());
			model.addAttribute("paramMap", paramMap);
			model.addAttribute("qstallList", service.qstTotalList(paramMap));
			model.addAttribute("currPage", paramMap.get("currPage"));
			model.addAttribute("paging",rsMap);
			System.out.println("paramMap:" + paramMap);
			System.out.println(rsMap);
			return "/main/question";
	}
	
	@RequestMapping(value="/servicecenter")
	public String servicecenter(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("/servicecenter {}:  " + paramMap);
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("myqstList", memService.showmyQstList(paramMap));
		
			return "/main/service";
	}
	
}
