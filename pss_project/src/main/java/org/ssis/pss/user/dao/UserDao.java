package org.ssis.pss.user.dao;

import java.util.List;

import org.springframework.stereotype.Repository;
import org.ssis.pss.cmn.dao.CmnSupportDAO;
import org.ssis.pss.cmn.model.ZValue;

import egovframework.com.cmm.LoginVO;

@Repository
public class UserDao extends CmnSupportDAO {
	/**
	 * 아이디/패스워드 로그인
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public LoginVO userLogin(LoginVO loginVO) throws Exception {
		return (LoginVO) selectOne("user.userLogin", loginVO);
	}
	
	/**
	 * 공인인증서 로그인
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public LoginVO certLogin(ZValue zvl) throws Exception {
		return (LoginVO) selectOne("user.certLogin", zvl);
	}

	/**
	 * 사용자 정보 조회
	 * @param zvl
	 * @return zvl
	 * @throws Exception
	 */
	public ZValue userInfo(ZValue zvl) throws Exception{
		return (ZValue) selectOne("user.userInfo", zvl);
	}
	
	
	/**
	 * 공인인증서 등록
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public void certRegist(ZValue zvl) throws Exception {
		update("user.certRegist", zvl);
	}
	
	/**
	 * 사용자 정보 수정
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public void updateUser(ZValue zvl) throws Exception {
		update("user.updateUser", zvl);
	}
	
	/**
	 * 비밀번호 수정
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public void updatePass(ZValue zvl) throws Exception {
		update("user.updatePass", zvl);
	}
	
	/**
	 * 사용자 공통 리스트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public List<ZValue> userCommonList(ZValue zvl) throws Exception {
		return (List<ZValue>) selectList(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 사용자 공통 카운트
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public int userCommonCnt(ZValue zvl) throws Exception {
		return selectCnt(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 사용자 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void userCommonUpdate(ZValue zvl) throws Exception {
		update(zvl.getString("sqlid"), zvl);
	}
	
	/**
	 * 사용자 공통 업데이트
	 * @param zvl
	 * @throws Exception
	 */
	public void userCommonInsert(ZValue zvl) throws Exception {
		insert(zvl.getString("sqlid"), zvl);
	}

	/**
	 * 아이디찾기
	 * @param zvl
	 * @return
	 * @throws Exception
	 */
	public ZValue findId(ZValue zvl) throws Exception {
		return (ZValue) selectOne("user.findID", zvl);
	}

	/**
	 * 패스워드 변경 여부
	 * @param LoginVO
	 * @return LoginVO
	 * @throws Exception
	 */
	public String passwordChangeDtYN(LoginVO loginVO) throws Exception {
		return (String) selectOne("user.passwordChangeDtYN", loginVO);
	}
}
