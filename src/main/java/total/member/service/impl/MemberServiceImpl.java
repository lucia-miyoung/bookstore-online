package total.member.service.impl;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.EncryptUtil;
import total.member.mapper.MemberMapper;
import total.member.service.MemberService;

@Service("MemberService")
public class MemberServiceImpl implements MemberService {
	
	private static final Logger log = LoggerFactory.getLogger(MemberServiceImpl.class);

	@Autowired
	private MemberMapper mapper;
	
	@Override
	public List showmyQstList(HashMap paramMap) throws Exception {
		return mapper.showmyQstList(paramMap);
	}
	@Override
	public int insertQuestion(HashMap paramMap) throws Exception {
		return mapper.insertQuestion(paramMap);
	}
	@Override
	public int deleteQuestion(HashMap paramMap) throws Exception {
		return mapper.deleteQuestion(paramMap);
	}
	@Override
	public int totalorderCnt(HashMap paramMap) throws Exception{
		return mapper.totalorderCnt(paramMap);
	}
	@Override
	public int imgNameDupchk(HashMap paramMap) throws Exception {
		return mapper.imgNameDupchk(paramMap);
	}
	@Override
	public int deletemyaccount(HashMap paramMap) throws Exception {
		return mapper.deletemyaccount(paramMap);
	}
	@Override 
	public HashMap showalldata(HashMap paramMap) throws Exception {
		return mapper.showalldata(paramMap);
	}
	@Override
	public int savemymile(HashMap paramMap) throws Exception {
		return mapper.savemymile(paramMap);
	}
	@Override
	public int insertOrder(HashMap paramMap) throws Exception {
		return mapper.insertOrder(paramMap);
	}
	@Override 
	public List orderList(HashMap paramMap) throws Exception {
		return mapper.orderList(paramMap);
	}
	
	@Override
	public int orderListCnt(HashMap paramMap) throws Exception {
		return mapper.orderListCnt(paramMap);
	}
	@Override
	public int orderdupchk(HashMap paramMap) throws Exception {
		return mapper.orderdupchk(paramMap);
	}
	@Override
	public int orderCntCheck(HashMap paramMap) throws Exception {
		return mapper.orderCntCheck(paramMap);
	}
	@Override
	public int deleteReview(HashMap paramMap) throws Exception {
		return mapper.deleteReview(paramMap);
	}
	
	@Override
	public int reviewCount(HashMap paramMap) throws Exception {
		return mapper.reviewCount(paramMap);
	}
	
	@Override
	public int reviewdupChk(HashMap paramMap) throws Exception {
		return mapper.reviewdupChk(paramMap);
	}
	
	@Override
	public List reviewListall(HashMap paramMap) throws Exception {
		return mapper.reviewListall(paramMap);
	}
	
	@Override
	public List reviewList(HashMap paramMap) throws Exception {
		return mapper.reviewList(paramMap);
	}
	
	@Override
	public int insertReview(HashMap paramMap) throws Exception {
		return mapper.insertReview(paramMap);
	}
	
	@Override
	public int updatemyinfo(HashMap paramMap) throws Exception {
		String userPW = (String) paramMap.get("member_pw");
		String userNewPW = EncryptUtil.encryptSha256(userPW);
		paramMap.put("member_new_pw", userNewPW);
		return mapper.updatemyinfo(paramMap);
	}
	
	public HashMap getMemInfo(HashMap paramMap) throws Exception {
		return mapper.getMemInfo(paramMap); 
	}
	
	@Override
	public int myheartCount(HashMap paramMap) throws Exception {
		return mapper.myheartCount(paramMap);
	}
	
	@Override
	public int myzzimCount(HashMap paramMap) throws Exception {
		return mapper.myzzimCount(paramMap);
	}

	@Override 
	public int dupCheck(HashMap paramMap) throws Exception {
		return mapper.dupCheck(paramMap);
	}
	
	@Override
	public int heartCount(HashMap paramMap) throws Exception {
		return mapper.heartCount(paramMap);
	}
	
	@Override
	public HashMap heartChk(HashMap paramMap) throws Exception {
		return mapper.heartChk(paramMap);
	}
	
	@Override
	public int heartUpdate(HashMap paramMap) throws Exception {
		return mapper.heartUpdate(paramMap);
	}
	
	@Override
	public int heartInsert(HashMap paramMap) throws Exception {
		return mapper.heartInsert(paramMap);
	}
	
	@Override
	public List emotagList(HashMap paramMap) throws Exception { 
		return mapper.emotagList(paramMap);
	}
	@Override
	public int deleteEmotag(HashMap paramMap) throws Exception {
		return mapper.deleteEmotag(paramMap);
	}
	
	@Override
	public int insertEmotag(HashMap paramMap) throws Exception {
		return mapper.insertEmotag(paramMap);
	}
	
	@Override
	public int myemotagdupchk(HashMap paramMap) throws Exception {
		return mapper.myemotagdupchk(paramMap);
	}
	@Override
	public List zzimList(HashMap paramMap) throws Exception {
		return mapper.zzimList(paramMap);
	}
	
	@Override
	public int zzimInsert(HashMap paramMap) throws Exception {
		return mapper.zzimInsert(paramMap);
	}

	@Override 
	public int zzimUpdate(HashMap paramMap) throws Exception {
		return mapper.zzimUpdate(paramMap);
	}
	
	@Override
	public int zzimChk(HashMap paramMap) throws Exception {
		return mapper.zzimChk(paramMap);
	}
	
	@Override
	public int zzimDelete(HashMap paramMap) throws Exception {
		return mapper.zzimDelete(paramMap);
	}
	
}
