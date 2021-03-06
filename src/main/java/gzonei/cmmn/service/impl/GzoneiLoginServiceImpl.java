package gzonei.cmmn.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.com.cmm.LoginVO;
import egovframework.com.cmm.config.EgovLoginConfig;
import egovframework.com.cop.ems.service.EgovSndngMailRegistService;
import egovframework.com.cop.ems.service.SndngMailVO;
import egovframework.com.utl.fcc.service.EgovNumberUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.GzoneiLoginService;

/**
 * 일반 로그인, 인증서 로그인을 처리하는 비즈니스 구현 클래스
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
 *  2014.12.08	이기하			암호화방식 변경(EgovFileScrty.encryptPassword)
 *  2017.07.21  장동한 			로그인인증제한 작업
 *  </pre>
 */
/**
 * @author kkan2
 *
 */
@Service("gzoneiLoginService")
public class GzoneiLoginServiceImpl extends EgovAbstractServiceImpl implements GzoneiLoginService {

    @Resource(name="gzoneiLoginDAO")
    private GzoneiLoginDAO gzoneiLoginDAO;

    /** EgovSndngMailRegistService */
	@Resource(name = "sndngMailRegistService")
    private EgovSndngMailRegistService sndngMailRegistService;
	
	@Resource(name = "egovLoginConfig")
	EgovLoginConfig egovLoginConfig;


    /**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    @Override
	public EgovMap actionLogin(EgovMap vo) throws Exception {

    	// 1. 입력한 비밀번호를 암호화한다.
    	String enpassword = EgovFileScrty.encryptPassword(vo.get("password").toString(), vo.get("id").toString());
    	vo.put("password", enpassword);

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	EgovMap loginVO = gzoneiLoginDAO.actionLogin(vo);

    	// 3. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.get("id").equals("") && !loginVO.get("password").equals("")) {
    		return loginVO;
    	} else {
    		loginVO = new EgovMap();
    	}

    	return loginVO;
    }


    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    @Override
	public EgovMap searchId(EgovMap vo) throws Exception {

    	// 1. 이름, 이메일주소가 DB와 일치하는 사용자 ID를 조회한다.
    	EgovMap loginVO = gzoneiLoginDAO.searchId(vo);

    	// 2. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.get("id").equals("")) {
    		return loginVO;
    	} else {
    		loginVO = new EgovMap();
    	}

    	return loginVO;
    }

    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    @Override
	public EgovMap searchPassword(EgovMap vo) throws Exception {


    	// 1. 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답이 DB와 일치하는 사용자 Password를 조회한다.
    	EgovMap loginVO = gzoneiLoginDAO.searchPassword(vo);
    	if (loginVO == null || loginVO.get("password") == null || "".equals(loginVO.get("password"))) {
    		return null;
    	}

    	// 2. 임시 비밀번호를 생성한다.(영+영+숫+영+영+숫+영+영=8자리)
    	String newpassword = "";
    	for (int i = 1; i <= 8; i++) {
    		// 영자
    		if (i % 3 != 0) {
    			newpassword += EgovStringUtil.getRandomStr('a', 'z');
    		// 숫자
    		} else {
    			newpassword += EgovNumberUtil.getRandomNum(0, 9);
    		}
    	}

    	// 3. 임시 비밀번호를 암호화하여 DB에 저장한다.
    	EgovMap pwVO = new EgovMap();
		String enpassword = EgovFileScrty.encryptPassword(newpassword, vo.get("id").toString());
    	pwVO.put("id",vo.get("id"));
    	pwVO.put("name",vo.get("name"));
    	pwVO.put("password",enpassword);
    	pwVO.put("mbtlnum",vo.get("mbtlnum"));
    	pwVO.put("indvdlMberCode",vo.get("indvdlMberCode"));
    	gzoneiLoginDAO.updatePassword(pwVO);
    	pwVO.put("newpassword", newpassword);
    	// 4. 임시 비밀번호를 이메일 발송한다.(메일연동솔루션 활용)
    	// **************** 수정 필요 !!!!!!!!!!!!!!!!!!!!! ************************
    	/*
    	SndngMailVO sndngMailVO = new SndngMailVO();
    	sndngMailVO.setDsptchPerson("webmaster");
    	sndngMailVO.setRecptnPerson(vo.get("eamil"));
    	sndngMailVO.setSj("[MOIS] 임시 비밀번호를 발송했습니다.");
    	sndngMailVO.setEmailCn("고객님의 임시 비밀번호는 " + newpassword + " 입니다.");
    	sndngMailVO.setAtchFileId("");
    	result = sndngMailRegistService.insertSndngMail(sndngMailVO);
    	 */

