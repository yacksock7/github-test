package com.example.service;

import org.springframework.stereotype.Service;

public class Paging {
	//페이지당 게시물 수 
	public static final int PAGE_SCALE = 10;
	//화면당 페이지 수 
	public static final int BLOCK_SCALE = 10;
	private int curPage; 	//현재페이지 
	private int prevPage;	//이전페이지 
	private int nextPage;	//다음페이지	
	private int totPage; 	//전체 페이지 갯수 
	private int totBlock;	//전체 페이지 블록 갯수 
	private int curBlock;	//현재 페이지 블록 	
	private int preBlock;	//이전 페이지 블록
	private int nextBlock;	//다음 페이지 블록
	
	private int pageBegin;	//#{start}
	private int pageEnd;	//#{end}
	
	// [이전] blockBegin -> 41 42 43 44 45 46 47 48 49 50 [다음]
	private int blockBegin;	//현재 페이지 블록의 시작 번호
	// [이전] 41 42 43 44 45 46 47 48 49 50 <- blockEnd [다음]
	private int blockEnd;	//현재 페이지 블록의 끝 번호 
	
	//생성자
	//Paging(레코드갯수, 현재 페이지 번호)
	public Paging(int count, int curPage, int PAGE_SCALE) {
		curBlock = 1;		// 현재 페이지 블록 번호
		this.curPage = curPage;	//현재 페이지 설정 
		setTotPage(count);	//전체 페이지 갯수 계산
		setPageRange();		//
		setTotBlock();		//전체페이지 블록 갯수 계산 
		setBlockRange();	//페이지 블록의 시작, 끝 번호 계산
		
		
		System.out.println("curPage : " + curPage);
		System.out.println("prevPage : " + prevPage);
		System.out.println("nextPage : " + nextPage);
		System.out.println("totPage : " + totPage);
		System.out.println("totBlock : " + totBlock);
		System.out.println("curBlock : " + curBlock);
		System.out.println("preBlock : " + preBlock);
		System.out.println("nextBlock : " + nextBlock);
		System.out.println("pageBegin : " + pageBegin);
		System.out.println("pageEnd : " + pageEnd);
		System.out.println("blockBegin : " + blockBegin);
		System.out.println("blockEnd : " + blockEnd);
		
		
	}
	
	public void setBlockRange() {
		curBlock = (int)Math.ceil((curPage-1) / BLOCK_SCALE)+1;
		blockBegin = (curBlock-1) * BLOCK_SCALE + 1;
		blockEnd = blockBegin + BLOCK_SCALE - 1; 
		
		if(blockEnd > totPage)	blockEnd = totPage;
		prevPage = (curBlock == 1)? 1:(curBlock - 1) * BLOCK_SCALE;
		nextPage = curBlock > totBlock ? (curBlock * BLOCK_SCALE) : (curBlock * BLOCK_SCALE) + 1; 
		if(nextPage >= totPage) nextPage = totPage;
	}
	
	public void setPageRange() {
		pageBegin = (curPage - 1 ) * PAGE_SCALE + 1;
		pageEnd = pageBegin + PAGE_SCALE - 1;
	}

	// Getter / Setter
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getPrevPage() {
		return prevPage;
	}

	public void setPrevPage(int prevPage) {
		this.prevPage = prevPage;
	}

	public int getNextPage() {
		return nextPage;
	}

	public void setNextPage(int nextPage) {
		this.nextPage = nextPage;
	}

	public int getTotPage() {
		return totPage;
	}

	public void setTotPage(int count) {
		this.totPage = (int) Math.ceil(count * 1.0 / PAGE_SCALE);
	}

	public int getTotBlock() {
		return totBlock;
	}

	public void setTotBlock() {
		this.totBlock = (int)Math.ceil(totPage / BLOCK_SCALE);
	}
	
	public int getCurBlock() {
		return curBlock;
	}

	public void setCurBlock(int curBlock) {
		this.curBlock = curBlock;
	}

	public int getPreBlock() {
		return preBlock;
	}

	public void setPreBlock(int preBlock) {
		this.preBlock = preBlock;
	}

	public int getNextBlock() {
		return nextBlock;
	}

	public void setNextBlock(int nextBlock) {
		this.nextBlock = nextBlock;
	}

	public int getPageBegin() {
		return pageBegin;
	}

	public void setPageBegin(int pageBegin) {
		this.pageBegin = pageBegin;
	}

	public int getPageEnd() {
		return pageEnd;
	}

	public void setPageEnd(int pageEnd) {
		this.pageEnd = pageEnd;
	}

	public int getBlockBegin() {
		return blockBegin;
	}

	public void setBlockBegin(int blockBegin) {
		this.blockBegin = blockBegin;
	}

	public int getBlockEnd() {
		return blockEnd;
	}

	public void setBlockEnd(int blockEnd) {
		this.blockEnd = blockEnd;
	}

	public static int getPageScale() {
		return PAGE_SCALE;
	}

	public static int getBlockScale() {
		return BLOCK_SCALE;
	}

}

