package common;

import java.util.HashMap;

import org.springframework.stereotype.Service;

@Service("pageUtil")
public class PageUtil {
	
	private int listCnt; // 전체 게시물의 개수 listCnt
	private int listSize; //한페이지에 보여지는 목록(행) 수
	private int range; // 한 페이지 시작하는 범위
	private int rangeSize; //한 페이지에 보여지는 페이지 번호 초깃값 5개
	private int pageCnt; // 전체 페이지 범위의 개수 (ex: 총 14개면 페이지 2개) 
	private int page; // 현재 페이지 번호 
	private int startPage; //각 페이지 범위 시작 번호
	private int endPage; // 각 페이지 범위 끝 번호
	private int rowNum;
	private boolean prev; // 이전 페이지 여부
	private boolean next; //다음 페이지 여부
	

	public int getPage() {
		return page;
	}
	public void setPage(HashMap paramMap) {
		this.page = Integer.parseInt(String.valueOf(paramMap.get("currPage")));
		this.listCnt = Integer.parseInt(String.valueOf(paramMap.get("listCnt")));
		this.listSize = 10; //한 페이지에 보이는 행의 수 (10개)
		this.rangeSize = 5; // 한 페이지에 보이는 페이지 수 (5개로 셋팅) 실제가 7개여도 일단 5개까지 보임 
		
		/* 
		 * 전체 페이지 수
		 * 게시물 총 갯수(14개) / 한 페이지에 행 수(10) = (1.4) 올림 : 2개!!
		 */
		
		
		//페이지 1 > 0, 2 > 10, 3 > 20, 4> 30
		this.range = (page - 1) * this.listSize;
		
		//실제 페이지 수
		this.pageCnt = (int) Math.ceil((double)listCnt/listSize); 
		
		//화면에 보여지는 페이지 수 1~5/6~10/11~15 5개씩 자르기
		this.endPage = (int) (Math.ceil((double)page/this.rangeSize) * this.rangeSize);
		
		this.startPage = this.endPage - (this.rangeSize-1);
		
		
		//실제 페이지(7개)면 10개가 아니라 7개까지 보이기!
		if(pageCnt < this.endPage) {
			this.endPage = pageCnt;
		}
		
		this.rowNum = listCnt - ((this.page-1) * this.listSize);
		
		paramMap.put("currPage", page);
		paramMap.put("range", range);
		paramMap.put("listSize", listSize);

		
		//이전 버튼 상태
		this.prev = this.startPage > 1;
		
		this.next = this.endPage < pageCnt;
		
	}

	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getListSize() {
		return listSize;
	}
	public void setListSize(int listSize) {
		this.listSize = listSize;
	}
	public int getListCnt() {
		return listCnt;
	}
	public void setListCnt(int listCnt) {
		this.listCnt = listCnt;
	}
	public int getPageCnt() {
		return pageCnt;
	}
	public void setPageCnt(int pageCnt) {
		this.pageCnt = pageCnt;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRowNum() {
		return rowNum;
	}
	public void setRowNum(int rowNum) {
		this.rowNum = rowNum;
	}
	public int getRangeSize() {
		return rangeSize;
	}
	public void setRangeSize(int rangeSize) {
		this.rangeSize = rangeSize;
	}


}
