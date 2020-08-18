<%!
	
	public String Sdate1(){

		long now = System.currentTimeMillis();
		SimpleDateFormat form = new SimpleDateFormat("yyyy.MM.dd.HH:mm:ss");
		String strNow = form.format(new java.util.Date(now));	

		return strNow;
	} 

	public String Sdate2(){
	
		java.util.Date date = new java.util.Date(); 
		return date.toLocaleString();
	}	




%>
