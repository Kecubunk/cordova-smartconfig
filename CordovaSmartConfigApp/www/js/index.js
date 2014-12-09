(function(){
	var app = {
		initialize: function() {
			this.bindEvents();
		},
		// Bind Event Listeners
		//
		// Bind any events that are required on startup. Common events are:
		// 'load', 'deviceready', 'offline', and 'online'.
		bindEvents: function() {
			document.addEventListener('deviceready', this.onDeviceReady, false);
		},
		// deviceready Event Handler
		//
		// The scope of 'this' is the event. In order to call the 'receivedEvent'
		// function, we must explicitly call 'app.receivedEvent(...);'
		onDeviceReady: function() {
			console.log('device is ready');

			/**
			 * Logger doesn't always init, this will init it when we're ready.
			 */
			if (window.cordova.logger) {
				window.cordova.logger.__onDeviceReady();
			}

			//cordova.plugins.SmartConfig.init();

		}
	};

	app.initialize();

	window.form = {
		key : null,
		password : null,
		ssid : null,
		devname : null
	};

	var startButton = document.getElementById('startButton');
	var stopButton = document.getElementById('stopButton');

	startButton.addEventListener('click', function(e){
		form.key = document.getElementById('key').value;
		form.password = document.getElementById('password').value;
		form.ssid = document.getElementById('ssid').value;
		form.devname = document.getElementById('devname').value;

		cordova.plugins.SmartConfig.startSending(form);

		e.preventDefault();
	})

	stopButton.addEventListener('click', function(e){
		cordova.plugins.SmartConfig.stopSending();
		e.preventDefault();
	});
})();
