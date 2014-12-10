//
//  ChipInterface.m
//  chipplugin
//
//  Created by Lion on 11/19/14.
//
//

#import "ChipInterface.h"
#import "FirstTimeConfig.h"
int const MDNSRestartTime = 15;

@implementation ChipInterface
- (void) cordovaGetFileContents:(CDVInvokedUrlCommand *)command {
    NSString *dateStr = [self getFileContents];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cordovaSetFileContents:(CDVInvokedUrlCommand *)command {
    NSString *dateStr = [command.arguments objectAtIndex:0];
    [self setFileContents: dateStr];
    
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void) cordovaGetWifiNetworkState:(CDVInvokedUrlCommand *)command
{
    
}
- (void) cordovaGetSSID:(CDVInvokedUrlCommand*)command
{
    NSString *dateStr = [FirstTimeConfig getSSID];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void) cordovaGetGateWayAddress:(CDVInvokedUrlCommand*)command
{
    NSString *dateStr = [FirstTimeConfig getGatewayAddress];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void) cordovaGetGateDeviceName:(CDVInvokedUrlCommand*)command
{
    NSString *dateStr = @"CC3000";
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             dateStr, @"dateStr",
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cordovaStartToCheckNetworkState:(CDVInvokedUrlCommand*)command
{
    [self startCheckNetworkState];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
- (void) cordovaSendData:(CDVInvokedUrlCommand*)command
{
    NSString *arg1_password = command.arguments[1];
    NSString *arg2_key = command.arguments[0];
    NSString *arg2_devname = command.arguments[3];
    NSString *arg2_ssid = command.arguments[2];
    
    if ( [arg1_password length] == 0)
        arg1_password = nil;
    if ( [arg2_key length] == 0)
        arg2_key = nil;
    if ( [arg2_devname length] == 0)
        arg2_devname = nil;
    if ( [arg2_ssid length] == 0)
        arg2_ssid = nil;
    [self startTransmitting:arg1_password key:arg2_key deviceName:arg2_devname ssid:arg2_ssid];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) cordovaStopSendingData:(CDVInvokedUrlCommand*)command
{
    [self stopAction];
    NSDictionary *jsonObj = [ [NSDictionary alloc]
                             initWithObjectsAndKeys :
                             @"true", @"success",
                             nil
                             ];
    
    CDVPluginResult *pluginResult = [ CDVPluginResult
                                     resultWithStatus    : CDVCommandStatus_OK
                                     messageAsDictionary : jsonObj
                                     ];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
#pragma mark - Util_Methods
- (void)pluginInitialize
{
    globalConfig = [SmartConfigGlobalConfig getInstance];
    mdnsService = [SmartConfigDiscoverMDNS getInstance];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceAdded:)
                                                 name:@"deviceFound"
                                               object:nil];
    deviceName = @"CC3000";
}
-(void)deviceAdded:(id)sender
{
    [self stopDiscovery];
    //[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('receivedAckFromDevice');"];
    [self.commandDelegate evalJs:@"cordova.SmartConfigPlugin.receivedAckFromDevice();"];
}
-(void) stopDiscovery {
    [mdnsTimer invalidate];
    //self.discoveryInProgress = NO;
    [firstTimeConfig stopTransmitting];
    [self mDnsDiscoverStop];
    
    
}

- (void) mDnsDiscoverStart {
    [mdnsService startMDNSDiscovery:deviceName];
}

- (void) mDnsDiscoverStop {
    [mdnsService stopMDNSDiscovery];
    
}

-(void) disconnectFromLibrary
{
    firstTimeConfig = nil;
}
-(void) connectLibrary
{
    @try {
        [self disconnectFromLibrary];
        
        //passwordKey = @"";
        //paddedEncryptionKey = @"";
        
        NSData *encryptionData = [paddedEncryptionKey length] ? [paddedEncryptionKey dataUsingEncoding:NSUTF8StringEncoding] : Nil;
        
        freeData = [NSData alloc];
        if([deviceName length])
        {
            char freeDataChar[[deviceName length] + 3];
            // prefix
            freeDataChar[0] = 3;
            
            // device name length
            freeDataChar[1] = [deviceName length];
            
            for(int i = 0; i < [deviceName length]; i++)
            {
                freeDataChar[i+2] = [deviceName characterAtIndex:i];
            }
            
            // added terminator
            freeDataChar[[deviceName length] + 2] = '\0';
            
            NSString *freeDataString = [[NSString alloc] initWithCString:freeDataChar encoding:NSUTF8StringEncoding];
            NSLog(@"free data char %s", freeDataChar);
            freeData = [freeDataString dataUsingEncoding:NSUTF8StringEncoding ];
            
        }
        else
        {
            freeData = [@"" dataUsingEncoding:NSUTF8StringEncoding];
        }
        
        //        self.debugField.text = [[NSString alloc] initWithData:freeData encoding:NSUTF8StringEncoding];
        NSString *ipAddress = [FirstTimeConfig getGatewayAddress];
        firstTimeConfig = [[FirstTimeConfig alloc] initWithData:ipAddress withSSID:ssId withKey:passwordKey withFreeData:freeData withEncryptionKey:encryptionData numberOfSetups:4 numberOfSyncs:10 syncLength1:3 syncLength2:23 delayInMicroSeconds:1000];
        
        [self mDnsDiscoverStart];
        // set timer to fire mDNS after 15 seconds
        mdnsTimer = [NSTimer scheduledTimerWithTimeInterval:MDNSRestartTime target:self selector:@selector(mDnsDiscoverStart) userInfo:nil repeats:NO];
        
        
        
    }
    @catch (NSException *exception) {
        NSLog(@"%s exception == %@",__FUNCTION__,[exception description]);
        [self.commandDelegate evalJs:@"cordova.SmartConfigPlugin.transmitStopByException();"];
        //[self performSelectorOnMainThread:@selector(alertWithMessage:) withObject:[exception description] waitUntilDone:NO];
    }
    
}


- (void) sendAction
{
    @try {
        NSLog(@"%s begin", __PRETTY_FUNCTION__);
        [firstTimeConfig transmitSettings];
        NSLog(@"%s end", __PRETTY_FUNCTION__);
    }
    @catch (NSException *exception) {
        NSLog(@"exception === %@",[exception description]);
        // send exception
        //[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('exceptionWhileTransmit',null, true);"];
        [self.commandDelegate evalJs:@"cordova.SmartConfigPlugin.exceptionWhileTransmit();"];
    }

    @finally {
            }
}


-(void) stopAction{
    NSLog(@"%s begin", __PRETTY_FUNCTION__);
    @try {
        [self stopDiscovery];
    }
    @catch (NSException *exception) {
        NSLog(@"%s exception == %@",__FUNCTION__,[exception description]);
    }
    @finally {
        
    }
    NSLog(@"%s end", __PRETTY_FUNCTION__);
}

- (void)startTransmitting :(NSString*) ppassword key:(NSString*) keyValue deviceName:(NSString*) deviceName1 ssid:(NSString*)ssid{
    @try {
        QNetworkStatus netStatus = [wifiReachability currentReachabilityStatus];
        if ( netStatus == QNotReachable ){// No activity if no wifi
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('transmitStopByException');"];
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkunreachable');"];
            return;
        }
        passwordKey = ppassword;
        paddedEncryptionKey = keyValue;
        deviceName = deviceName1;
        ssId = ssid;
        [self connectLibrary];
        if (firstTimeConfig == nil) {
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('transmitStopByException');"];
            return;
        }
        [self sendAction];
    }
    @catch (NSException *exception) {
        NSLog(@"%s exception == %@",__FUNCTION__,[exception description]);
         [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('transmitStopByException');"];
    }
    @finally {
    }
}


- (void) setFileContents:(NSString *)fileContents {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/myTextFile.txt", documentsDirectory];
    
    [fileContents writeToFile : fileName
                  atomically  : NO
                  encoding    : NSStringEncodingConversionAllowLossy
                  error       : nil];
}

- (void) startCheckNetworkState{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wifiStatusChanged:) name:kReachabilityChangedNotification object:nil];
    wifiReachability = [Reachability reachabilityForLocalWiFi];
    [wifiReachability connectionRequired];
    [wifiReachability startNotifier];
    QNetworkStatus netStatus = [wifiReachability currentReachabilityStatus];
    if ( netStatus == QNotReachable ) {// No activity if no wifi
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkunreachable');"];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterInBackground:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnterInforground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (NSString *) getFileContents{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fileName = [NSString stringWithFormat:@"%@/myTextFile.txt", documentsDirectory];
    
    NSString *fileContents = [[NSString alloc]
                              initWithContentsOfFile : fileName
                              usedEncoding           : nil
                              error                  : nil
                              ];
    
    return fileContents;
}

#pragma network notification
/*
 Notification method handler when app enter in forground
 @param the fired notification object
 */
- (void)appEnterInforground:(NSNotification*)notification{
    NSLog(@"%s", __func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('deviceNowForeground');"];
}

/*
 Notification method handler when app enter in background
 @param the fired notification object
 */

- (void)appEnterInBackground:(NSNotification*)notification{
    NSLog(@"%s", __func__);
    [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('deviceDidEnterBackground');"];
}

/*
 Notification method handler when status of wifi changes
 @param the fired notification object
 */
- (void)wifiStatusChanged:(NSNotification*)notification{
    NSLog(@"%s", __func__);
    Reachability *verifyConnection = [notification object];
    NSAssert(verifyConnection != NULL, @"currentNetworkStatus called with NULL verifyConnection Object");
    QNetworkStatus netStatus = [verifyConnection currentReachabilityStatus];
    if ( netStatus == QNotReachable ){
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkunreachable');"];
    }else {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkreachableagain');"];
    }
}
@end
