package total.member.web;

import java.io.Console;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import common.CommonController;
import total.basic.service.BasicService;
import total.book.service.BookService;
import total.login.service.LoginService;
import total.member.service.MemberService;

@Controller
@RequestMapping("/member")
public class MemberController extends CommonController {

	private static final String filePath = "/var/lib/tomcat8/webapps/data/image";
	private static final String svcPath = "/var/lib/tomcat8/webapps/data/service";
	protected ModelAndView mv = null;

	@Resource(name = "MemberService")
	private MemberService service;

	@Resource(name = "BookService")
	private BookService bookService;

	@Resource(name = "LoginService")
	private LoginService loginService;

	@Resource(name = "BasicService")
	private BasicService basicService;

	@RequestMapping(value = "/mypage")
	public String goMypage(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("mypage {}:  " + paramMap);
		int reviewCnt = service.reviewCount(paramMap);
		paramMap.put("member_id", service.getMemInfo(paramMap).get("member_id"));
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("reviewCnt", reviewCnt);
		model.addAttribute("zzimList", service.zzimList(paramMap));
		model.addAttribute("zzimbookcount", service.myzzimCount(paramMap));
		model.addAttribute("likebookcount", service.myheartCount(paramMap));
		model.addAttribute("reviewList", service.reviewList(paramMap));
		model.addAttribute("orderList", service.orderList(paramMap));
		model.addAttribute("orderCnt", service.orderListCnt(paramMap));
		model.addAttribute("showdata", service.showalldata(paramMap));
		model.addAttribute("userdata", service.getMemInfo(paramMap));
		System.out.println(service.orderList(paramMap));

		return "/login/mypage";
	}

	@ResponseBody
	@RequestMapping(value = "/review")
	public HashMap<String, Object> review(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("review {}:  " + paramMap);
		
		HashMap rsMap = new HashMap(paramMap);
		model.addAttribute("paramMap", paramMap);
		if ("I".equals(paramMap.get("status")) && paramMap.containsKey("status")) {
			int dupchk = service.reviewdupChk(paramMap);
			rsMap.put("reviewdupChk", dupchk);
			System.out.println(service.reviewdupChk(paramMap));
			if (dupchk == 0) {
				int insertchk = service.insertReview(paramMap);
				System.out.println("리뷰등록 완료1 미완료0 : " + insertchk);
			}
		}
		if ("D".equals(paramMap.get("status")) && paramMap.containsKey("status")) {
			int delchk = service.deleteReview(paramMap);
			System.out.println("리뷰삭제 완료1 미완료0 : " + delchk);
		}

		return rsMap;
	}

	@RequestMapping(value = "/myaccount")
	public String myaccount(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("myaccount {}:  " + paramMap);
		service.getMemInfo(paramMap);
		model.addAttribute("paramMap", paramMap);

		return "/login/myaccount";
	}

	@RequestMapping(value = "/updatemypage")
	public String updatemypage(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("updatemypage {}:  " + paramMap);
		model.addAttribute("paramMap", loginService.getMemberInfo(paramMap));
		model.addAttribute("memData", service.getMemInfo(paramMap));
		System.out.println("paramMap: " +paramMap);
		System.out.println("memData: " +service.getMemInfo(paramMap));
		return "/login/update";
	}

