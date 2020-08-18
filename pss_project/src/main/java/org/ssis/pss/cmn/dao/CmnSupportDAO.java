package org.ssis.pss.cmn.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;

public class CmnSupportDAO {
	
	protected Log log = LogFactory.getLog(this.getClass());
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public Object insert(String queryId, Object parameterObject) {
		return sqlSession.insert(queryId, parameterObject);
	}

	public Object update(String queryId, Object parameterObject) {
		return sqlSession.update(queryId, parameterObject);
	}

	public Object delete(String queryId, Object parameterObject) {
		return sqlSession.delete(queryId, parameterObject);
	}

	public Object selectOne(String queryId, Object parameterObject) {
		return sqlSession.selectOne(queryId, parameterObject);
	}
	
	public String selectString(String queryId, Object parameterObject) {
		return sqlSession.selectOne(queryId, parameterObject);
	}
	
	public Object selectOne(String queryId) {
		return sqlSession.selectOne(queryId);
	}
	
	public int selectCnt(String queryId, Object parameterObject) {
		return sqlSession.selectOne(queryId, parameterObject);
	}
	
	public int selectCnt(String queryId) {
		return sqlSession.selectOne(queryId);
	}
	
	public List<?> selectList(String queryId) {
		return sqlSession.selectList(queryId);
	}
	
	public List<?> selectList(String queryId, Object parameterObject) {
		return sqlSession.selectList(queryId, parameterObject);
	}
}
