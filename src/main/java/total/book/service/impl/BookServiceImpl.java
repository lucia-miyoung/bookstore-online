package total.book.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import total.book.mapper.BookMapper;
import total.book.service.BookService;

@Service("BookService")
public class BookServiceImpl implements BookService {
	
	@Autowired
	private BookMapper mapper;

	@Override
	public List relatedBookList(HashMap paramMap) throws Exception {
		return mapper.relatedBookList(paramMap);
	}
	
	@Override
	public List salebookList(HashMap paramMap) throws Exception {
		return mapper.salebookList(paramMap);
	}
	
	@Override
	public List bookAllList(HashMap paramMap) throws Exception {
		return mapper.bookAllList(paramMap);
	}
	
	@Override
	public HashMap bookScore(HashMap paramMap) throws Exception {
		return mapper.bookScore(paramMap);
	}
	
	@Override
	public List bookList(HashMap paramMap) throws Exception {
		return mapper.bookList(paramMap);
	}
	
	@Override
	public int bookListCount(HashMap paramMap) throws Exception {
		return mapper.bookListCount(paramMap);
	}
	
	@Override
	public HashMap bookDetail(HashMap paramMap) throws Exception {
		return mapper.bookDetail(paramMap);
	}
	
	@Override
	public List booklikeUsers(HashMap paramMap) throws Exception { 
		return mapper.booklikeUsers(paramMap);
	}
	
}
