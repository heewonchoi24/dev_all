function reply_write(){
	var f = document.reply_write;

	if(f.m_id.value==""){
		alert('�α��� �� �̿� �� �� �ֽ��ϴ�');
		return;
	}

	if(f.m_name.value==""){
		alert('�α��� �� �̿� �� �� �ֽ��ϴ�');
		return;
	}



	

	if(f.recontent.value=="" || f.recontent.value=="�Խ��ǰ� ������ �弳, ���, �������� ���Ƿ� ������ �� �ֽ��ϴ�."){
		alert('������ �Է��ϼ���');
		f.recontent.focus();
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


