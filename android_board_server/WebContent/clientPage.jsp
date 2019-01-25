<!DOCTYPE html>
<html>
<head>
  
  <title>Native WebSocket Example</title>
</head>

 
<body>
<script>
  // 웹소켓 전역 객체 생성
  var ws = new WebSocket("ws://172.30.1.30:5050");

  // 연결이 수립되면 서버에 메시지를 전송한다
/*   ws.onopen = function(event) {
    ws.send("Client message: Hi!");
  }  */
  ws.onopen = function(event) {
	    
	  } 
  
  
  function button1_click() {
		//alert(document.getElementById('text').value);
	  
		//ws.send(document.getElementById('text').value); 

	  
	  var personArray = new Array();
      
      var personInfo = new Object();
       
      personInfo.addr = "11";
         
      personArray.push(personInfo);
       
       
      personInfo = new Object();
       
      personInfo.addr = "21";
       
      personArray.push(personInfo);
      
      personInfo = new Object();
      
      personInfo.addr = "31";
       
      personArray.push(personInfo);

var totalInfo = new Object();
       
      totalInfo.client = personArray;

var jsonInfo = JSON.stringify(totalInfo);

ws.send(jsonInfo);
	}
  
  
  // 서버로 부터 메시지를 수신한다
  ws.onmessage = function(event) {
	  
	  alert(event.data);
    	console.log("Server message: ", event.data);
  }

  // error event handler
  ws.onerror = function(event) {
    console.log("Server error message: ", event.data);
  }
  
  
  
  
</script>

<input type="text" id="text" />
<input type="button" id="button" value="send" onclick="button1_click();"/>


<input type="text" id="textIp" value="<%=request.getRemoteAddr() %>" />

</body>
</html>