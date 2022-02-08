package total.book.mapper;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import common.CommonMapper;

@Repository("BookMapper")
public class BookMapper extends CommonMapper{
	
	public List relatedBookList(HashMap paramMap) {
		return sss.selectList("BookMapper.relatedBookList", paramMap);
	}
	
	public List salebookList(HashMap paramMap) {
		return sss.selectList("BookMapper.salebookList", paramMap);
	}
	
	public List bookAllList(HashMap paramMap) {
		return sss.selectList("BookMapper.bookAllList", paramMap);
	}
	
	public HashMap<String, Object> bookScore(HashMap paramMap) {
		return sssSelectMap("BookMapper.bookScore", paramMap);
	}
	
	public List bookList(HashMap paramMap) {
		return sss.selectList("BookMapper.bookList",paramMap);
	}
	
	public int bookListCount(HashMap paramMap) {
		return sss.selectOne("BookMapper.bookListCount", paramMap);
	}
	
	public HashMap<String, Object> bookDetail(HashMap paramMap) {
		return sssSelectMap("BookMapper.bookDetail",paramMap);
	}
	
	public List booklikeUsers(HashMap paramMap) {
		return sss.selectList("BookMapper.booklikeUsers", paramMap);
	}
	
}
