function postWrite(){

	var f = document.frm;

	if (typeof(mini_obj)!="undefined" || document.getElementById('_mini_oHTML')) mini_editor_submit();
	if(f.category.value == ""){
		alert('�з��� �����ϼ���');
		f.category.focus();
		return;
	}

	if(f.title.value == ""){
		alert('������ �Է��ϼ���');
		f.title.focus();
		return;
	}

	if(f.content.value == ""){
		alert('������ �Է��ϼ���');
		f.content.focus();
		return;
	}
	
	f.submit();

}