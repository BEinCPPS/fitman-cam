//var BACK_END_URL_CONST = PROTOCOL + window.location.hostname + ":8080/CAMService";
var PROTOCOL = 'http://';
var BACK_END_URL_CONST = PROTOCOL + window.location.host + "/CAMService";
var CAM_URL = PROTOCOL + window.location.host + '/CAM';

var INVALID_NAME_MSG = 'Please insert valid name"'
var NAME_IS_MANDATORY_MSG = 'Name is mandatory';
var REGEX_PATTERN = "^d*[A-Za-z0-9_@\/+-]*$";
var REGEX_URL_VALIDATOR = '/https?\:\/\/\w+((\:\d+)?\/\S*)?/';
var HTTP_TIMEOUT = 20000; //expressed in milliseconds
var HTTP_TIMEOUT_EXPIRED_MSG = 'System not available at the moment!\nPlease try later!';
var ATTRIBUTES = 'attributes';
var RELATIONSHIPS = 'relationships';


var KEYROCK_URL = 'http://161.27.159.76';
var client_id = '6a636dc9ff1d4e4395ae01c60fb9d3b5';

var KEYROCK_SIGNUP_URL = KEYROCK_URL + '/sign_up';
var KEYROCK_CHANGE_USER_URL = KEYROCK_URL + '/auth/logout';
var callback_uri = CAM_URL + '/oauth_callback.html';
var OAUTH_LOGIN_URL = KEYROCK_URL + '/oauth2/authorize?response_type=token&client_id=' + client_id +
    '&redirect_uri=' + callback_uri;
var OAUTH_USER_LOGGED_URL = KEYROCK_URL + '/user?access_token=';

const EVERYTHING = '(EVERYTHING)';
const NO_DOMAIN = 'NO_DOMAIN';
const OAUTH = 'oAuth';
const AUTH = 'auth';

const GROUPING_CLASS_TYPE = "class";
const GROUPING_DOMAIN_TYPE = "domain";
const GROUPING_ORION_CONFIG_TYPE = "orionConfig";