package gzonei.member.service;

import java.io.Serializable;
import java.net.URLDecoder;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sci.v2.pcc.secu.SciSecuManager;
import com.sci.v2.pcc.secu.hmac.SciHmac;

public class CertificationVO implements Serializable {

    public static final String	SERVICE_REAL_NUMBER	= "008001";
    public static final String	SERVICE_NEW2_NUMBER		= "007001";
    public static final String	SERVICE_DEV_NUMBER		= "005001";
    public static final String	SERVICE_DEV2_NUMBER		= "006001";
    public static final String	SERVICE_LOCAL_NUMBER	= "003001";
    public static final String	SERVICE_HTTP_NUMBER	= "001009";

    /**
	 * 
	 */
	private static final long serialVersionUID = -586634394013996072L;

	private	String	id			= "";		// 본인실명확인 회원사 아이디
	private	String	srvNo		= "";		// 본인실명확인 서비스번호
	private	String	exVar		= "0000000000000000";		// 복호화용 임시필드
	private	String	retUrl		= "";		// 본인실명확인 결과수신 URL

	private	String	reqInfo	= "";		// 요청정보
	
	private	String retInfo	= "";		// 결과정보

	private	String name		= "";		//성명
	private	String sex			= "";		//성별
	private	String birYMD	= "";		//생년월일
	private	String fgnGbn	= "";		//내외국인 구분값
	
	private	String di			= "";		//DI
	private	String ci1			= "";		//CI
	private	String ci2			= "";		//CI
	private	String civersion	= "";		//CI Version
    
	private	String reqNum	= "";		// 본인확인 요청번호
	private	String result		= "";		// 본인확인결과 (Y/N)
	private	String certDate	= "";		// 검증시간
	private	String certGb		= "";		// 인증수단
	private	String cellNo		= "";		// 핸드폰 번호
	private	String cellCorp	= "";		// 이동통신사
	private	String addVar	= "";
	private	String	psnMemCd	= "";	// 회원구분

	//복화화용 변수
	private	String encPara	= "";
	private	String encMsg	= "";
	private	String msgChk	= "N";  

	public void decodeInfo(HttpServletRequest request) {
		
		//쿠키값 가져 오기
		Cookie[] cookies = request.getCookies();
		String cookiename = "";

		String cookiereqNum = "";
		if(cookies!=null){
			for (int i = 0; i < cookies.length; i++){
				Cookie c = cookies[i];
				cookiename = c.getName();
				cookiereqNum = c.getValue();
				if(cookiename.compareTo("reqNum")==0) break;
				
				cookiereqNum = null;
			}
		}

		try	{
			// 1. 암호화 모듈 (jar) Loading
			SciSecuManager sciSecuMg = new SciSecuManager();
	        
			//쿠키에서 생성한 값을 Key로 생성 한다.
			retInfo	= sciSecuMg.getDec(retInfo, cookiereqNum);

			// 2.1차 파싱---------------------------------------------------------------
			String[] aRetInfo1	= retInfo.split("\\^");

			encPara	= aRetInfo1[0];		//암호화된 통합 파라미터
			encMsg	= aRetInfo1[1];		//암호화된 통합 파라미터의 Hash값

			String  encMsg2   = sciSecuMg.getMsg(encPara);

			// 3.위/변조 검증 ---------------------------------------------------------------
			if(encMsg2.equals(encMsg)){
				msgChk="Y";
			}

			// 복호화 및 위/변조 검증 ---------------------------------------------------------------
			retInfo  = sciSecuMg.getDec(encPara, cookiereqNum);

			String[] aRetInfo = retInfo.split("\\^");

			name		= URLDecoder.decode( aRetInfo[0], "UTF-8" );
			birYMD	= aRetInfo[1];
			sex			= aRetInfo[2];        
			fgnGbn	= aRetInfo[3];
			di			= aRetInfo[4];
			ci1			= aRetInfo[5];
			ci2			= aRetInfo[6];
			civersion	= aRetInfo[7];
			reqNum	= aRetInfo[8];
			result		= aRetInfo[9];
			certGb		= aRetInfo[10];
			cellNo		= aRetInfo[11];
			cellCorp	= aRetInfo[12];
			certDate	= aRetInfo[13];
			addVar	= aRetInfo[14];
		}
		catch(Exception ex){
			//
		}
	}
	
