//
//  ChipInterface.m
//  chipplugin
//
//  Created by Lion on 11/19/14.
//
//

#import "ChipInterface.h"
#import "FirstTimeConfig.h"

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
    NSString *arg1 = command.arguments[0];
    NSString *arg2 = command.arguments[0];
    if ( [arg1 length] == 0)
        arg1 = nil;
    if ( [arg2 length] == 0)
        arg2 = nil;
    [self startTransmitting:arg1 key:arg2];
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

- (void) cordovaStopSedningData:(CDVInvokedUrlCommand*)command
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

- (void) sendAction
{
    @try {
        NSLog(@"%s begin", __PRETTY_FUNCTION__);
        [config transmitSettings];
        NSLog(@"%s end", __PRETTY_FUNCTION__);
    }
    @catch (NSException *exception) {
        NSLog(@"exception === %@",[exception description]);
        // send exception
        //[self.commandDelegate evalJs:@"cordova.fireDocumentEvent('exceptionWhileTransmit',null, true);"];
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('exceptionWhileTransmit');"];
    }
    @finally {
        
    }
}


-(void) stopAction{
    NSLog(@"%s begin", __PRETTY_FUNCTION__);
    @try {
        [config stopTransmitting];
    }
    @catch (NSException *exception) {
        NSLog(@"%s exception == %@",__FUNCTION__,[exception description]);
    }
    @finally {
        
    }
    NSLog(@"%s end", __PRETTY_FUNCTION__);
}


- (void) waitForAckThread: (id)sender{
    @try {
        NSLog(@"%s begin", __PRETTY_FUNCTION__);
        Boolean val = [config waitForAck];
        NSLog(@"Bool value == %d",val);
        if ( val ){
            //
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('receivedAckFromDevice');"];
            [self stopAction];
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%s exception == %@",__FUNCTION__,[exception description]);
        /// stop here
    }
    @finally {
    }
    
    if ( [NSThread isMainThread]  == NO ){
        NSLog(@"this is not main thread");
        [NSThread exit];
    }else {
        NSLog(@"this is main thread");
    }
    NSLog(@"%s end", __PRETTY_FUNCTION__);
}


- (void)startTransmitting :(NSString*) password key:(NSString*) keyValue{
    @try {
        QNetworkStatus netStatus = [wifiReachability currentReachabilityStatus];
        if ( netStatus == QNotReachable ){// No activity if no wifi
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('transmitStopByException');"];
            [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkunreachable');"];
            return;
        }
        
        if ( config )
        config = nil;
        
        if ( password != nil || keyValue != nil ){// for user enter the password
            
            NSData *encriptionData = keyValue != nil ? [keyValue dataUsingEncoding:NSUTF8StringEncoding] : Nil;
            
            //if ( isEncriptionKey == false ){// even if user entered
            //    encriptionData = nil;
            //}
            
            config = [[FirstTimeConfig alloc] initWithKey:password withEncryptionKey:encriptionData];
            
        }else {
            config = [[FirstTimeConfig alloc] init];
        }
        
        // Setting the device name
        NSString *deviceName = @"CC3000";
        [config setDeviceName:deviceName];
        
        [self sendAction];
        
        [NSThread detachNewThreadSelector:@selector(waitForAckThread:) toTarget:self withObject:nil];
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
    if ( netStatus == NotReachable ){
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkunreachable');"];
    }else {
        [self.commandDelegate evalJs:@"cordova.fireDocumentEvent('networkreachableagain');"];
    }
}
@end
