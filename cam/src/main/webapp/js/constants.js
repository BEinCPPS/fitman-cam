//var BACK_END_URL_CONST = PROTOCOL + window.location.hostname + ":8080/CAMService";
var PROTOCOL = 'http://';
var BACK_END_URL_CONST = PROTOCOL + window.location.host + "/CAMService";
var CAM_URL = PROTOCOL + window.location.host + '/Asset-Registry-for-CPPS';

var INVALID_NAME_MSG = 'Please insert valid name"'
var NAME_IS_MANDATORY_MSG = 'Name is mandatory';
var REGEX_PATTERN = "^d*[A-Za-z0-9_@\/+-]*$";
var REGEX_URL_VALIDATOR = '/https?\:\/\/\w+((\:\d+)?\/\S*)?/';
var HTTP_TIMEOUT = 20000; //expressed in milliseconds
var HTTP_TIMEOUT_EXPIRED_MSG = 'System not available at the moment!\nPlease try later!';
var ATTRIBUTES = 'attributes';
var RELATIONSHIPS = 'relationships';


var HORIZON_URL = '${horizon.url}';
var client_id = '${client.id}';

var KEYROCK_SIGNUP_URL = HORIZON_URL + '/sign_up';
var KEYROCK_CHANGE_USER_URL = HORIZON_URL + '/auth/logout';
var callback_uri = CAM_URL + '/oauth_callback.html';
var OAUTH_LOGIN_URL = HORIZON_URL + '/oauth2/authorize?response_type=token&client_id=' + client_id +
    '&redirect_uri=' + callback_uri;
var OAUTH_USER_LOGGED_URL = HORIZON_URL + '/user?access_token=';

var EVERYTHING = '(ALL ASSETS)';
var NO_DOMAIN = 'NO_DOMAIN';
var OAUTH = 'oAuth';
var AUTH = 'auth';

var GROUPING_CLASS_TYPE = "class";
var GROUPING_DOMAIN_TYPE = "domain";
var GROUPING_ORION_CONFIG_TYPE = "orionConfig";

var NGSI_PREFIX = 'ngsi_';
