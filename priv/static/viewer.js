let token = '';
let tuid = '';

const twitch = window.Twitch.ext;

// create the request options for our Twitch API calls
const requests = {
  set: createRequest('POST', 'cycle'),
  get: createRequest('GET', 'query')
};

function createRequest (type, method) {
  return {
    type: type,
    url: location.protocol + '//localhost:4001/color/' + method,
    success: updateBlock,
    error: logError
  };
}

function setAuth (token) {
  Object.keys(requests).forEach((req) => {
    twitch.rig.log('Setting auth headers');
    requests[req].headers = { 'Authorization': 'Bearer ' + token };
  });
}

twitch.onContext(function (context) {
  twitch.rig.log(context);
});

twitch.onAuthorized(function (auth) {
  // save our credentials
  token = auth.token;
  tuid = auth.userId;

  twitch.rig.log('Token: ' + token);

  // enable the button
  $('#cycle').removeAttr('disabled');

  setAuth(token);
  // $.ajax(requests.get);
});

function updateBlock (hex) {
  if (hex.length == 0) {
    return;
  }
  twitch.rig.log('Updating block color with: ' + hex);
  $('#color').css('background-color', hex);
}

function logError(_, error, status) {
  twitch.rig.log('EBS request returned '+status+' ('+error+')');
}

function logSuccess(hex, status) {
  twitch.rig.log('EBS request returned '+hex+' ('+status+')');
}

$(function () {
  // when we click the cycle button
  $('#cycle').click(function () {
  if(!token) { return twitch.rig.log('Not authorized'); }
    twitch.rig.log('Requesting a color cycle');
    $.ajax(requests.set);
  });

  // listen for incoming broadcast message from our EBS
  twitch.listen('broadcast', function (target, contentType, color) {
    twitch.rig.log('Received broadcast contentType: ' + contentType);
    twitch.rig.log('Received broadcast target: ' + target);
    twitch.rig.log('Received broadcast color: ' + color);
    updateBlock(color);
  });
});
