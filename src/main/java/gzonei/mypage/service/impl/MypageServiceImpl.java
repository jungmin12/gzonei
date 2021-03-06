package gzonei.mypage.service.impl;


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
import gzonei.mypage.service.MypageService;

@Service("MypageService")
public class MypageServiceImpl extends EgovAbstractServiceImpl implements MypageService{

	private static final Logger LOGGER = LoggerFactory.getLogger(MypageServiceImpl.class);
	
	@Resource(name="MypageDAO")
	private MypageDAO mypageDAO;

	/** 희진 */
	//관심그룹리스트 조회
	public List<?> selectInterestGroupList(String userId) throws SQLException, IOException {
		try {
			return mypageDAO.selectInterestGroupList(userId);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	//관심정보리스트 조회
	public List<?> selectInterestInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectInterestInfoList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	//관심정보리스트 수
	public int selectInterestInfoCnt(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectInterestInfoCnt(map);
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
	public int memberActionUdt(Map<String, Object> map) throws SQLException, IOException {
		try {
			//패스워드 암호화
			
			if(map.get("password") != null && !"".equals(map.get("password"))) {
				String pass = EgovFileScrty.encryptPassword((String)map.get("password"), EgovStringUtil.isNullToString(map.get("emplyrId")));//KISA 보안약점 조치 (2018-10-29, 윤창원)
				map.put("password", pass);
			}
			//회원정보 수정
			int result = mypageDAO.memberActionUdt(map);
			int count = mypageDAO.selectInterareaCnt(map);
			if(count > 0) {//관심지역이 있으면 삭제 후 입력
				mypageDAO.deleteInterarea(map);
			}
			if(null != map.get("intrstAreaCode") && !"".equals(map.get("intrstAreaCode"))) {	
				result += mypageDAO.insertInterarea(map);
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
	public int selectInterProdGoupChkCount(Map<String, Object> map) throws SQLException, IOException {
		try {
			return mypageDAO.selectInterProdGoupChkCount(map);
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
	public String insertInterProd(Map<String, Object> map) throws SQLException, IOException {
		try {
			int result = mypageDAO.insertInterProd(map);
			if (result != 1) {
				throw new Exception("관심상품 추가 처리 실패!");
			}
			return "SUCCESS";
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return "FAIL";
	}
	
	@Override
	public int updateInterProdGrpNm(Map<String, Object> map) throws SQLException, IOException {
		try {
			return mypageDAO.updateInterProdGrpNm(map);
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
	public int deleteInterProdGrpNm(Map<String, Object> map) throws SQLException, IOException {
		try {
			return mypageDAO.deleteInterProdGrpNm(map);
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
	public int deleteInterProd(EgovMap map) throws SQLException, IOException {
		try {
			int result = 0;
			String[] interProdSeq = (String[]) map.get("interProdSeq");
			 for ( String sn: interProdSeq) {
	    		 	map.put("uuid", sn);
					result += mypageDAO.deleteInterProd(map);
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
	/** 다현 */
	
	@Override
	public int secessionCheck(EgovMap map)throws SQLException, IOException{
		try {
			int result = mypageDAO.secessionCheck(map);
			if(result == 0) {
				result = mypageDAO.updateMemberSecession(map);	
				result = mypageDAO.insertSecessionHist(map);
				return result;
			}else {
				result = 3;
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
	
	//나의 결제 내역 조회
	@Override
	public List<?> selectMypaymentList(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectMypaymentList(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
	
	//나의 결제내역 갯수 조회
	@Override
	public int selectMypaymentListTotCnt(EgovMap map)throws SQLException, IOException{
		try {
			return mypageDAO.selectMypaymentListTotCnt(map);
			
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		}
		
		return 0;	
	}
	
	//결제연장하기 내정보조회
	@Override
	public EgovMap selectMyInfo(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectMyInfo(map);
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
	public List<?> selectGoodsCode(EgovMap map)throws SQLException, IOException {
		try {
			return mypageDAO.selectGoodsCode(map);
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
	public List<?> selectSrvcCodeList()throws SQLException, IOException {
		try {
			return mypageDAO.selectSrvcCodeList();
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
	public List<?> selectGradCodeList()throws SQLException, IOException {
		try {
			return mypageDAO.selectGradCodeList();
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
	public int paymentReqst(EgovMap map)throws SQLException, IOException{
		try {
			int result = mypageDAO.insertSetleDtls(map);
				result = mypageDAO.insertSetleDtlsHist(map);
				result = mypageDAO.insertRcpmnyDtls(map);
				
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
	public EgovMap selectPayInfo(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectPayInfo(map);
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
	public EgovMap selectSetleSn(EgovMap map) throws SQLException, IOException {
		try {
			return mypageDAO.selectSetleSn(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		
		return null;
	}
}