	public	void	encodeInfo(HttpServletResponse response)	{
		Cookie	cookie	= new Cookie("reqNum", reqNum);
		//c.setMaxAge(1800);  // <== 필요시 설정(초단위로 설정됩니다)
		response.addCookie(cookie);

	    //01. 암호화 모듈 선언
		SciSecuManager	seed	= new SciSecuManager();

		//02. 1차 암호화
		String	info		= id+"^"+srvNo+"^"+reqNum+"^"+certDate+"^"+certGb+"^"+addVar+"^"+exVar;  // 데이터 암호화
		String	encStr		= seed.getEncPublic(info);

		//03. 위변조 검증 값 생성
		//SciHmac hmac = new SciHmac();
		//String hmacMsg = hmac.HMacEncriptPublic(encStr);
		String	hmacMsg	= SciHmac.HMacEncriptPublic(encStr);

		//03. 2차 암호화
		reqInfo	= seed.getEncPublic(encStr + "^" + hmacMsg + "^" + "0000000000000000");  //2차암호화
		//setReqInfo(reqInfo);
//		System.out.println("reqInfo =>" + reqInfo);
	}
	
	public	boolean	isPassMsg()	{	return	"Y".equals(msgChk);		}
	public	boolean	isSuccess()	{	return	("Y".equals(result) && isPassMsg() );		}

	public	String	getId	()	{	return	id	;	}
	public void	setId	( String pId )	{
		this.id	= pId;
	}
	
	public	String	getSrvNo	()	{	return	srvNo	;	}
	public void	setSrvNo	( String pSrvNo )	{
		this.srvNo	= pSrvNo;
	}
	
	public	String	getExVar	()	{	return	exVar	;	}
	public void	setExVar	( String pExVar )	{
		this.exVar	= pExVar;
	}
	
	public	String	getRetUrl	()	{	return	retUrl	;	}
	public void	setRetUrl	( String pRetUrl )	{
		this.retUrl	= pRetUrl;
	}

	public	String	getReqInfo	()	{	return	reqInfo	;	}
	public	void	setReqInfo	( String pReqInfo )	{
		this.reqInfo	= pReqInfo;
	}
	
	public	String	getRetInfo	()	{	return	retInfo	;	}
	public	void	setRetInfo	( String pRetInfo )	{
		this.retInfo	= pRetInfo;
	}

	public	String	getName		()	{	return	name		;	}
	public	String	getSex			()	{	return	sex			;	}
	public	String	getBirYMD	()	{	return	birYMD	;	}
	public	String	getFgnGbn	()	{	return	fgnGbn	;	}

	public	String	getDi			()	{	return	di			;	}
	public	String	getCi1			()	{	return	ci1			;	}
	public	String	getCi2			()	{	return	ci2			;	}
	public	String	getCiversion	()	{	return	civersion	;	}

	public	String	getReqNum	()	{	return	reqNum	;	}
	public void	setReqNum	( String pReqNum )	{
		this.reqNum	= pReqNum;
	}
	
	public	String	getResult		()	{	return	result		;	}
	public void	setResult	( String pResult )	{
		this.result	= pResult;
	}

	public	String	getCertDate	()	{	return	certDate	;	}
	public void	setCertDate	( String pCertDate )	{
		this.certDate	= pCertDate;
	}

	public	String	getCertGb	()	{	return	certGb		;	}
	public void	setCertGb	( String pCertGb )	{
		this.certGb	= pCertGb;
	}

	public	String	getCellNo		()	{	return	cellNo		;	}
	public	String	getCellCorp	()	{	return	cellCorp	;	}

	public	String	getAddVar	()	{	return	addVar	;	}
	public void	setAddVar	( String pAddVar )	{
		this.addVar	= pAddVar;
	}

	public	String	getPsnMemCd	()	{	return	psnMemCd	;	}
	public void	setPsnMemCd	( String pPsnMemCd )	{
		this.psnMemCd	= pPsnMemCd;
	}
	
	public	String getEncPara	()	{	return	encPara 	;	}
	public	String getEncMsg	()	{	return	encMsg	;	}

	public	String getMsgChk	()	{	return	msgChk	;	}
	public void	setMsgChk	( String pMsgChk )	{
		this.msgChk	= pMsgChk;
	}

}
