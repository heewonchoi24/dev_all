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
	
	f.action="choiPostView_db.jsp";
	f.submit();
}


function reply_del(idx){
	var f = document.reply_write;
	if(confirm("�����Ͻðڽ��ϱ�?")){
		f.mode.value = "del";
		f.reply_idx.value = idx;
		f.action="choiPostView_db.jsp";
		f.submit();
	}
}


function board_id_del(id){
	var f = document.vform;
	if(confirm("�����Ͻðڽ��ϱ�?")){
		f.id.value = id;
		f.mode.value = "del";
		f.action="choiPostWrite_db.jsp";
		f.submit();
	}
}

