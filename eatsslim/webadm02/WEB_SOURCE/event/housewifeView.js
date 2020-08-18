function reply_write(){
	var f = document.reply_write;

	if(f.m_id.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350");
		return;
	}

	if(f.m_name.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=600&lightbox[height]=350");
		return;
	}	

	if(f.content.value=="" || f.content.value=="게시판과 무관한 욕설, 비방, 광고댓글은 임의로 삭제될 수 있습니다."){
		alert('내용을 입력하세요');
		f.content.focus();
		return;
	}
	
	f.action="housewifeView_db.jsp";
	f.submit();
}

function reply_del(idx){
	var f = document.reply_write;
	if(confirm("삭제하시겠습니까?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="housewifeView_db.jsp";
		f.submit();
	}
}