	@ResponseBody
	@RequestMapping(value = "/setUpdateData")
	public HashMap<String, Object> setUpdateData(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			 @RequestParam(value="camera") MultipartFile mfile, ModelMap model) throws Exception {
		System.out.println("setUpdateData {}:  " + paramMap);
		HashMap rsMap = new HashMap();
		int result = 0;
		
		if(mfile != null	&&  mfile.getSize() > 0) {

			if ("U".equals(paramMap.get("status")) && paramMap.containsKey("member_name")) {
			
				String id = (String) paramMap.get("member_id");
				String idnm = id.split("@")[0];
				String newPath = filePath + "/" + idnm;
			
				File updir = new File(newPath);
				System.out.println(updir);
				if(!updir.exists()) {
					updir.mkdirs();
				}

				
				String imgName = mfile.getOriginalFilename().toString();
				System.out.println("imgName: " + imgName);
				String realPath = "/" + idnm + "/" + imgName;
				String imgpath = newPath + '/' + imgName;
				File filechk = new File(imgpath);
			
				if(filechk.exists()) {
					System.out.println("동일한 파일 존재 > 삭제할거야");
					filechk.delete();
				}
				paramMap.put("member_image", realPath);
				System.out.println("realPath: " + realPath);
				service.updatemyinfo(paramMap); 
				mfile.transferTo(new File(imgpath));
				System.out.println("파일 첨부 있음");
				result = 1; 
			
			} 	else { 
				result = 0; 
			}
			
		} else {
			//파일 첨부 없을때 
			String orgName = (String) paramMap.get("orgin_img");
				paramMap.put("member_image", orgName);
				service.updatemyinfo(paramMap); 
				System.out.println("파일 첨부 없음");
				result = 1; 
		}
		
		rsMap.put("paramMap", paramMap);
		rsMap.put("result", result);

		return rsMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "/setQuestionService")
	public int setQuestionService(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			@RequestParam(value="qst_image") MultipartFile mfile, ModelMap model) throws Exception {
		System.out.println("setQuestionService {}:  " + paramMap);
		
		int result = 0;
		if(mfile != null	&&  mfile.getSize() > 0) {
			if ("I".equals(paramMap.get("status")) && paramMap.containsKey("member_name")) {

				String imgRealnm = mfile.getOriginalFilename().toString();
				System.out.println("imgRealnm: " + imgRealnm);
				String imgName = "/" + imgRealnm;
				String imgpath = svcPath + imgName;
				File filechk = new File(imgpath);
				System.out.println(filechk);
				if(filechk.exists()) {
					System.out.println("동일한 파일이름 존재 2");
					result = 2;
				}
				paramMap.put("qst_image", imgName);
				service.insertQuestion(paramMap);
				mfile.transferTo(new File(imgpath));
				result = 1; 
				System.out.println("파일 첨부 있음");
			} 	else { 
				result = 0; 
			}
		}else {
			paramMap.put("member_image", "/");
			service.insertQuestion(paramMap);
			System.out.println("파일 첨부 없음 1");
			result = 1; 
		}
		System.out.println("service result: " +result);
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "/deletemyqstService")
	public int deletemyqstService(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap, ModelMap model) throws Exception {
		System.out.println("deletemyqstService {}:  " + paramMap);
		
		int deletechk = 0;
		
		if("D".equals(paramMap.get("status")) && paramMap.containsKey("qst_index")) {
			deletechk = service.deleteQuestion(paramMap);
			System.out.println(paramMap);
			System.out.println("삭제됨 " +deletechk);
			
		}
		model.addAttribute("paramMap", paramMap);
		
		return deletechk;
	}
	
	@RequestMapping(value = "/godeletepage")
	public String godeletepage(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("deletepage {}:  " + paramMap);
		
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("reviewCnt", service.reviewCount(paramMap));
		model.addAttribute("zzimCnt", service.myzzimCount(paramMap));
		model.addAttribute("orderCnt", service.totalorderCnt(paramMap));
		model.addAttribute("mileCal", service.showalldata(paramMap));
		model.addAttribute("memInfo",service.getMemInfo(paramMap));
		
		return "/login/delete";
	}

	@ResponseBody
	@RequestMapping(value = "/deletemyaccount")
	public int deletemyaccount(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("deletemyaccount11 {}:  " + paramMap);
		int pwRechk = 0;
		
		if("D".equals(paramMap.get("status")) && paramMap.containsKey("recheck_pw")) {
			paramMap.put("member_pw", paramMap.get("recheck_pw"));
			pwRechk = loginService.memberloginChk(paramMap);
			System.out.println("찾는다 숫자: "+pwRechk);
			if(pwRechk > 0) {
				service.deletemyaccount(paramMap);
			}
		}
		model.addAttribute("paramMap", paramMap);
		
		return pwRechk;
	}
	
	@RequestMapping(value = "/notice")
	public String notice(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("updatemypage {}:  " + paramMap);
		model.addAttribute("paramMap", paramMap);

		return "/login/notice";
	}

