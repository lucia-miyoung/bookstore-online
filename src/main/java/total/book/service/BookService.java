package total.book.service;

import java.util.HashMap;
import java.util.List;

public interface BookService {
	
	public List relatedBookList(HashMap paramMap) throws Exception;
	
	public List salebookList(HashMap paramMap) throws Exception;

	public List bookAllList(HashMap paramMap) throws Exception;
	
	public HashMap bookScore(HashMap paramMap) throws Exception;
	
	public List bookList(HashMap paramMap) throws Exception;
	
	public int bookListCount(HashMap paramMap) throws Exception;
	
	public HashMap bookDetail(HashMap paramMap) throws Exception;
	
	public List booklikeUsers(HashMap paramMap) throws Exception;
	
}
