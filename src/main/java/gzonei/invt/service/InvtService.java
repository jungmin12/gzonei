package gzonei.invt.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface InvtService {
	
	//샘플 정보(코드 목록) 조회
	public List<?> selectInvtList(EgovMap map) throws SQLException , IOException;

	public int selectInvtListCnt(EgovMap map) throws SQLException , IOException;

	public EgovMap selectInvtDetail(EgovMap searchVO) throws SQLException , IOException;

	public List<?> selectProList(EgovMap searchVO) throws SQLException, IOException ;

	public List<?> selectUseList(EgovMap searchVO) throws SQLException, IOException ;

	public EgovMap selectUseDetail(EgovMap searchVO) throws SQLException, IOException ;

	public EgovMap selectProDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int insertInvDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int deleteInvtInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int updateInvtInfoDetail(EgovMap searchVO)throws SQLException, IOException ;

	public int deleteUseInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int updateUseInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int insertUseInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int deleteProInfoDetail(EgovMap searchVO) throws SQLException, IOException ;
	
	public int updateProInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public int insertProInfoDetail(EgovMap searchVO) throws SQLException, IOException ;

	public List<?> selectInvtAdmList(EgovMap searchVO) throws SQLException, IOException ;

	public int selectInvtAdmListCnt(EgovMap searchVO) throws SQLException, IOException ;

	public EgovMap insertInvSn() throws SQLException, IOException ;

	public int selectInvtOverlap(EgovMap searchVO) throws SQLException, IOException ;

}
