function reply_write(){
	var f = document.reply_write;

	if(f.m_id.value==""){
		alert('로그인 후 이용 할 수 있습니다');
		return;
	}

	if(f.m_name.value==""){
		alert('로그인 후 이용 할 수 있습니다');
		return;
	}



	

	if(f.recontent.value=="" || f.recontent.value=="게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다."){
		alert('내용을 입력하세요');
		f.recontent.focus();
		return;
	}
	
	f.action="eventView_db.jsp";
	f.submit();
}


function reply_del(idx){
	var f = document.reply_write;
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="eventView_db.jsp";
		f.submit();
	}
}


