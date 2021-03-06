package gzonei.devlopInfo.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface DevlopInfoService {
	
	//샘플 정보(코드 목록) 조회
	public List<?> selectDevlopInfoList(EgovMap map) throws SQLException , IOException;

	public int selectDevlopInfoListTotCnt(EgovMap searchVO) throws SQLException , IOException;

	public EgovMap selectDevlopInfoDetail(EgovMap searchVO) throws SQLException , IOException;
	
	public EgovMap selectDevInfoSnByDwkNo(EgovMap searchVO) throws SQLException , IOException;

	public int updateDevlopInfoDetail(EgovMap searchVO) throws SQLException , IOException;

	public int deleteDevlopInfoDetail(EgovMap searchVO)throws SQLException , IOException;

	public List<?> selectPrtnDevlopInfoList(EgovMap searchVO)throws SQLException , IOException;

	public EgovMap selectPrtnDevlopInfoDetail(EgovMap searchVO)throws SQLException , IOException;

	public int updatePrtnDevlopInfoDetail(EgovMap searchVO)throws SQLException , IOException;
	
	public int deletePrtnDevlopInfoDetail(EgovMap searchVO)throws SQLException , IOException;

	public int insertDevlopInfoDetail(EgovMap searchVO) throws SQLException , IOException;

	public int insertPrtnDevlopInfoDetail(EgovMap searchVO) throws SQLException , IOException;

	public List<?> selectSimpleDevlopInfoList(EgovMap searchVO)throws SQLException , IOException;

	public int selectSimpleDevlopInfoListTotCnt(EgovMap searchVO)throws SQLException , IOException;

	public EgovMap selectOldFileList(EgovMap searchVO) throws SQLException , IOException;

	public List<?> selectDevlopInfoLayerList(EgovMap searchVO) throws SQLException , IOException;
	
	public List<?> selectMmnwsBbsListByDwkNm(EgovMap searchVO) throws SQLException , IOException;

	public int selectMmnwsBbsListByDwkNmCnt(EgovMap searchVO) throws SQLException , IOException;
	
	//사업지구 코드 리스트(해당하는 등급)
	public List<?> selectDstrcCodeList(EgovMap inputVO) throws SQLException , IOException;
	//사업지구 코드 리스트(전체)
	public List<?> selectDstrcCodeListAll()throws SQLException , IOException;

	public EgovMap selectDevInfoOldestRewardYr()throws SQLException , IOException;

	public List<?> selectDevlopInfoListModal(EgovMap searchVO)throws SQLException , IOException;

	public int selectDevlopInfoListModalTotCnt(EgovMap searchVO)throws SQLException , IOException;

	public List<?> selectIntrstList(EgovMap searchVO)throws SQLException , IOException;

	public int InsertIntrst(EgovMap searchVO) throws SQLException , IOException;

	public List<?> selectInvtListBydwkNo(EgovMap searchVO)throws SQLException , IOException;

	public List<?> selectRecDevInfoLog(EgovMap searchVO)throws SQLException , IOException;

	public List<?> selectAdminList(EgovMap searchVO)throws SQLException , IOException;

	public int selectAdminListTotCnt(EgovMap searchVO)throws SQLException , IOException;

	public List<?> selectDstrcCodeListByUpCd(EgovMap inputVO)throws SQLException , IOException;

	public List<?> selectNewFileList(EgovMap searchVO)throws SQLException , IOException;

	public int selectIntrstChk(EgovMap searchVO)throws SQLException , IOException;

	public EgovMap selectUserPrintCntById(EgovMap userVO)throws SQLException , IOException;

	public int updateUserPrintCnt(EgovMap searchVO)throws SQLException , IOException;

	public int selectInvtListCnt(EgovMap searchVO)throws SQLException , IOException;

	public void insertOldFileInf(MultipartHttpServletRequest multi, String string, String dwkNo,
			String[] atchFileNm, String date, String userId, String fileType);
	
	public void insertOldThumbFileInf(MultipartHttpServletRequest multi, String string, String dwkNo,
			String[] atchFileNm, String date, String userId, String fileType);
	
	public void insertPrtnOldFileInf(MultipartHttpServletRequest multi, String string, String prtnSn,
			String[] atchFileNm, String date, String userId);
}
