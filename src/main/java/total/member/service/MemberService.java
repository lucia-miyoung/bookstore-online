package total.member.service;

import java.util.HashMap;
import java.util.List;

public interface MemberService {
	
	public List showmyQstList(HashMap paramMap) throws Exception;
	
	public int insertQuestion(HashMap paramMap) throws Exception;
	
	public int deleteQuestion(HashMap paramMap) throws Exception;
	
	public int totalorderCnt(HashMap paramMap) throws Exception;
	
	public int imgNameDupchk(HashMap paramMap) throws Exception;
	
	public int deletemyaccount(HashMap paramMap) throws Exception;
	
	public HashMap showalldata(HashMap paramMap) throws Exception;
	
	public int savemymile(HashMap paramMap) throws Exception;
	
	public int insertOrder(HashMap paramMap) throws Exception;
	
	public List orderList(HashMap paramMap) throws Exception;
	
	public int orderListCnt(HashMap paramMap) throws Exception;
	
	public int orderdupchk(HashMap paramMap) throws Exception;
	
	public int orderCntCheck(HashMap paramMap) throws Exception;
	
	public int deleteReview(HashMap paramMap) throws Exception;
	
	public int reviewCount(HashMap paramMap) throws Exception;
	
	public int reviewdupChk(HashMap paramMap) throws Exception;
	
	public List reviewListall(HashMap paramMap) throws Exception;
	
	public List reviewList(HashMap paramMap) throws Exception;
	
	public int insertReview(HashMap paramMap) throws Exception;
	
	public int updatemyinfo(HashMap paramMap) throws Exception;
	
	public HashMap getMemInfo(HashMap paramMap) throws Exception;
	
	public int myzzimCount(HashMap paramMap) throws Exception;
	
	public int myheartCount(HashMap paramMap) throws Exception;
	
	public int dupCheck(HashMap paramMap) throws Exception;
	
	public int heartCount(HashMap paramMap) throws Exception;
	
	public HashMap heartChk(HashMap paramMap) throws Exception; 
	
	public int heartUpdate(HashMap paramMap) throws Exception;
	
	public int heartInsert(HashMap paramMap) throws Exception;
	
	public List emotagList(HashMap paramMap) throws Exception;
	
	public int deleteEmotag(HashMap paramMap) throws Exception;
	
	public int insertEmotag(HashMap paramMap) throws Exception;
	
	public int myemotagdupchk(HashMap paramMap) throws Exception;
	
	public List zzimList(HashMap paramMap) throws Exception;
	
	public int zzimInsert(HashMap paramMap) throws Exception;
	
	public int zzimUpdate(HashMap paramMap) throws Exception;
	
	public int zzimChk(HashMap paramMap) throws Exception;
	
	public int zzimDelete(HashMap paramMap) throws Exception;
	
}
