package com.nadri.service.board;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Board;

public interface BoardService {
	
	//�Խù�
	public void addBoard(Board board) throws Exception;
	
	public void updateBoard(Board board) throws Exception;
	
	public Board getBoard(int boardNo) throws Exception;
	
	public List<Board> getBoardList(Search search) throws Exception;
	
	public void deleteBoard(int boardNo) throws Exception;
	
	//���ƿ�
	public int getLikeCount(int boardNo) throws Exception;
	
	public int getLikeFlag(int boardNo, String userId) throws Exception;
	
	public void addLike(int boardNo, String userId) throws Exception;
	
	public void deleteLike(int boardNo, String userId) throws Exception;

	//���������� �ۼ��� �ۺ���
	public List<Board> getMyBoardList(String userId) throws Exception;

	public int checkBoard(int boardCode, String userId) throws Exception;
	
	//����ȭ�� ��õ�Խù�
	public List<Board> getRecomBoard(Search search) throws Exception;
	
	//����
	public int getMyCount(String keyword, String userId) throws Exception;
}