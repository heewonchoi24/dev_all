function reply_write(){
	var f = document.reply_write;

	if(f.m_id.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680");
		return;
	}

	if(f.m_name.value==""){
		$.lightbox("/shop/popup/loginCheck.jsp?lightbox[width]=640&lightbox[height]=680");
		return;
	}

	if(f.content.value=="" || f.content.value=="�Խ��ǰ� ������ �弳, ���, �������� ���Ƿ� ������ �� �ֽ��ϴ�."){
		alert('������ �Է��ϼ���');
		f.content.focus();
		return;
	}
	
	f.action="eventView_db.jsp";
	f.submit();
}

function reply_del(idx){
	var f = document.reply_write;
	if(confirm("�����Ͻðڽ��ϱ�?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="eventView_db.jsp";
		f.submit();
	}
}


