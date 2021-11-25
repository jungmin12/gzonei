package gzonei.cmmn.service;

import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 인터페이스 클래스
 * @author 공통서비스 개발팀 박지욱
 * @since 2009.03.06
 * @version 1.0
 * @see
 *  
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2009.03.06  박지욱          최초 생성 
 *  2011.08.26  서준식          EsntlId를 이용한 로그인 추가
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
public interface GzoneiLoginService {
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	EgovMap actionLogin(EgovMap vo) throws Exception;
    
    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	EgovMap searchId(EgovMap vo) throws Exception;
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return EgovMap
	 * @exception Exception
	 */
	EgovMap searchPassword(EgovMap vo) throws Exception;
    
    
    /**
	 * 로그인인증제한을 처리한다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    String processLoginIncorrect(EgovMap vo, EgovMap mapLockUserInfo) throws Exception;
    
    /**
	 * 로그인인증제한을 조회한다.
	 * @param vo LoginVO
	 * @param Map mapLockUserInfo
	 * @return boolean
	 * @exception Exception
	 */
    EgovMap selectLoginIncorrect(EgovMap vo) throws Exception;
    
    
    /**
     * 로그인 이력을 등록한다.
     * @param vo
     * @throws Exception
     */
    void insertLoginHist(EgovMap vo) throws Exception;
    
    /**
     * 패널티를 조회한다.
     * @param vo
     * @return
     * @throws Exception
     */
    EgovMap selectPenalty(EgovMap vo) throws Exception;
    
    
    /**
     * 패널티를 등록한다.
     * @param vo
     * @throws Exception
     */
    void insertPenalty(EgovMap vo) throws Exception;
    
    /**
     * 최근 접속 이력 조회 (개인)
     * @param vo
     * @return
     * @throws Exception
     */
    EgovMap selectLoginLog(EgovMap vo) throws Exception;
    
    /**
     * 최근 접속 이력 조회 (법인)
     * @param vo
     * @return
     * @throws Exception
     */
    int selectLoginCount(EgovMap vo) throws Exception;
    
    /**
     * 로그아웃시 로그아웃 시간 업데이트
     * @param vo
     * @return
     * @throws Exception
     */
    void updateLoginLog(EgovMap vo) throws Exception;
    
    EgovMap checkLogin(EgovMap vo) throws Exception;

}
