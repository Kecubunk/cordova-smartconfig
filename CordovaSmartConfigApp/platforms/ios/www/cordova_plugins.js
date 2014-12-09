cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/com.ideacouture.SmartConfig/www/SmartConfig.js",
        "id": "com.ideacouture.SmartConfig.SmartConfig",
        "clobbers": [
            "cordova.plugins.SmartConfig"
        ]
    },
    {
        "file": "plugins/com.ideacouture.SmartConfig/www/SmartConfig.js",
        "id": "com.ideacouture.SmartConfig.SmartConfig",
        "clobbers": [
            "cordova.plugins.SmartConfig"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.console/www/console-via-logger.js",
        "id": "org.apache.cordova.console.console",
        "clobbers": [
            "console"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.console/www/logger.js",
        "id": "org.apache.cordova.console.logger",
        "clobbers": [
            "cordova.logger"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "com.ideacouture.SmartConfig": "0.0.1",
    "org.apache.cordova.console": "0.2.11"
}
// BOTTOM OF METADATA
});