	@RequestMapping(value = "/detail")
	public String detail(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {

		System.out.println("detail here22:: " + paramMap);
		int orderchk = service.orderdupchk(paramMap);
		int status = service.dupCheck(paramMap);
		model.addAttribute("paramMap", paramMap);
		model.addAttribute("status", status);
		model.addAttribute("heartCnt", service.heartCount(paramMap));
		model.addAttribute("heartChk", service.heartChk(paramMap));
		model.addAttribute("bookList", bookService.bookList(paramMap));
		model.addAttribute("likedlist", bookService.booklikeUsers(paramMap));
		model.addAttribute("bookInfo", bookService.bookDetail(paramMap));
		model.addAttribute("zzimCnt", service.zzimChk(paramMap));
		model.addAttribute("emotag", service.emotagList(paramMap));
		model.addAttribute("bookScore", bookService.bookScore(paramMap));
		model.addAttribute("orderchk", orderchk);
		model.addAttribute("relbookList", bookService.relatedBookList(paramMap));
		model.addAttribute("reviewallList",basicService.reviewallList(paramMap));
		
		return "/main/detail";
	}

	@ResponseBody
	@RequestMapping(value = "/setdetailInfo")
	public int setdetailInfo(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("paramMap"+ paramMap);
		int mytagdupchk = service.myemotagdupchk(paramMap);
		
		int emotagChk = 0;
		if("I".equals(paramMap.get("status")) && paramMap.containsKey("emo_tag")) {
			if(mytagdupchk == 0) {
				service.insertEmotag(paramMap);
				emotagChk = 1;
				System.out.println("감성 태그 추가됨");
			}else {
				emotagChk = 0;
			}
		}
		
		if("D".equals(paramMap.get("status")) && paramMap.containsKey("member_name")) {
			service.deleteEmotag(paramMap);
			System.out.println("감성 태그 삭제됨");
				emotagChk = 2;
		}
		System.out.println("해시태그 결과: " + emotagChk);
		return emotagChk;
	}
	
	@RequestMapping(value = "/paycheck.do")
	public String paycheck(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap, ModelMap model) throws Exception {
		System.out.println("paycheck:: " + paramMap);
		model.addAttribute("paramMap", paramMap);
		String[] arr = req.getParameterValues("chkbox");
		
		List<String> chkArray = new ArrayList<String>();
		List<Object> bookArr = new ArrayList<Object>();
		
		if(arr == null) {
			bookArr.add(bookService.bookDetail(paramMap));
			model.addAttribute("bookList", bookArr);
		} else {
			for (String chks : arr) {
				paramMap.put("book_id", chks);
				chkArray.add(chks);
				bookArr.add(bookService.bookDetail(paramMap));
			}
			
			paramMap.put("orderList", chkArray);
			int chk = service.orderCntCheck(paramMap);
			model.addAttribute("orderChk", chk);
			System.out.println("여러개의 책을 구입함: 몇개? " +chk);
			model.addAttribute("bookList", bookArr);
		}
		model.addAttribute("orderNum", basicService.orderAutonum(paramMap));
		model.addAttribute("userinfo", service.getMemInfo(paramMap));	
		model.addAttribute("shipmsg", basicService.shipMsg(paramMap));
		model.addAttribute("cpnList", basicService.disCpn(paramMap));
		model.addAttribute("saleList", bookService.salebookList(paramMap));
		
		return "/main/payment";
	}

	@ResponseBody
	@RequestMapping(value = "/setOrderitem.do")
	public HashMap<String, Object> setOrderitem(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap, ModelMap model) throws Exception {
		System.out.println("setOrderitem11:: " + paramMap);
		HashMap rsMap = new HashMap();
		paramMap.put("member_name", paramMap.get("order_name"));
		model.addAttribute("paramMap", paramMap);
		
		if("I".equals(paramMap.get("status")) && paramMap.containsKey("status")) {
			String [] chks =req.getParameterValues("book_id"); 
				for(String array : chks) {
					paramMap.put("book_id", array); 
					service.insertOrder(paramMap);
				} 
				service.savemymile(paramMap);
		 }
		rsMap.put("paramMap", paramMap);
		return rsMap;
	}

	@ResponseBody
	@RequestMapping(value = "/heartCheck.do")
	public HashMap<String, Object> heartCheck(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("here:: " + paramMap);
		HashMap rsMap = new HashMap();
		
		paramMap.put("member_id", service.getMemInfo(paramMap).get("member_id"));

		int status = service.dupCheck(paramMap);

		if (status == 0 && "I".equals(paramMap.get("dup_chk")) && paramMap.containsKey("member_id")) {
			service.heartInsert(paramMap);
		}
		if (status > 0 && "U".equals(paramMap.get("dup_chk")) && paramMap.containsKey("member_id")) {
			service.heartUpdate(paramMap);
		}
		rsMap.put("paramMap", paramMap);
		rsMap.put("loveChk", service.heartCount(paramMap));

		System.out.println(service.heartCount(paramMap));
		return rsMap;
	}

	@ResponseBody
	@RequestMapping(value = "/mypageInfo")
	public HashMap<String, Object> mypageInfo(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			ModelMap model) throws Exception {
		System.out.println("mypageInfo {}:  " + paramMap);
		HashMap rsMap = new HashMap();
		paramMap.put("member_id", service.getMemInfo(paramMap).get("member_id"));
		int zzimCnt = service.zzimChk(paramMap);
		model.addAttribute("zzimCnt", service.zzimChk(paramMap));

		if ("I".equals(paramMap.get("dup_chk")) && paramMap.containsKey("member_name")) {
			service.zzimInsert(paramMap);
		}

		if ("U".equals(paramMap.get("dup_chk")) && paramMap.containsKey("member_name")) {
			service.zzimUpdate(paramMap);
		}
		rsMap.put("paramMap", paramMap);
		
		return rsMap;
	}

	@ResponseBody
	@RequestMapping(value = "/setmypageInfo")
	public HashMap<String, Object> setmypageInfo(HttpServletRequest req, HttpServletResponse res, @RequestParam HashMap paramMap,
			@RequestParam(value = "chk_array[]") List<String> chkArr, ModelMap model) throws Exception {
		System.out.println("setmypageInfo {}:  " + paramMap);

		HashMap rsMap = new HashMap();
		paramMap.put("member_id", service.getMemInfo(paramMap).get("member_id"));

		if ("D".equals(paramMap.get("status")) && paramMap.containsKey("status")) {
			paramMap.put("zzimList", chkArr);
			service.zzimDelete(paramMap);
		}
		if ("R".equals(paramMap.get("status")) && paramMap.containsKey("status")) {
			paramMap.put("orderList", chkArr);
			rsMap.put("ordernumchk", service.orderCntCheck(paramMap));
		}
		
		rsMap.put("paramMap", paramMap);

		return rsMap;
	}
}
