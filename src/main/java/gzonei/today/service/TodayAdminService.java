package gzonei.today.service;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import egovframework.rte.psl.dataaccess.util.EgovMap;

public interface TodayAdminService {
	
	/** 희진 */
	// 오늘의 정보(향후추진내역)
	public List<?> selectPrtnSttusList(EgovMap map) throws SQLException , IOException;

	//오늘의 정보(향후추진내역) 수 조회
	public int selectPrtnSttusListTotCnt(EgovMap map) throws SQLException , IOException;
	
	// 오늘의 정보(엑셀다운)
	public List<?> selectPrtnSttusListExcel(EgovMap map) throws SQLException , IOException;
	
	// 개발정보 필수 고시 리스트
	public List<?> selectDevelopGosiList(EgovMap map) throws SQLException , IOException;

	//개발정보 필수 고시  수 조회
	public int selectDevelopGosiListTotCnt(EgovMap map) throws SQLException , IOException;
	
	/** 다현 */
	//오늘의정보(개발정보필수정보)
	public List<?> selectTodayDevInfoList(EgovMap map)throws SQLException,IOException;
	
	//오늘의정보(개발정보필수정보)수 조회
	public int selectTodayDevInfoTotCnt(EgovMap map)throws SQLException,IOException;
	
	//개발정보필수정보 상세 조회
	public EgovMap selectReqDevInfo(EgovMap searchVO)throws SQLException,IOException;
	
	//개발정보필수정보 수정
	public int udtDevlopInfo(EgovMap searchVO)throws SQLException,IOException;
}
