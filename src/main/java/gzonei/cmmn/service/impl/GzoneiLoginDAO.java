package gzonei.cmmn.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.service.impl.EgovComAbstractDAO;
import egovframework.rte.psl.dataaccess.util.EgovMap;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 DAO 클래스
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
@Repository("gzoneiLoginDAO")
public class GzoneiLoginDAO extends EgovComAbstractDAO {

    /**
     * 2011.08.26
	 * EsntlId를 이용한 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovMap actionLoginByEsntlId(EgovMap vo) throws Exception {
    	return (EgovMap)selectOne("gzoneiLoginDAO.ssoLoginByEsntlId", vo);
    }

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovMap actionLogin(EgovMap vo) throws Exception {
    	return (EgovMap)selectOne("gzoneiLoginDAO.actionLogin", vo);
    }

    /**
	 * 인증서 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovMap actionCrtfctLogin(EgovMap vo) throws Exception {

    	return (EgovMap)selectOne("gzoneiLoginDAO.actionCrtfctLogin", vo);
    }

    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovMap searchId(EgovMap vo) throws Exception {

    	return (EgovMap)selectOne("gzoneiLoginDAO.searchId", vo);
    }

    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public EgovMap searchPassword(EgovMap vo) throws Exception {

    	return (EgovMap)selectOne("gzoneiLoginDAO.searchPassword", vo);
    }

    /**
	 * 변경된 비밀번호를 저장한다.
	 * @param vo LoginVO
	 * @exception Exception
	 */
    public void updatePassword(EgovMap vo) throws Exception {
    	update("gzoneiLoginDAO.updatePassword", vo);
    }
    
    
    /**
	 * 로그인인증제한 내역을 조회한다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
	public EgovMap selectLoginIncorrect(EgovMap vo) throws Exception {
    	return (EgovMap)selectOne("gzoneiLoginDAO.selectLoginIncorrect", vo);
    }

    /**
	 * 로그인인증제한 내역을 업데이트 한다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public void updateLoginIncorrect(EgovMap map) throws Exception {
    	update("gzoneiLoginDAO.updateLoginIncorrect", map);
    }
    
    /**
     * 로그인 이력 등록
     * @param map
     * @throws Exception
     */
    public void insertLoginHist(EgovMap map) throws Exception{
    	insert("gzoneiLoginDAO.insertLoginHist", map);
    }
    
    /**
     * 패널티 조회
     * @param vo
     * @return
     * @throws Exception
     */
    public EgovMap selectPenalty(EgovMap vo) throws Exception{
    	return (EgovMap)selectOne("gzoneiLoginDAO.selectPenalty", vo);
    }
    
    /**
     * 로그인 이력 등록
     * @param map
     * @throws Exception
     */
    public void insertPenalty(EgovMap map) throws Exception{
    	insert("gzoneiLoginDAO.insertPenalty", map);
    }
    
    
    /**
     * 로그인 이력 조회 (개인)
     * @param vo
     * @return
     * @throws Exception
     */
    public EgovMap selectLoginLog(EgovMap vo) throws Exception{
    	return (EgovMap)selectOne("gzoneiLoginDAO.selectLoginLog", vo);
    }
    
    /**
     * 로그인 이력 조회 (법인)
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectLoginCount(EgovMap vo) throws Exception{
    	return (int)selectOne("gzoneiLoginDAO.selectLoginCount",vo);
    }
    
    /**
     * 로그아웃시 로그아웃 시간 업데이트
     * @param vo
     * @return
     * @throws Exception
     */
    public void updateLoginLog(EgovMap vo) throws Exception{
    	update("gzoneiLoginDAO.updateLoginLog",vo);
    }

}
