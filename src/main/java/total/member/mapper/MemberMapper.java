package total.member.mapper;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.CommonMapper;

@Repository("MemberMapper")
public class MemberMapper extends CommonMapper{
	public List showmyQstList(HashMap paramMap) {
		return sss.selectList("MemberMapper.showmyQstList", paramMap);
	}
	public int insertQuestion(HashMap paramMap) {
		return sss.insert("MemberMapper.insertQuestion", paramMap);
	}
	public int deleteQuestion(HashMap paramMap) {
		return sss.delete("MemberMapper.deleteQuestion", paramMap);
	}
	public int totalorderCnt(HashMap paramMap) {
		return sss.selectOne("MemberMapper.totalorderCnt", paramMap);
	}
	public int imgNameDupchk(HashMap paramMap) {
		return sss.selectOne("MemberMapper.imgNameDupchk", paramMap);
	}
	public int deletemyaccount(HashMap paramMap) {
		return sss.delete("MemberMapper.deletemyaccount", paramMap);
	}
	public int updatemyinfo(HashMap paramMap) {
		return sss.update("MemberMapper.updatemyinfo", paramMap);
	}
	public HashMap<String, Object> getMemInfo(HashMap paramMap) {
		return sssSelectMap("MemberMapper.getMemInfo", paramMap);
	}
	public int myzzimCount(HashMap paramMap) {
		return sss.selectOne("MemberMapper.myzzimCount", paramMap);
	}
	public int myheartCount(HashMap paramMap) {
		return sss.selectOne("MemberMapper.myheartCount", paramMap);
	}
	public int dupCheck(HashMap paramMap) {
		return sss.selectOne("MemberMapper.dupCheck", paramMap);
	}
	public int heartCount(HashMap paramMap) {
		return sss.selectOne("MemberMapper.heartCount", paramMap);	
	}
	public HashMap heartChk(HashMap paramMap) {
		return sssSelectMap("MemberMapper.heartChk", paramMap);
	}
	public int heartUpdate(HashMap paramMap) {
		return sss.update("MemberMapper.heartUpdate", paramMap);
	}
	public int heartInsert(HashMap paramMap) {
		return sss.insert("MemberMapper.heartInsert", paramMap);
	}
	public List emotagList(HashMap paramMap) {
		return sss.selectList("MemberMapper.emotagList", paramMap);
	}
	public int deleteEmotag(HashMap paramMap) {
		return sss.delete("MemberMapper.deleteEmotag", paramMap);
	}
	public int insertEmotag(HashMap paramMap) {
		return sss.insert("MemberMapper.insertEmotag", paramMap);
	}
	public int myemotagdupchk(HashMap paramMap) {
		return sss.selectOne("MemberMapper.myemotagdupchk",paramMap);
	}
	public List zzimList(HashMap paramMap) {
		return sss.selectList("MemberMapper.zzimList", paramMap);
	}
	public int zzimInsert(HashMap paramMap) {
		return sss.insert("MemberMapper.zzimInsert", paramMap);
	}
	public int zzimUpdate(HashMap paramMap) {
		return sss.update("MemberMapper.zzimUpdate", paramMap);
	}
	public int zzimChk(HashMap paramMap) {
		return sss.selectOne("MemberMapper.zzimChk", paramMap);
	}
	public int zzimDelete(HashMap paramMap) {
		return sss.delete("MemberMapper.zzimDelete", paramMap);
	}
	public int insertReview(HashMap paramMap) {
		return sss.insert("MemberMapper.insertReview", paramMap);
	}
	public int reviewCount(HashMap paramMap) {
		return sss.selectOne("MemberMapper.reviewCount", paramMap);
	}
	public int reviewdupChk(HashMap paramMap) {
		return sss.selectOne("MemberMapper.reviewdupChk", paramMap);
	}
	public List reviewListall(HashMap paramMap) {
		return sss.selectList("MemberMapper.reviewListall", paramMap);
	}
	public List reviewList(HashMap paramMap) {
		return sss.selectList("MemberMapper.reviewList", paramMap);
	}
	public List orderList(HashMap paramMap) {
		return sss.selectList("MemberMapper.orderList", paramMap);
	}
	public int orderdupchk(HashMap paramMap) {
		return sss.selectOne("MemberMapper.orderdupchk", paramMap);
	}
	public int orderListCnt(HashMap paramMap) {
		return sss.selectOne("MemberMapper.orderListCnt", paramMap);
	}
	public int orderCntCheck(HashMap paramMap) {
		return sss.selectOne("MemberMapper.orderCntCheck", paramMap);
	}
	public int deleteReview(HashMap paramMap) {
		return sss.delete("MemberMapper.deleteReview", paramMap);
	}
	public int insertOrder(HashMap paramMap) {
		return sss.insert("MemberMapper.insertOrder", paramMap);
	}
	public int savemymile(HashMap paramMap) {
		return sss.update("MemberMapper.savemymile", paramMap);
	}
	public HashMap<String, Object> showalldata(HashMap paramMap) {
		return sssSelectMap("MemberMapper.showalldata", paramMap);
	}
}
