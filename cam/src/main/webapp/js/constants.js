//var config = $http.get('resources/config.json');    
var BACK_END_URL_CONST="http://"+window.location.host+"/CAMService";
var INVALID_NAME_MSG="Please insert valid name";
var NAME_IS_MANDATORY_MSG="Name is mandatory";
var REGEX_PATTERN="^d*[A-Za-z0-9_@./+-]*$";
var HTTP_TIMEOUT = 10000; //expressed in milliseconds
var HTTP_TIMEOUT_EXPIRED_MSG="System not available at the moment :-(\nPlease try later!";
