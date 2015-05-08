cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-statusbar/www/statusbar.js",
        "id": "cordova-plugin-statusbar.statusbar",
        "clobbers": [
            "window.StatusBar"
        ]
    },
    {
        "file": "plugins/org.apache.cordova.core.parseplugin/www/cdv-plugin-parse.js",
        "id": "org.apache.cordova.core.parseplugin.ParsePlugin",
        "clobbers": [
            "window.parsePlugin"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-statusbar": "1.0.1-dev",
    "org.apache.cordova.core.parseplugin": "0.1.0"
}
// BOTTOM OF METADATA
});