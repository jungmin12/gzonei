package gzonei.cmmn.service.impl;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.ListUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.service.CmmnService;
import gzonei.devlopInfo.service.DevlopInfoService;

@Service("cmmnService")
public class CmmnServiceImpl extends EgovAbstractServiceImpl implements CmmnService {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(CmmnServiceImpl.class);

    @Resource(name="cmmnDAO")
    private CmmnDAO cmmnDAO;
    
    /** devlopInfoService */
	@Resource(name = "DevlopInfoService")
	private DevlopInfoService devlopInfoService;

	@Override
	public List<?> selectCodeList(String se, String upperCodeId) throws SQLException, IOException {
		try {
			return cmmnDAO.selectCodeList(se, upperCodeId);
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
	public List<?> selectBbsList(String tabNm, String bbsId) throws SQLException, IOException {
		try {
			return cmmnDAO.selectBbsList(tabNm, bbsId);
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
	public List<?> selectBbsNewsList() throws SQLException, IOException {
		try {
			return cmmnDAO.selectBbsNewsList();
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
	public String getClientIpAddr(HttpServletRequest request) throws Exception {
		String ip = request.getHeader("X-Forwarded-For");  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("WL-Proxy-Client-IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_CLIENT_IP");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
        }  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {  
            ip = request.getRemoteAddr();  
        }  
        return ip;  


	}

	@Override
	public String selectCodeName(String codeId) throws SQLException, IOException {
		try {
			return cmmnDAO.selectCodeName(codeId);
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
	public void insertBbscttLog(EgovMap vo) throws Exception {
		// TODO Auto-generated method stub
		cmmnDAO.insertBbscttLog(vo);
	}

	@Override
	public List<?> selectLayer(EgovMap searchVO) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectLayer(searchVO);
	}

	@Override
	public List<?> selectDevTop() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectDevTop();
	}

	@Override
	public EgovMap selectDevCt() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectDevCt();
	}
	
	@Override
	public List<?> selectBannerList(String code) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectBannerList(code);
	}
	
	@Override
	public List<?> selectAuth(EgovMap vo) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectAuth(vo);
	}
	
	@Override
	public List<?> selectOneAuth(EgovMap vo) throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectOneAuth(vo);
	}

	@Override
	public List<?> selectFreeSample() throws SQLException, IOException {
		// TODO Auto-generated method stub
		return cmmnDAO.selectFreeSample();
	}

	@Override
	public List<?> selectUpdateDevNmList() throws SQLException, IOException {
		try {
			return cmmnDAO.selectUpdateDevNmList();
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
	public List<?> selectDstrcCodeList() throws SQLException, IOException {
		try {
			/*EgovMap inputMap = new EgovMap();
			inputMap.put("upperCodeId","DS00000000");
			List<?> zeroLvl = devlopInfoService.selectDstrcCodeListByUpCd(inputMap);
			for(int i=0;i<zeroLvl.size();i++) {
				EgovMap zeroMap = (EgovMap)zeroLvl.get(i);
				EgovMap zeroInput = new EgovMap();
				zeroInput.put("upperCodeId", zeroMap.get("codeId"));
				List<?> resultList = cmmnDAO.selectDstrcCntByCodeId(zeroInput);
				if(returnList == null) {
					returnList = resultList;
				}else {
					returnList = ListUtils.union(returnList, resultList);
				}
			}*/
			return cmmnDAO.selectDstrcCntByCodeLvl();
			
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
	public List<?> selectCodeListCMMNCodeId(EgovMap map) throws SQLException, IOException {
		try {
			return cmmnDAO.selectCodeListCMMNCodeId(map);
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
	public List<?> selectCodeListAll(String string) throws SQLException, IOException {
		try {
			return cmmnDAO.selectCodeListAll(string);
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
