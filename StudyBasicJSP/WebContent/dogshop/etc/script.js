function checkForm(writeform){

	if(!writeform.goods_kind.value){
	  alert("제품의 분류를 선택하십시오");
	  writeform.goods_kind.focus();
	  return false;
	}
	if(!writeform.goods_name.value){
	  alert("제품의 이름을 입력하십시오");
	  writeform.goods_name.focus();
	  return false;
	}
	
	if(!writeform.goods_price.value){
	  alert("제품의 가격을 입력하십시오");
	  writeform.goods_price.focus();
	  return false;
	}
        
	if(!writeform.goods_count.value){
	  alert("제품의 수량을 입력하십시오");
	  writeform.goods_count.focus();
	  return false;
	}
	
	if(!writeform.goods_com.value){
	  alert("제조사를 입력하십시오");
	  writeform.goods_com.focus();
	  return false;
	}
	if(!writeform.goods_country.value){
		  alert("원산지를 입력하십시오");
		  writeform.goods_country.focus();
		  return false;
		}
	
	if(!writeform.goods_date.value){
	  alert("유통기한을 입력하십시오");
	  writeform.goods_date.focus();
	  return false;
	}
	
	if(!writeform.goods_content.value){
	  alert("제품의 설명을 입력하십시오");
	  writeform.goods_content.focus();
	  return false;
	}
		
	writeform.action = "goodsRegisterPro.jsp";
    writeform.submit();
	
 } 
 
 function updateCheckForm(writeform){

	 if(!writeform.goods_kind.value){
		  alert("제품의 분류를 선택하십시오");
		  writeform.goods_kind.focus();
		  return false;
		}
		if(!writeform.goods_name.value){
		  alert("제품의 이름을 입력하십시오");
		  writeform.goods_name.focus();
		  return false;
		}
		
		if(!writeform.goods_price.value){
		  alert("제품의 가격을 입력하십시오");
		  writeform.goods_price.focus();
		  return false;
		}
	        
		if(!writeform.goods_count.value){
		  alert("제품의 수량을 입력하십시오");
		  writeform.goods_count.focus();
		  return false;
		}
		
		if(!writeform.goods_com.value){
		  alert("제조사를 입력하십시오");
		  writeform.goods_com.focus();
		  return false;
		}
		
		if(!writeform.goods_date.value){
		  alert("유통기한을 입력하십시오");
		  writeform.goods_date.focus();
		  return false;
		}
		if(!writeform.goods_country.value){
			  alert("원산지를 입력하십시오");
			  writeform.goods_country.focus();
			  return false;
			}
		
		if(!writeform.goods_content.value){
		  alert("제품의 설명을 입력하십시오");
		  writeform.goods_content.focus();
		  return false;
		}
		
	writeform.action = "goodsUpdatePro.jsp";
    writeform.submit();
	
 } 
 