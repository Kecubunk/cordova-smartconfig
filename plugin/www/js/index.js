/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 * KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations
 * under the License.
 */
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
                             sq = q.value;
                             sf = f.value;
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
                                          [ sq , sf ]);
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
                                               'cordovaStopSedningData',
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
