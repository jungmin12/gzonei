package gzonei.devlopInfo.service.impl;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.commons.collections.ListUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.sun.star.bridge.oleautomation.Date;

import egovframework.com.cmm.service.EgovProperties;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import gzonei.cmmn.util.FileUtils;
import gzonei.devlopInfo.service.DevlopInfoService;
import gzonei.sample.service.SampleService;

@Service("DevlopInfoService")
public class DevlopInfoServiceImpl extends EgovAbstractServiceImpl implements DevlopInfoService{

	private static final Logger LOGGER = LoggerFactory.getLogger(DevlopInfoServiceImpl.class);

	// 기본 경로
	final String path = EgovProperties.getProperty("Globals.SynchrnServerPath");
	
	@Resource(name="DevlopInfoDAO")
	private DevlopInfoDAO devlopInfoDAO;
	
	@Resource(name="FileUtils")
	private FileUtils fileUtils;

	@SuppressWarnings("unchecked")
	@Override
	public List<?> selectDevlopInfoList(EgovMap map) throws SQLException, IOException {
		try {
			map = IncLowLvList(map);
			return devlopInfoDAO.selectDevlopInfoList(map);
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
	public int selectDevlopInfoListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			map = IncLowLvList(map);
			return devlopInfoDAO.selectDevlopInfoListTotCnt(map);
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
	public EgovMap selectDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDevlopInfoDetail(map);
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
	public EgovMap selectDevInfoSnByDwkNo(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDevInfoSnByDwkNo(map);
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
	public int updateDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.updateDevlopInfoDetail(map);
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
	public int deleteDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.deleteDevlopInfoDetail(map);
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
	public List<?> selectPrtnDevlopInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectPrtnDevlopInfoList(map);
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
	public EgovMap selectPrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectPrtnDevlopInfoDetail(map);
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
	public int updatePrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.updatePrtnDevlopInfoDetail(map);
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
	public int deletePrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.deletePrtnDevlopInfoDetail(map);
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
	public int insertDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.insertDevlopInfoDetail(map);
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
	public int insertPrtnDevlopInfoDetail(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.insertPrtnDevlopInfoDetail(map);
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
	public List<?> selectSimpleDevlopInfoList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectSimpleDevlopInfoList(map);
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
	public int selectSimpleDevlopInfoListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectSimpleDevlopInfoListTotCnt(map);
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
	public EgovMap selectOldFileList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectOldFileList(map);
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
	public List<?> selectDevlopInfoLayerList(EgovMap searchVO) throws SQLException, IOException {
		try {
			searchVO = IncLowLvList(searchVO);
			return devlopInfoDAO.selectDevlopInfoLayerList(searchVO);
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
	public List<?> selectMmnwsBbsListByDwkNm(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectMmnwsBbsListByDwkNm(map);
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
	public int selectMmnwsBbsListByDwkNmCnt(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectMmnwsBbsListByDwkNmCnt(map);
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
	public List<?> selectDstrcCodeList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDstrcCodeList(map);
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
	public List<?> selectDstrcCodeListAll() throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDstrcCodeListAll();
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
	public EgovMap selectDevInfoOldestRewardYr() throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDevInfoOldestRewardYr();
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
	public List<?> selectDevlopInfoListModal(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDevlopInfoListModal(map);
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
	public int selectDevlopInfoListModalTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDevlopInfoListModalTotCnt(map);
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
	public List<?> selectIntrstList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectIntrstList(map);
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
	public int InsertIntrst(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.InsertIntrst(map);
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
	public List<?> selectInvtListBydwkNo(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectInvtListBydwkNo(map);
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
	public List<?> selectRecDevInfoLog(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectRecDevInfoLog(map);
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
	public List<?> selectAdminList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectAdminList(map);
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
	public int selectAdminListTotCnt(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectAdminListTotCnt(map);
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
	public List<?> selectDstrcCodeListByUpCd(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectDstrcCodeListByUpCd(map);
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
	public List<?> selectNewFileList(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectNewFileList(map);
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
	public int selectIntrstChk(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectIntrstChk(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}

	@SuppressWarnings("unchecked")
	@Override
	public EgovMap selectUserPrintCntById(EgovMap map) throws SQLException, IOException {
		try {
			EgovMap egovMap = devlopInfoDAO.selectUserPrintCntById(map);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
			String today = LocalDate.now().format(formatter);
			if(null!=egovMap.get("outptCo") /*&& !("").equals(egovMap.get("outptCo"))*/) {
				Timestamp printTs= (Timestamp) egovMap.get("outptDt");
				String printTsStrDate = printTs.toLocalDateTime().format(formatter);
				String printCnt = (String) egovMap.get("outptCo");
				if(/*egovMap.get("outptCo").equals("0") && !*/today.equals(printTsStrDate)) {
					//프린트시간/프린트횟수가 있거나, 있는데 오늘이랑 날짜가 같은경우
					if(egovMap.get("indvdlMberCode").equals("CM00210003")) {
						egovMap.replace("outptDt", printTsStrDate);
						egovMap.replace("outptCo", "20");
					}else {
						egovMap.replace("outptDt", printTsStrDate);
						egovMap.replace("outptCo", printCnt);
					}
				}else {
					//횟수가 없거나, 오늘이랑 날짜가 다르면 새로 날짜와 횟수를 업데이트
					//날짜는 Now()
					map.put("outptDt", "now");
					map.put("outptCo", "20");
					devlopInfoDAO.updateUserPrintCnt(map);
					egovMap.replace("outptDt", today);
					egovMap.replace("outptCo", "20");
				}
			}else {
				//횟수나 날짜가 없으면
				map.put("outptDt", "now");
				map.put("outptCo", "20");
				devlopInfoDAO.updateUserPrintCnt(map);
				egovMap.replace("outptDt", today);
				egovMap.replace("outptCo", "20");
			}
			return egovMap;
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
	public int updateUserPrintCnt(EgovMap map) throws SQLException, IOException {
		try {
			return devlopInfoDAO.updateUserPrintCnt(map);
		} catch (IOException e) { // 시큐어 코드
			LOGGER.error("#################### IOException: " + e);
		} catch (SQLException e) { // 시큐어 코드
			LOGGER.error("#################### SQLException: " + e);
		} catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
		return 0;
	}
	@SuppressWarnings("unchecked")
	private EgovMap IncLowLvList(EgovMap map) {
		EgovMap egm = new EgovMap();
		try {
			if(map.get("ds1") !=null) {
				if(map.get("ds2").equals("")) {
					egm.put("upperCodeId", map.get("ds1"));
					//1Level의 하위
					List<?> totCodeList = new ArrayList<Object>();
					totCodeList = devlopInfoDAO.selectDstrcCodeListByUpCd(egm);
					for(Object obj : totCodeList) {
						EgovMap egovMap = (EgovMap)obj;
						if(egovMap.get("upperCodeAt").equals("Y")) {
							egm.replace("upperCodeId",egovMap.get("codeId"));
							//2Level의 하위
							List<?> ds2CodeList = devlopInfoDAO.selectDstrcCodeListByUpCd(egm);
							totCodeList = ListUtils.union(totCodeList, ds2CodeList);
						}
					}
					map.put("totCodeList", totCodeList);
				}else if(map.get("ds3").equals("")) {
					egm.put("codeId", map.get("ds2"));
					List<?> totCodeList = new ArrayList<Object>();
					totCodeList = devlopInfoDAO.selectDstrcCodeListByUpCd(egm);
					EgovMap ds2Map = (EgovMap)totCodeList.get(0);
					String upCodeAtDs = ds2Map.get("upperCodeAt").toString();
					map.put("upCodeAtDs", upCodeAtDs);
					if(upCodeAtDs.equals("Y")) {
						egm.remove("codeId");
						egm.put("upperCodeId",map.get("ds2"));
						List<?> ds2CodeList = devlopInfoDAO.selectDstrcCodeListByUpCd(egm);
						totCodeList = ListUtils.union(totCodeList, ds2CodeList);
					}
					map.put("totCodeList", totCodeList);
				}
			}
			return map;
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
	public int selectInvtListCnt(EgovMap searchVO) throws SQLException, IOException {
		try {
			return devlopInfoDAO.selectInvtListCnt(searchVO);
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
	public void insertOldFileInf(MultipartHttpServletRequest multi, String KeyStr, String dwkNo,
			String[] atchFileNm, String storePath, String userId,String fileType) {
		try {
			// 파일 업로드 변수 설정
			int fileNum=0;
			String fileExt = ""; // 확장자
			String fileNameExtension = ""; // 확장자
			String atchFileIdString = UUID.randomUUID().toString().substring(19);; // 첨부파일 ID
			String changeFileName = ""; // 바뀐 파일 명
			String newPath = path +storePath; // 저장경로
			String fileStreCours = ""; // 바뀐 파일 명
			File dir = new File(newPath);
			dir.setExecutable(true,false);
			dir.setReadable(true,false);
			dir.setWritable(true,false);
			if(!dir.isDirectory()) { // 파일 없을시 생성
				dir.mkdirs();
			}
			//EgovMap oldFileMap = devlopInfoDAO.selectOldFileList(fileVO);
			
			Iterator<String> files = multi.getFileNames();
			while(files.hasNext()) {
				String uploadFile = files.next();
				if(!uploadFile.equals("thumbFile")) {
					MultipartFile mFile = multi.getFile(uploadFile);
					// 파일명 가져오기
					String filedName = mFile.getName();
					String fileName = mFile.getOriginalFilename();
					fileNum = Integer.parseInt(filedName.substring(filedName.lastIndexOf("_")+1));
					String acthFileNmString =  atchFileNm[fileNum-1];
					System.out.println("acthFileNmString : " + acthFileNmString);
					
					if(mFile.isEmpty() == false) {
						System.out.println("파일있음");
						// 파일 확장자 
						fileExt = fileName.substring(fileName.lastIndexOf("."));
						fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
						// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
						changeFileName = KeyStr + atchFileIdString + "_" + ((int)(Math.random()*1000000000)+1) + fileExt;
						// 파일 경로
						fileStreCours = newPath+"/"+ changeFileName;
						/* 시스템 출력 (테스트용) 삭제예정 START */
						System.out.println("파일 저장경로 : "+ newPath);
						System.out.println("실제파일이름 : "+ fileName);
						System.out.println("바뀐 파일 이름 : "+ changeFileName);
						System.out.println("파일확장자 : "+ fileNameExtension);
						/* 파라미터 넣기 S */
						String fileNm = changeFileName;
						String filePath = fileStreCours.replace("/upload/gzone/", "");
						String fileDisNm = acthFileNmString;
						// DB저장 및 파일업로드
						if(acthFileNmString.length() > 0) {
							EgovMap fileVO = new EgovMap();
							String uploadTime = fileUtils.getUploadTime();
							fileVO.put("userId", userId);
							fileVO.put("updDt", uploadTime);
							fileVO.put("fileType", fileType);
							fileVO.put("dwkNo", dwkNo);
							//DB
							int oldFileSn = fileNum;
							String oldFileSnStr = String.valueOf(oldFileSn);
							fileVO.put("fileNm"+oldFileSnStr, fileNm);
							fileVO.put("filePath"+oldFileSnStr, filePath);
							fileVO.put("fileDisNm"+oldFileSnStr, fileDisNm);
							devlopInfoDAO.updateOldFileDetail(fileVO);
							//업로드
							mFile.transferTo(new File(fileStreCours));
						}
					}else {
						//DB
						if(acthFileNmString.equals("")) {
							EgovMap fileVO = new EgovMap();
							String uploadTime = fileUtils.getUploadTime();
							fileVO.put("userId", userId);
							fileVO.put("updDt", uploadTime);
							fileVO.put("fileType", fileType);
							fileVO.put("dwkNo", dwkNo);
							int oldFileSn = fileNum;
							String oldFileSnStr = String.valueOf(oldFileSn);
							fileVO.put("fileNm"+oldFileSnStr, "");
							fileVO.put("filePath"+oldFileSnStr, "");
							fileVO.put("fileDisNm"+oldFileSnStr, "");
							devlopInfoDAO.updateOldFileDetail(fileVO);
						}
					}
				}
			}
			//폴더 권한변경
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
			
		}catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	@Override
	public void insertOldThumbFileInf(MultipartHttpServletRequest multi, String KeyStr, String dwkNo,
			String[] atchFileNm, String storePath, String userId,String fileType) {
		try {
			// 파일 업로드 변수 설정
			int fileNum=0;
			String fileExt = ""; // 확장자
			String fileNameExtension = ""; // 확장자
			String atchFileIdString = UUID.randomUUID().toString().substring(19);; // 첨부파일 ID
			String changeFileName = ""; // 바뀐 파일 명
			String newPath = path +storePath; // 저장경로
			String fileStreCours = ""; // 바뀐 파일 명
			File dir = new File(newPath);
			dir.setExecutable(true,false);
			dir.setReadable(true,false);
			dir.setWritable(true,false);
			if(!dir.isDirectory()) { // 파일 없을시 생성
				dir.mkdirs();
			}
			//EgovMap oldFileMap = devlopInfoDAO.selectOldFileList(fileVO);
			
			Iterator<String> files = multi.getFileNames();
			while(files.hasNext()) {
				String uploadFile = files.next();
				if(uploadFile.equals("thumbFile")) {
					MultipartFile mFile = multi.getFile(uploadFile);
					// 파일명 가져오기
					String filedName = mFile.getName();
					String fileName = mFile.getOriginalFilename();
					fileNum = 1;
					String acthFileNmString =  atchFileNm[fileNum-1];
					System.out.println("acthFileNmString : " + acthFileNmString);
					
					if(mFile.isEmpty() == false) {
						System.out.println("파일있음");
						// 파일 확장자 
						fileExt = fileName.substring(fileName.lastIndexOf("."));
						fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
						// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
						changeFileName = KeyStr + atchFileIdString + "_" + ((int)(Math.random()*1000000000)+1) + fileExt;
						// 파일 경로
						fileStreCours = newPath+"/"+ changeFileName;
						/* 시스템 출력 (테스트용) 삭제예정 START */
						System.out.println("파일 저장경로 : "+ newPath);
						System.out.println("실제파일이름 : "+ fileName);
						System.out.println("바뀐 파일 이름 : "+ changeFileName);
						System.out.println("파일확장자 : "+ fileNameExtension);
						/* 파라미터 넣기 S */
						String fileNm = changeFileName;
						String filePath = fileStreCours.replace("/upload/gzone/", "");
						String fileDisNm = acthFileNmString;
						// DB저장 및 파일업로드
						if(acthFileNmString.length() > 0) {
							EgovMap fileVO = new EgovMap();
							String uploadTime = fileUtils.getUploadTime();
							fileVO.put("userId", userId);
							fileVO.put("updDt", uploadTime);
							fileVO.put("fileType", fileType);
							fileVO.put("dwkNo", dwkNo);
							//DB
							int oldFileSn = fileNum;
							String oldFileSnStr = String.valueOf(oldFileSn);
							fileVO.put("fileNm", fileNm);
							fileVO.put("filePath", filePath);
							devlopInfoDAO.updateOldFileDetail(fileVO);
							//업로드
							mFile.transferTo(new File(fileStreCours));
						}
					}else {
						//DB
						if(acthFileNmString.equals("")) {
							EgovMap fileVO = new EgovMap();
							String uploadTime = fileUtils.getUploadTime();
							fileVO.put("userId", userId);
							fileVO.put("updDt", uploadTime);
							fileVO.put("fileType", fileType);
							fileVO.put("dwkNo", dwkNo);
							int oldFileSn = fileNum;
							String oldFileSnStr = String.valueOf(oldFileSn);
							fileVO.put("fileNm", "");
							fileVO.put("filePath", "");
							devlopInfoDAO.updateOldFileDetail(fileVO);
						}
					}
				}
			}
			//폴더 권한변경
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
			
		}catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
	@Override
	public void insertPrtnOldFileInf(MultipartHttpServletRequest multi, String KeyStr, String prtnSn,
			String[] atchFileNm, String storePath, String userId) {
		try {
			// 파일 업로드 변수 설정
			int fileNum=0;
			String fileExt = ""; // 확장자
			String fileNameExtension = ""; // 확장자
			String atchFileIdString = UUID.randomUUID().toString().substring(19);; // 첨부파일 ID
			String changeFileName = ""; // 바뀐 파일 명
			String newPath = path +storePath; // 저장경로
			String fileStreCours = ""; // 바뀐 파일 명
			File dir = new File(newPath);
			dir.setExecutable(true,false);
			dir.setReadable(true,false);
			dir.setWritable(true,false);
			if(!dir.isDirectory()) { // 파일 없을시 생성
				dir.mkdirs();
			}
			//EgovMap oldFileMap = devlopInfoDAO.selectOldFileList(fileVO);
			
			Iterator<String> files = multi.getFileNames();
			while(files.hasNext()) {
				String uploadFile = files.next();
				MultipartFile mFile = multi.getFile(uploadFile);
				// 파일명 가져오기
				String filedName = mFile.getName();
				String fileName = mFile.getOriginalFilename();
				fileNum = Integer.parseInt(filedName.substring(filedName.lastIndexOf("_")+1));
				
				String acthFileNmString =  atchFileNm[fileNum-1];
				System.out.println("acthFileNmString : " + acthFileNmString);
				
				if(mFile.isEmpty() == false) {
					System.out.println("파일있음");
					// 파일 확장자 
					fileExt = fileName.substring(fileName.lastIndexOf("."));
					fileNameExtension = fileName.substring(fileName.lastIndexOf(".")+1);
					// 바꾼 파일 명 (BBS_+ 첨부파일 ID+ 확장자) 
					changeFileName = KeyStr + atchFileIdString + "_" + ((int)(Math.random()*1000000000)+1) + fileExt;
					// 파일 경로
					fileStreCours = newPath+"/"+ changeFileName;
					/* 시스템 출력 (테스트용) 삭제예정 START */
					System.out.println("파일 저장경로 : "+ newPath);
					System.out.println("실제파일이름 : "+ fileName);
					System.out.println("바뀐 파일 이름 : "+ changeFileName);
					System.out.println("파일확장자 : "+ fileNameExtension);
					/* 파라미터 넣기 S */
					String fileNm = changeFileName;
					String filePath = fileStreCours.replace("/upload/gzone/", "");
					String fileDisNm = acthFileNmString;
					// DB저장 및 파일업로드
					if(acthFileNmString.length() > 0) {
						EgovMap fileVO = new EgovMap();
						fileVO.put("userId", userId);
						fileVO.put("bsnsPrtnSttusSn", prtnSn);
						//DB
						fileVO.put("fileNm", fileNm);
						fileVO.put("atchFilePath", filePath);
						
						devlopInfoDAO.updateOldPrtnFileDetail(fileVO);
						//업로드
						mFile.transferTo(new File(fileStreCours));
					}
				}else {
					//DB
					if(acthFileNmString.equals("")) {
						EgovMap fileVO = new EgovMap();
						String uploadTime = fileUtils.getUploadTime();
						fileVO.put("userId", userId);
						fileVO.put("bsnsPrtnSttusSn", prtnSn);
						
						fileVO.put("fileNm", "");
						fileVO.put("atchFilePath", "");
						
						devlopInfoDAO.updateOldPrtnFileDetail(fileVO);
					}
				}
			}
			//폴더 권한변경
			Runtime.getRuntime().exec("chmod -R 777 /upload/gzone/images/file");
			
		}catch (Exception e) {
			LOGGER.error("#################### Exception: " + e);
		} 
	}
	
}
