package com.nadri.common;


public class Search {
	
	///Field
	private int curruntPage ;
	private String searchCondition ;
	private String searchKeyword ;
	private int pageSize ;
	private int endRowNum ;
	private int startRowNum ;

	private int searchSpot;
	private int memberFlag; //회원과 비회원일 때 게시물 목록 불러오는 조건이 달라서 추가함 HJS
	private String userId; // 마이페이지 스케쥴 가져올때 나 자신의 스케쥴만 가져오기위해서 추가함 HJA
	
	///Constructor method
	public Search() {
	}

	///Method
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public int getCurrentPage() {
		return curruntPage;
	}
	
	public void setCurrentPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public String getSearchCondition() {
		return searchCondition;
	}
	
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}
	
	public String getSearchKeyword() {
		return searchKeyword;
	}
	
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}
	
	public int getSearchSpot() {
		return searchSpot;
	}

	public int getCurruntPage() {
		return curruntPage;
	}

	public void setCurruntPage(int curruntPage) {
		this.curruntPage = curruntPage;
	}

	public void setSearchSpot(int searchSpot) {
		this.searchSpot = searchSpot;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}

	//==> Select Query 시 ROWNUM 마지막 값 
	public int getEndRowNum() {
		return endRowNum;
	}
	//==> Select Query 시 ROWNUM 시작 값
	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getMemberFlag() {
		return memberFlag;
	}

	public void setMemberFlag(int memberFlag) {
		this.memberFlag = memberFlag;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return "Search [curruntPage=" + curruntPage + ", searchCondition=" + searchCondition + ", searchKeyword="
				+ searchKeyword + ", pageSize=" + pageSize + ", endRowNum=" + endRowNum + ", startRowNum=" + startRowNum
				+ ", searchSpot=" + searchSpot + ", memberFlag=" + memberFlag + ", userId=" + userId + "]";
	}
	
}