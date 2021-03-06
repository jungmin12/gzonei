package gzonei.member.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovFileScrty;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.member.service.MemberService;

@Service("MemberService")
public class MemberServiceImpl extends EgovAbstractServiceImpl implements MemberService{

	private static final Logger LOGGER = LoggerFactory.getLogger(MemberServiceImpl.class);
	
	@Resource(name="MemberDAO")
	private MemberDAO memberDAO;

	/** 희진 */
	
	@Override
	public List<?> selectMemberList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}

	
	//용명 사용자관리추가
	@Override
	public List<?> memberManageList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.memberManageList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int memberManageCnt(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.memberManageCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public List<?> memberManageListExcel(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.memberManageListExcel(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectMemberListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int selectChkMemberTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectChkMemberTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}

	@Override
	public List<?> selectMemberListExcel(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberListExcel(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int updateMemberState(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.updateMemberState(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	@Override
	public List<?> selectPaymentList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectPaymentList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	@Override
	public List<?> selectChkInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectChkInfoList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectChkInfoTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectChkInfoTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public EgovMap selectMemberDetail(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectMemberIdChk(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberIdChk(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int selectMemberbizNoChk(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectMemberbizNoChk(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int insertMemberInfo(Map<String, Object> map) throws SQLException, IOException {
		try {
			//패스워드 암호화
			String pass = EgovFileScrty.encryptPassword((String)map.get("password"), EgovStringUtil.isNullToString(map.get("emplyrId")));//KISA 보안약점 조치 (2018-10-29, 윤창원)
			map.put("password", pass);
			//회원정보 등록
			int result = memberDAO.insertMemberInfo(map);
			//관심지역 등록
			if(null != map.get("intrstAreaCode") && !"".equals(map.get("intrstAreaCode"))) {
				result += memberDAO.insertInterarea(map);
			}
			return result;
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int adminMemberActionUdt(Map<String, Object> map) throws SQLException, IOException {
		try {
			//패스워드 암호화
			if(map.get("password") != null && !"".equals(map.get("password"))) {
				String pass = EgovFileScrty.encryptPassword((String)map.get("password"), EgovStringUtil.isNullToString(map.get("emplyrId")));//KISA 보안약점 조치 (2018-10-29, 윤창원)
				map.put("password", pass);
			}
			int result = memberDAO.adminMemberActionUdt(map);//회원정보수정
			if(result != 1) {
				return 0;
			}
			// 관심지역
			int count = memberDAO.selectInterareaCnt(map);
			if(count > 0) {//관심지역이 있으면 삭제 후 입력
				memberDAO.deleteInterarea(map);
			}
			if(null != map.get("intrstAreaCode") && !"".equals(map.get("intrstAreaCode"))) {
				memberDAO.insertInterarea(map);
			}
			// 회원등급 변경
			if (!"".equals((String)map.get("mberGradCode"))) {
				// 무료 = > 유료(골드, 프리미엄 등등)
				if ("".equals((String)map.get("mberGradCodeOrg"))) {
					result = memberDAO.insertMemberGrade(map);//결제테이블
					if (result != 1) {
						return 0;
					}
				}
				else {
					result = memberDAO.updateMemberGrade(map);
					if (result != 1) {
						return 0;
					}					
				}
			}
			
			
			return result;
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}

	@Override
	public List<?> selectSearchMemberInfo(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectSearchMemberInfo(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectSearchMemberInfoTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectSearchMemberInfoTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int insertMemberGrade(Map<String, Object> map) throws SQLException, IOException {
		try {
			return memberDAO.insertMemberGrade(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}

	
	/** 다현 */
	
	@Override
	public List<?> selectConnectList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectConnectList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectConnectListTotCnt(EgovMap map)throws SQLException, IOException{
		try {
			return memberDAO.selectConnectListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public List<?> selectUserConnectHist(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectUserConnectHist(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public List<?> selectPenaltyList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectPenaltyList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectPenaltyListTotCnt(EgovMap map)throws SQLException, IOException{
		try {
			return memberDAO.selectPenaltyListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public int updatePenaltyRelease(EgovMap map) throws SQLException, IOException {
		try {
			int result = memberDAO.updatePenaltyRelease(map);
			result = memberDAO.updateConnectListLogoutdt(map);
			return result;
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public List<?> selecSecessionList(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectSecessionList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectSecessionListTotCnt(EgovMap map)throws SQLException, IOException{
		try {
			return memberDAO.selectSecessionListTotCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public int selectSecsnWaitCnt(EgovMap map)throws SQLException, IOException{
		try {
			return memberDAO.selectSecsnWaitCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public int updateSecessionConfirm(EgovMap map)throws SQLException, IOException{
		try {
			int result = memberDAO.updateSecessionConfirm(map);
			if(result != 1) {
				return 0;
			}else {
				result = memberDAO.updateSecessionHist(map);
				return result;
			}
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	
	@Override
	public int confirmPayment(EgovMap map)throws SQLException, IOException{
		try {
			int result = 0;
			int srvccnt = memberDAO.selectSrvcCnt(map);//서비스 이용중인지 조회 여부
			
			if(srvccnt > 0) {//서비스 만료 전인 회원
				result = memberDAO.confirmPayment(map);
				result = memberDAO.updateSetleAfter(map);
				result = memberDAO.updateMberSetleHist(map);
				result = memberDAO.insertMberGrade(map);
			
			}else {
				result = memberDAO.confirmPayment(map);
				result = memberDAO.updateMberSetle(map);	
				result = memberDAO.updateMberSetleHist(map);
				result = memberDAO.insertMberGrade(map);
				
			}
			return result;
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {    
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public List<?> selectHeadBanner(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectHeadBanner(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int selectHeadBannerCnt(EgovMap map)throws SQLException, IOException{
		try {
			return memberDAO.selectHeadBannerCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	@Override
	public int bannerInsert(EgovMap map) throws SQLException, IOException {
		try {
			
			int result = memberDAO.bannerInsert(map);
			
			return result;
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public int bannerDelete(EgovMap map) throws SQLException, IOException {
		try {
			
			int result = memberDAO.bannerDelete(map);
				result = memberDAO.bannerFileDel(map);
			return result;
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
	
	@Override
	public EgovMap selectBannerDetail(EgovMap map) throws SQLException, IOException {
		try {
			return memberDAO.selectBannerDetail(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	@Override
	public int updateBannerInfo(EgovMap map) throws SQLException, IOException {
		try {
			
			int result = memberDAO.updateBannerInfo(map);
				
			return result;
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return 0;
	}
}
