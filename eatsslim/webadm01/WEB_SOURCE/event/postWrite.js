function postWrite(){

	var f = document.frm;

	if (typeof(mini_obj)!="undefined" || document.getElementById('_mini_oHTML')) mini_editor_submit();
	if(f.category.value == ""){
		alert('분류를 선택하세요');
		f.category.focus();
		return;
	}

	if(f.title.value == ""){
		alert('제목을 입력하세요');
		f.title.focus();
		return;
	}

	if(f.content.value == ""){
		alert('내용을 입력하세요');
		f.content.focus();
		return;
	}
	
	f.submit();

}