    	return pwVO;
    }
    
    
    /**
	 * 로그인인증제한을 조회한다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    public EgovMap selectLoginIncorrect(EgovMap vo) throws Exception{
    	return gzoneiLoginDAO.selectLoginIncorrect(vo);
    }
    
    /**
	 * 로그인인증제한을 처리한다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    public String processLoginIncorrect(EgovMap vo, EgovMap mapLockUserInfo) throws Exception{    	
    	String sRtnCode = "C";
    	//KISA 보안약점 조치 (2018-10-29, 윤창원)
    	String enpassword = EgovFileScrty.encryptPassword(vo.get("password").toString(), EgovStringUtil.isNullToString(vo.get("id")));
    	EgovMap mapParam = new EgovMap();
    	mapParam.put("USER_SE", vo.get("userSe").toString());
		mapParam.put("id", EgovStringUtil.isNullToString(vo.get("id")));//KISA 보안약점 조치 (2018-10-29, 윤창원)
    	//잠김시 
		if("Y".equals(((String)mapLockUserInfo.get("lockAt")))){
			sRtnCode = "L";
		//패드워드 인증시 
		}else if( ((String)mapLockUserInfo.get("userPw")).equals(enpassword) ){
    		//LOCK 해제
    		mapParam.put("updateAt", "E");
    		gzoneiLoginDAO.updateLoginIncorrect(mapParam);
    		sRtnCode = "E";
        //패드워드 비인증시 
    	}else if(!"Y".equals(((String)mapLockUserInfo.get("lockAt")))){
    		//LOCK 설정
    		if( Integer.parseInt(String.valueOf(mapLockUserInfo.get("lockCnt")))+1 >= egovLoginConfig.getLockCount() ){    			
	    		mapParam.put("updateAt", "L");
	    		gzoneiLoginDAO.updateLoginIncorrect(mapParam);
	    		sRtnCode = "L";
	    	//LOCK 증가
    		}else{
	    		mapParam.put("updateAt", "C");
	    		gzoneiLoginDAO.updateLoginIncorrect(mapParam);
	    		sRtnCode = "C";
    		}
    	}
    	return sRtnCode;
    }


	@Override
	public void insertLoginHist(EgovMap vo) throws Exception {
		// TODO Auto-generated method stub
		gzoneiLoginDAO.insertLoginHist(vo);
	}


	@Override
	public EgovMap selectPenalty(EgovMap vo) throws Exception {
		// TODO Auto-generated method stub
		return gzoneiLoginDAO.selectPenalty(vo);
	}


	@Override
	public EgovMap selectLoginLog(EgovMap vo) throws Exception {
		// TODO Auto-generated method stub
		return gzoneiLoginDAO.selectLoginLog(vo);
	}


	@Override
	public int selectLoginCount(EgovMap vo) throws Exception {
		// TODO Auto-generated method stub
		return gzoneiLoginDAO.selectLoginCount(vo);
	}


	@Override
	public void insertPenalty(EgovMap vo) throws Exception {
		gzoneiLoginDAO.insertPenalty(vo);
		
	}
	
	/**
     * 로그아웃시 로그아웃 시간 업데이트
     * @param vo
     * @return
     * @throws Exception
     */
    public void updateLoginLog(EgovMap vo) throws Exception{
    	gzoneiLoginDAO.updateLoginLog(vo);
    }
    
    @Override
	public EgovMap checkLogin(EgovMap vo) throws Exception {

    	// 1. 입력한 비밀번호를 암호화한다.
    	vo.put("password", "");

    	// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.
    	EgovMap loginVO = gzoneiLoginDAO.actionLogin(vo);

    	// 3. 결과를 리턴한다.
    	if (loginVO != null && !loginVO.get("id").equals("") && !loginVO.get("password").equals("")) {
    		return loginVO;
    	} else {
    		loginVO = new EgovMap();
    	}

    	return loginVO;
    }
}
