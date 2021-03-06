package gzonei.mypage.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MypageService {

	
	/** 희진 */
	//관심그룹리스트 조회
	public List<?> selectInterestGroupList(String userId) throws SQLException , IOException;
	
	//관심정보리스트 조회
	public List<?> selectInterestInfoList(EgovMap map) throws SQLException , IOException;
	
	//관심정보리스트 수
	public int selectInterestInfoCnt(EgovMap map) throws SQLException , IOException;
	
	//회원수정
	public int memberActionUdt(Map<String, Object> map) throws SQLException , IOException;
		
	//관심그룹 수
	public int selectInterProdGoupChkCount(Map<String, Object> map) throws SQLException , IOException;
	
	//관심그룹 추가
	public String insertInterProd(Map<String, Object> map) throws SQLException , IOException;
	
	//관심그룹명 수정
	public int updateInterProdGrpNm(Map<String, Object> map) throws SQLException , IOException;
	
	//관심그룹명 삭제
	public int deleteInterProdGrpNm(Map<String, Object> map) throws SQLException , IOException;
	
	//관심그룹 삭제
	public int deleteInterProd(EgovMap map) throws SQLException , IOException;
	
	
	/** 다현 */
	
	//탈퇴신청 여부 조회
	public int secessionCheck(EgovMap searchVO)throws SQLException,IOException;
	
	//나의 결제내역 리스트 조회
	public List<?> selectMypaymentList(EgovMap searchVO)throws SQLException, IOException;
	
	//나의 결제내역 갯수 조회
	public int selectMypaymentListTotCnt(EgovMap searchVO)throws SQLException,IOException;
	
	//결제연장하기(회원 정보조회)
	public EgovMap selectMyInfo(EgovMap searchVO)throws SQLException, IOException;
	
	//결제연장하기(서비스코드)
	public List<?> selectSrvcCodeList()throws SQLException,IOException;
	
	//Goodscode 조회
	public List<?> selectGoodsCode(EgovMap searchVO)throws SQLException,IOException;
	
	//등급 코드리스트 조회          
	public List<?> selectGradCodeList()throws SQLException,IOException;
	
	//결제 연장 신청
	public int paymentReqst(EgovMap searchVO)throws SQLException,IOException;

	//상품 정보 조회
	public EgovMap selectPayInfo(EgovMap searchVO)throws SQLException,IOException;
	//카드결제 결제 sn조회 
	public EgovMap selectSetleSn(EgovMap searchVO)throws SQLException,IOException;

}
