package gzonei.member.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface MemberService {
	
	// 용명
	//사용자 관리 조회
	public List<?> memberManageList(EgovMap map) throws SQLException , IOException;
	
	//사용자 관리 수 조회
	public int memberManageCnt(EgovMap map) throws SQLException , IOException;
	
	//회원 등급 목록 엑셀
	public List<?> memberManageListExcel(EgovMap map) throws SQLException , IOException;
	
	
	/** 희진 */
	//회원목록 조회
	public List<?> selectMemberList(EgovMap map) throws SQLException , IOException;
	
	//회원수 조회
	public int selectMemberListTotCnt(EgovMap map) throws SQLException , IOException;
	
	//승인대기회원수 조회
	public int selectChkMemberTotCnt(EgovMap map) throws SQLException , IOException;
	
	//회원목록 엑셀
	public List<?> selectMemberListExcel(EgovMap map) throws SQLException , IOException;
	
	//회원상태(승인) 변경
	public int updateMemberState(EgovMap map) throws SQLException , IOException;
	
	//회원 결제내역 조회
	public List<?> selectPaymentList(EgovMap map) throws SQLException , IOException;
		
	//회원 조회이력 조회
	public List<?> selectChkInfoList(EgovMap map) throws SQLException , IOException;
	
	//회원 조회이력 수 조회
	public int selectChkInfoTotCnt(EgovMap map) throws SQLException , IOException;
	
	//회원상세보기 조회
	public EgovMap selectMemberDetail(EgovMap map) throws SQLException , IOException;
	
	//회원 아이디 체크
	public int selectMemberIdChk(EgovMap map) throws SQLException , IOException;
	
	//사업자번호 체크
	public int selectMemberbizNoChk(EgovMap map) throws SQLException , IOException;
	
	//회원등록
	public int insertMemberInfo(Map<String, Object> map) throws SQLException , IOException;
	
	//회원수정
	public int adminMemberActionUdt(Map<String, Object> map) throws SQLException , IOException;
	
	//회원정보(id,이름) 가져오기
	public List<?> selectSearchMemberInfo(EgovMap map) throws SQLException , IOException;
	
	//회원정보(id,이름) 가져오기
	public int selectSearchMemberInfoTotCnt(EgovMap map) throws SQLException , IOException;
	
	//회원등급 입력
	public int insertMemberGrade(Map<String, Object> map) throws SQLException, IOException;
	
	/** 다현 */
	//접속이력목록조회
	public List<?> selectConnectList(EgovMap map) throws SQLException , IOException;
   
	//접속이력목록 total count 
	public int selectConnectListTotCnt(EgovMap map)throws SQLException, IOException;
    
	//사용자별 접속이력조회
	public List<?> selectUserConnectHist(EgovMap searchVO)throws SQLException, IOException;

    //페널티 목록 조회
	public List<?> selectPenaltyList(EgovMap searchVO)throws SQLException, IOException;

    //페널티 목록 count 조회
	public int selectPenaltyListTotCnt(EgovMap searchVO)throws SQLException, IOException;

	//패널티 풀어주기
	public int updatePenaltyRelease(EgovMap searchVO)throws SQLException, IOException;

	//탈퇴 목록 조회
	public List<?> selecSecessionList(EgovMap searchVO)throws SQLException, IOException;

	//탈퇴목록 count 조회
	public int selectSecessionListTotCnt(EgovMap searchVO)throws SQLException, IOException;

	//탈퇴 승인 대기 count 조회
	public int selectSecsnWaitCnt(EgovMap searchVO)throws SQLException,IOException;

	//탈퇴승인
	public int updateSecessionConfirm(EgovMap searchVO)throws SQLException, IOException;
	
	//무통장 입금 확인 
	public int confirmPayment(EgovMap searchVO)throws SQLException, IOException;
	
	//상단 배너 리스트
	public List<?> selectHeadBanner(EgovMap searchVO)throws SQLException,IOException;
	
	//페이지 처리 위한 토탈카운트
	public int selectHeadBannerCnt(EgovMap searchVO)throws SQLException,IOException;
	
	//배너 등록
	public int bannerInsert(EgovMap searchVO)throws SQLException,IOException;
	
	//배너 삭제
	public int bannerDelete(EgovMap searchVO)throws SQLException,IOException;
	
	//배너detail정보조회
	public EgovMap selectBannerDetail(EgovMap searchVO)throws SQLException,IOException;
	
	//배너 수정
	public int updateBannerInfo(EgovMap searchVO)throws SQLException,IOException;



}
