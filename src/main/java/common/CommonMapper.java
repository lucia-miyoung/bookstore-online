package common;


import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

public class CommonMapper {
	protected final Logger log = LoggerFactory.getLogger(getClass());

	/**
	 * Master 작업에 사용되는 DAO
	 * - insert, update, delete
	 */
	/*
	 * @Autowired
	 * 
	 * @Resource(name="sqlSessionMaster") protected SqlSession ssm;
	 */
	
	
	/*
	 * Slave 작업에 사용되는 DAO 
	 * - select
	 */
	@Autowired
	@Resource(name="sqlSessionTemplate")
	protected SqlSession sss;
	
	
	public HashMap sssSelectMap(String statement, Object parameter) {
		List<?> list = sss.selectList(statement, parameter);
		
		HashMap hashMap = new HashMap();
		if(list != null && list.size() > 0) {
			hashMap = (HashMap)list.get(0);
		}
		return hashMap;
	}
	

}
