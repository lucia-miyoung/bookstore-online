package total.basic.mapper;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import common.CommonMapper;

@Repository("BasicMapper")
public class BasicMapper extends CommonMapper {

	public int updateqstdetail(HashMap paramMap) {
		return sss.update("BasicMapper.updateqstdetail", paramMap);
	}
	public HashMap<String,Object> qstdetail(HashMap paramMap) {
		return sssSelectMap("BasicMapper.qstdetail", paramMap);
	}
	public List qstTotalList(HashMap paramMap) {
		return sss.selectList("BasicMapper.qstTotalList", paramMap);
	}
	public int qstTotalListCnt(HashMap paramMap) {
		return sss.selectOne("BasicMapper.qstTotalListCnt", paramMap);
	}
	public List reviewallList(HashMap paramMap) {
		return sss.selectList("BasicMapper.reviewallList", paramMap);
	}
	public int orderAutonum(HashMap paramMap) {
		return sss.selectOne("BasicMapper.orderAutonum", paramMap);
	}
	public List shipMsg(HashMap paramMap) {
		return sss.selectList("BasicMapper.shipMsg", paramMap);
	}
	public List disCpn(HashMap paramMap) {
		return sss.selectList("BasicMapper.disCpn", paramMap);
	}
	
}
