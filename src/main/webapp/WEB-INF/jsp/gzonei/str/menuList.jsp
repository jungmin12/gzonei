<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<ul>
	<li><a href="/str/strBbsArticleList.do">전체 보기</a></li>
 	<li><a href="/str/gzstrSelectCase.do?se=0">전문가도 놀란 보상 경·공매 성공사례</a></li>
	<li><a href="/str/gzstrSelectCase.do?se=1">전문가도 놀란 보상 경·공매 실패사례</a></li>
	<!-- <li><a href="/str/selectGzStrList.do?se=0">전문가도 놀란 보상 경·공매 성공사례</a></li> -->
	<!-- <li><a href="/str/selectGzStrList.do?se=1">전문가도 놀란 보상 경·공매 실패사례</a></li> -->
	<!-- <li><a href="/str/gzPubBook.do">지존출판도서</a></li> -->
</ul>
<form name="searchForm" method="POST">
	<input type="hidden" name="se" value="${se}" />
	<select name="category">
		<!-- <option value="bbs_no">글번호</option> -->
		<option value="sj">제목</option>
		<option value="cn">내용</option>
	</select> <input type="text" name="nttSj" value="${nttSj}" />
	<button class="search_btn">검색</button>
</form>