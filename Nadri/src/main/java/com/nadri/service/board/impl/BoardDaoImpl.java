package com.nadri.service.board.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.board.BoardDao;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Friend;

@Repository("boardDaoImpl")
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BoardDaoImpl() {
	}
	
	//�Խù�
	public void addBoard(Board board) throws Exception{
		sqlSession.insert("BoardMapper.insertBoard", board);
	}

	public void updateBoard(Board board) throws Exception {
		sqlSession.update("BoardMapper.updateBoard", board);
	}

	public Board getBoard(int boardNo) throws Exception {
		return sqlSession.selectOne("BoardMapper.getBoard", boardNo);
	}

	public List<Board> getBoardList(Search search, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		if( search.getMemberFlag()==1 ) { //ȸ���� ���
			map.put("userId", userId);
			
			List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
			List<String> friendId = new ArrayList<String>();
			for( int i=0; i<friend.size(); i++ ) {
				//Friend VO �� userId �� ���ִ���, friendId �� ���ִ��� Ȯ��
				if( friend.get(i).getUserId()==null ) {
					friendId.add( friend.get(i).getFriendId() );
				}else {
					friendId.add( friend.get(i).getUserId() );
				}				
			}
			map.put("list", friendId);
		}
		
		return sqlSession.selectList("BoardMapper.getBoardList", map);
	}

	public void deleteBoard(int boardNo) throws Exception {
		sqlSession.delete("BoardMapper.deleteBoard", boardNo);
	}
	
	//���ƿ�
	public int getLikeCount(int boardNo) throws Exception{
		return sqlSession.selectOne("BoardMapper.getLikeCount", boardNo);
	}
	
	public int getLikeFlag(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.getLikeFlag", map);
	}
	
	public void addLike(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		sqlSession.insert("BoardMapper.insertLike", map);
	}

	public void deleteLike(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		sqlSession.delete("BoardMapper.deleteLike", map);
	}

	//���������� �ۼ��� �ۺ���
	public List<Board> getMyBoardList(String userId) throws Exception{
		return sqlSession.selectList("BoardMapper.getMyBoardList", userId);
	}

	public int checkBoard(int boardCode, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.checkBoard", map);
	}
	
	//����ȭ�� ��õ�Խù� (��ȸ��)
	public List<Board> getRecomBoard(Search search) throws Exception{
		return sqlSession.selectList("BoardMapper.getRecomBoard", search);
	}
	
	//����ȭ�� ��õ�Խù� (ȸ��/ģ�����ƿ�)
	public List<Board> getRecomUserLike(Search search, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
			
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
		List<String> friendId = new ArrayList<String>();
		for( int i=0; i<friend.size(); i++ ) {
			friendId.add( friend.get(i).getUserId() );
		}
		map.put("list", friendId);
		
		return sqlSession.selectList("BoardMapper.getRecomUserLike", map);
	}
	
	//����ȭ�� ��õ�Խù� (ȸ��/�ۼ���)
	public List<Board> getRecomUserBoard(Search search, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
		List<String> friendId = new ArrayList<String>();
		for( int i=0; i<friend.size(); i++ ) {
			friendId.add( friend.get(i).getUserId() );
		}
		map.put("list", friendId);
		
		return sqlSession.selectList("BoardMapper.getRecomUserBoard", map);
	}
	
	//����
	@Override
	public int getMyCount(String keyword, String userId) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.getMyCount", map);
	}
}
