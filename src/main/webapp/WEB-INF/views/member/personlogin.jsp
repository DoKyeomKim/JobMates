<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>취업동무</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f7f7;
        margin: 0;
        padding: 0;
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }
    
    main {
        background-color: #fff;
        padding: 40px;
        border-radius: 10px;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        width: 300px;
    }
    
    main h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #054FA3;
    }
    
    form {
        text-align: center;
    }
    
    table {
        margin: 0 auto;
    }
    
    table td {
        padding: 20px 0;
    }
    
    input[type="text"],
    input[type="password"],
    input[type="submit"],
    input[type="button"] {
        width: calc(100% - 24px);
        padding: 12px;
        margin-bottom: 20px;
        border: 1px solid #ddd;
        border-radius: 8px;
        box-sizing: border-box;
        font-size: 16px;
        transition: box-shadow 0.3s;
    }
    
    input[type="text"]:focus,
    input[type="password"]:focus {
        outline: none;
        box-shadow: 0 0 5px #054FA3;
    }
    
    input[type="submit"] {
        background-color: #054FA3;
        color: white;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    input[type="submit"]:hover {
        background-color: #1e7fd7;
    }
    
    input[type="button"] {
        background-color: #ccc;
        color: #fff;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    
    input[type="button"]:hover {
        background-color: #999;
    }
    
    .icon {
        position: absolute;
        top: 50%;
        transform: translateY(-50%);
        left: 10px;
        color: #aaa;
    }
    #perlog, #comlog {
    display: inline-block;
    padding: 10px 20px;
    margin: 0 10px;
    background-color: #054FA3;
    color: white;
    border-radius: 5px;
    text-decoration: none;
    transition: background-color 0.3s;
}

#perlog:hover, #comlog:hover {
    background-color: #1e7fd7;
}
</style>
</head>
<body>
  <main>
	<div class="main">
        <a href="/personlogin">
            <img alt="Logo" src="/images/logo.png" style="width:250px;  margin-top : 20px;">
        </a><br><br><br>
    </div>
    <table id="login">
    	<form action="/personlogin" method="POST">
     <tr>
	   <td>아이디</td>
	   <td><input type="text" name="userId" id="userId" /></td>
	 </tr>
	 <tr>
	   <td>비밀번호</td>
	   <td><input type="password" name="userPw" id="userPw" /></td>
	 </tr>	
        <tr>
            <td><a href="redirect:/personlogin" id="perlog">개인회원</a></td>
            <td><a href="/companylogin" id="comlog">기업회원</a></td>
        </tr>
   
	
	 <tr>
	   <td colspan="2">
	    <input type="submit" value="로그인" />
	    <input type="button" value="취소" id="goList" />
	   </td>
	 </tr>
	
	</table>	
	
  </main>
  
  <script>
  	const  goListEl  = document.getElementById('goList');
  	goListEl.addEventListener('click', function(e) {
  		location.href = '/';
  	})
  	
  
  
  </script>

  
  
</body>
</html>





