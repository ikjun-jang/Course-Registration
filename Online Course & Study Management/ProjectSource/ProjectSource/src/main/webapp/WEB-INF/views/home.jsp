<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="en-gb" dir="ltr" class="uk-height-1-1">

    <head>
        <meta charset="utf-8">
        <title>Course Management Login</title>
        <link rel="shortcut icon" href="http://getuikit.com/docs/images/favicon.ico" type="image/x-icon">
        <link rel="apple-touch-icon-precomposed" href="http://getuikit.com/docs/images/apple-touch-icon.png">
        <link rel="stylesheet" href="http://getuikit.com/docs/css/uikit.docs.min.css">
        <link rel="stylesheet" href="resources/uilibs/css/uikit.docs.min.css">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="resources/uilibs/js/uikit.min.js"></script>
        <style>
	        .myError{
	        	color: red;
	        }
        </style>
        <script>
        	function userLogin(){
        		userId = document.getElementById("myUserName").value;
        		userPwd = document.getElementById("myPassword").value;
        		userPwd = scramblePwd(userPwd);
        		myUrl = "http://localhost:8085/coursemgmt/verifyUser?userId="+userId+"&userPwd="+userPwd;
        		//alert("User name:" + userId + "Pwd" + userPwd);
        		window.location.href = myUrl;
        		
        	}
        	function scramblePwd(pwd){
        		var scrambleStr = "blakeadeGRadedgDfefgAHbalkdaieseSGdgHsASwdfsdasZkabanGZXaffDgsADfdAD";
        		var newPwd = scrambleStr;
        		for(i=0;i<pwd.length;i++){
        			newPwd = newPwd + pwd.charAt(i) + scrambleStr;
        		}
        		return newPwd;
        	}
        </script>
    </head>
    <body class="uk-height-1-1">
	<div class="uk-grid">
	    <div class="uk-width-1-1"><img class="uk-width-1-1" height="50" src="resources/uilibs/images/Header.JPG" alt=""></div>
    </div>
    <c:if test="${loginRes == 0}">
    <p class="myError"> Error: User name or Password did not match! </p>
    </c:if>
        <div class="uk-vertical-align uk-text-center uk-height-1-1">
            <div class="uk-vertical-align-middle" style="width: 250px;">

                <img class="uk-margin-bottom" width="250" height="120" src="resources/uilibs/images/logo.JPG" alt="">

                <form class="uk-panel uk-panel-box uk-form">
                    <div class="uk-form-row">
                        <input class="uk-width-1-1 uk-form-large" type="text" placeholder="Username" id="myUserName">
                    </div>
                    <div class="uk-form-row">
                        <input class="uk-width-1-1 uk-form-large" type="password" placeholder="Password" id="myPassword">
                    </div>
                    <div class="uk-form-row">
                        <a class="uk-width-1-1 uk-button uk-button-primary uk-button-large" onclick="userLogin()">Login</a>
                    </div>
                    <div class="uk-form-row uk-text-small">
                        <label class="uk-float-left"><input type="checkbox"> Remember Me</label>
                        <a class="uk-float-right uk-link uk-link-muted" href="http://getuikit.com/docs/layouts_login.html#">Forgot Password?</a>
                    </div>
                </form>

            </div>
        </div>    
	</body>
</html>
