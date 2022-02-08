package total.book.web;

import java.util.HashMap;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import common.CommonController;
import total.book.service.BookService;
import total.login.service.LoginService;
import total.member.service.MemberService;

@Controller
@RequestMapping("/book")
public class BookController extends CommonController{
	
	protected final Logger log = LoggerFactory.getLogger(getClass());
	protected ModelAndView mv = null;
	
	@Resource(name="LoginService")
	private LoginService loginService;
	
	@Resource(name="BookService")
	private BookService service;
	
	@Resource(name="MemberService")
	private MemberService memService;
	
	
	@RequestMapping(value="/main")
	public String booklist(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		
		model.addAttribute("paramMap", memService.getMemInfo(paramMap));
		model.addAttribute("bookList", service.bookList(paramMap));
		model.addAttribute("reviewList", memService.reviewListall(paramMap));
		model.addAttribute("saleList", service.salebookList(paramMap));
		
		return "/main/main";
	}
	
	@RequestMapping(value="/orderbook")
	public String orderbook(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("orderbook {} : " + paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("memInfo", memService.getMemInfo(paramMap));
		model.addAttribute("bookInfo", service.bookDetail(paramMap));
		System.out.println("mem: " + memService.getMemInfo(paramMap));
		System.out.println("book: " + service.bookDetail(paramMap));
		return "/main/paper";
	}

	@RequestMapping(value="/search")
	public String search(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("search {} : " + paramMap);
		
		if(paramMap.get("search-keyword") != null) {
			paramMap.put("keyword", paramMap.get("search-keyword"));
		}

		System.out.println("search2 {} : " + paramMap);
		model.addAttribute("bookCount", service.bookListCount(paramMap));
		model.addAttribute("bookList", service.bookList(paramMap));
		model.addAttribute("paramMap", paramMap);

		return "/main/search";
	}
	@RequestMapping(value="/best") 
	public String best(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("best {} : " + paramMap);
	
		model.addAttribute("bookList", service.bookList(paramMap));
		model.addAttribute("paramMap", paramMap);

		return "/main/best";
	}
	@RequestMapping(value="/books") 
	public String books(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("book {} : " + paramMap);
	
		model.addAttribute("bookList", service.bookList(paramMap));
		model.addAttribute("paramMap", paramMap);

		return "/main/books";
	}
	
	@ResponseBody
	@RequestMapping(value="/preview")
	public Object preview(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("preview {} : " + paramMap);
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("bookList", service.bookList(paramMap));
		System.out.println(service.bookList(paramMap));
		
		return model;
	}
	
	@RequestMapping(value="/showViewer")
	public String showViewer(HttpServletRequest req,HttpServletResponse res, @RequestParam HashMap paramMap,ModelMap model) throws Exception{
		System.out.println("search {} : " + paramMap);
		
		model.addAttribute("paramMap", paramMap);
		
		return "/main/viewer";
	}
	
	
	/*
	 * @RequestMapping(value="/showlikedUsers") public Object
	 * showlikedUsers(HttpServletRequest req,HttpServletResponse res, @RequestParam
	 * HashMap paramMap,ModelMap model) throws Exception{
	 * 
	 * System.out.println(paramMap); model.addAttribute("paramMap", paramMap);
	 * model.addAttribute("likedlist", service.booklikeUsers(paramMap));
	 * System.out.println(service.booklikeUsers(paramMap));
	 * 
	 * return "/main/detailInfo"; }
	 */
}
