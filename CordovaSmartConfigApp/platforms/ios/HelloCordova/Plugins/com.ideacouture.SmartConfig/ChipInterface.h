//
//  ChipInterface.h
//  chipplugin
//
//  Created by Lion on 11/19/14.
//
//

#import <Cordova/CDV.h>
#import "Reachability.h"
#import "FirstTimeConfig.h"
#import "SmartConfigDiscoverMDNS.h"
#import "SmartConfigGlobalConfig.h"
@interface ChipInterface : CDVPlugin
{
    Reachability *wifiReachability;
    FirstTimeConfig *firstTimeConfig;
    SmartConfigDiscoverMDNS *mdnsService;
    SmartConfigGlobalConfig *globalConfig;
    NSTimer *mdnsTimer;
    NSString *deviceName;
    NSString *passwordKey;
    NSString *paddedEncryptionKey;
    NSData *freeData;
    NSString *ssId;
}
- (void) cordovaGetWifiNetworkState:(CDVInvokedUrlCommand *)command;
- (void) cordovaGetSSID:(CDVInvokedUrlCommand*)command;
- (void) cordovaGetGateWayAddress:(CDVInvokedUrlCommand*)command;
- (void) cordovaGetGateDeviceName:(CDVInvokedUrlCommand*)command;
- (void) cordovaStartToCheckNetworkState:(CDVInvokedUrlCommand*)command;
- (void) cordovaSendData:(CDVInvokedUrlCommand*)command;
- (void) cordovaStopSendingData:(CDVInvokedUrlCommand*)command;
#pragma mark - Util_Methods
- (void) setFileContents:(NSString *)fileContents;
- (NSString *) getFileContents;

@end
