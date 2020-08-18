// WRITE 권한 체크
function authCheckWrite(){
	if(authWrite != 'Y') {
		alert('권한이 없습니다.'); return false;
	}else { 
		return true;
	}
}


// DOWNLOAD 권한 체크
function authCheckDwn(){
	if(authDwn != 'Y') {
		alert('권한이 없습니다.'); return false;
	}else { 
		return true;
	}
}