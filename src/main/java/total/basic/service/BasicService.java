package total.basic.service;

import java.util.HashMap;
import java.util.List;

public interface BasicService {
	
	public int updateqstdetail(HashMap paramMap) throws Exception;
	
	public HashMap<String,Object> qstdetail(HashMap paramMap) throws Exception;
	
	public List qstTotalList(HashMap paramMap) throws Exception;
	
	public int qstTotalListCnt(HashMap paramMap) throws Exception;
	
	public List reviewallList(HashMap paramMap) throws Exception;
	
	public int orderAutonum(HashMap paramMap) throws Exception;

	public List shipMsg(HashMap paramMap) throws Exception;
	
	public List disCpn(HashMap paramMap) throws Exception;
}
