cordova.define("com.ideacouture.SmartConfig.SmartConfig", function(require, exports, module) { var cordova = require('cordova'),
	exec = require('cordova/exec');

var SmartConfigPlugin = function() {
        this.options = {};
};

SmartConfigPlugin.prototype = {
    init: function() {

		// should handle event bindings from plugin here

		console.log('initted');

    },

	/**
	 * Start sending data to the SmartConfig Board.
	 */
	startSending: function(formdata) {

		console.log("Request sent to SmartConfig Plugin");
		console.log(formdata);

		var success = function callback(data) {
			console.log('startSending success');
			console.log(data);
		};

		var error = function errorHandler(err) {
			console.log('startSending error');
			console.log(err);
		};

		cordova.exec(
			success,
			error,
			'SmartConfig',
			'cordovaSendData',
			[formdata.key, formdata.password, formdata.ssid, formdata.devname]
		);
	},

	/**
	 * Stop sending data to the SmartConfig Board.
	 */
	stopSending: function() {

		console.log("Request canceled via SmartConfig Plugin");

		var success = function callback(data) {
			console.log('stopSending success');
			console.log(data);
		};

		var error = function errorHandler(err) {
			console.log('stopSending error');
			console.log(err);
		};

		cordova.exec(
			success,
			error,
			'SmartConfig',
			'cordovaStopSendingData',
			[]
		);

	},

};

var SmartConfigPlugin = new SmartConfigPlugin();

module.exports = SmartConfigPlugin;

/**
var app = {
initialize: function() {
    console.log('returned call back');
    this.bindEvents();
},
    // Bind Event Listeners
    //
    // Bind any events that are required on startup. Common events are:
    // 'load', 'deviceready', 'offline', and 'online'.
bindEvents: function() {
    document.addEventListener('deviceready', this.onDeviceReady, false);
    document.addEventListener('networkunreachable', this.onNetWorkUnreachAble, false);
    document.addEventListener('networkreachableagain', this.onNetWorkReachAble, false);
    document.addEventListener('deviceDidEnterBackground', this.onDeviceEnterBackground, false);
    document.addEventListener('deviceNowForeground', this.onDeviceForeground, false);
    document.addEventListener('exceptionWhileTransmit', this.onExceptionWhileTransmit, false);
    document.addEventListener('receivedAckFromDevice', this.onReceivedAckFromDevice, false);
    document.addEventListener('transmitStopByException', this.onTransmitStopByException, false);
},
    
onDeviceReady: function() {
    var contentsDiv    = document.getElementById('fileContentsDiv'),
    sendBtn = document.getElementById('actionButton');
    cordova.exec(
                 function callback(data) {
                 inputSSID = document.getElementById ('issid');
                 inputSSID.value = data.dateStr;
                 },
                 function errorHandler(err) {
                 alert('Error');
                 },
                 'ChipInterface',
                 'cordovaGetSSID',
                 [ ]
                 );
    cordova.exec(
                 function callback(data) {
                 a = document.getElementById ('igatewaya');
                 console.log("returndata" + a);
                 a.value = data.dateStr;
                 },
                 function errorHandler(err) {
                 alert('Error');
                 },
                 'ChipInterface',
                 'cordovaGetGateWayAddress',
                 [ ]
                 );
    cordova.exec(
                 function callback(data) {
                 a = document.getElementById ('idevname');
                 console.log("returndata" + a);
                 a.value = data.dateStr;
                 },
                 function errorHandler(err) {
                 alert('Error');
                 },
                 'ChipInterface',
                 'cordovaGetGateDeviceName',
                 [ ]
                 );
    
    cordova.exec(
                 function callback(data) {
                 console.log('add Listner now');
                 },
                 function errorHandler(err) {
                 },
                 'ChipInterface',
                 'cordovaStartToCheckNetworkState',
                 [ ]
                 );
    
    //Set file contents
    sendBtn.addEventListener('click', function() {
                             d = document.getElementById('actionButton').innerHTML;
                             console.log("hahaha"+d);
                             if ( d == 'start'){
                             q = document.getElementById ('ikey');
                             f = document.getElementById ('ipassword');
                             s = document.getElementById ('issid');
                             d = document.getElementById ('idevname');
                             sq = q.value;
                             sf = f.value;
                             ss = s.value;
                             sd = d.value;
                             cordova.exec(
                                          function callback(data) {
                                          console.log('start sending');
                                          a = document.getElementById('actionButton');
                                          console.log("buuton is" + a);
                                          a.value = "stop";
                                          a.innerHTML = "stop";
                                          },
                                          function errorHandler(err) {
                                          alert('Error');
                                          },
                                          'ChipInterface',
                                          'cordovaSendData',
                                          [ sq , sf , ss, sd]);
                              }else
                              {
                             console.log("stopp!!");
                                  cordova.exec(
                                               function callback(data) {
                                               console.log('stop sending');
                                               a = document.getElementById('actionButton');
                                               console.log("buuton is" + a);
                                               a.value = "start";
                                               a.innerHTML = "start";
                                               },
                                               function errorHandler(err) {
                                               alert('Error');
                                               },
                                               'ChipInterface',
                                               'cordovaStopSendingData',
                                               []);
                              }
                        });
    
},

onNetWorkUnreachAble: function() {
    console.log('Warning: Network Not Reachable');
},
onNetWorkReachAble: function() {
    console.log('Warning: Network Reachable');
},
onDeviceEnterBackground: function() {
    console.log('Did Enter Background');
    a = document.getElementById('actionButton');
    console.log("buuton is" + a);
    a.value = "start";
    a.innerHTML = "start";    // change the transmit state
},
onDeviceForeground: function() {
    console.log('Did Enter Foreground');
},
onExceptionWhileTransmit: function() {
    a = document.getElementById('actionButton');
    console.log("buuton is" + a);
    a.value = "start";
    a.innerHTML = "start";

    // state is start again
},
onReceivedAckFromDevice: function() {
    a = document.getElementById('actionButton');
    console.log("buuton is" + a);
    a.value = "start";
    a.innerHTML = "start";
 
},
onTransmitStopByException: function() {
    a = document.getElementById('actionButton');
    console.log("buuton is" + a);
    a.value = "start";
    a.innerHTML = "start";
    //state is start again
}

};
**/

});
