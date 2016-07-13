// packages
var argv = require('yargs').argv;
var async = require('async');
var azure = require('azure-storage');
var clear = require('clear');
var colors = require('colors');
var fs = require('fs');
var _ = require('lodash');

// script variables
var releaseFiles = [];
var type = ['android', 'ios', 'all'];
var typeIosPrefix = 'eTrips';
var typeAndroidPrefix = 'android';
var releaseFilesPath = './release_files';

clear();
console.log(colors.underline.bold.white('eTrips Deploy: Azure File Upload'));

// get all files of android, ios, or both
if (_.isUndefined(argv.type) === true || _.includes(type, argv.type) === false) {
  console.log(colors.bold.red('\nERROR:'));
  console.log(colors.red('Missing/Invalid argument: --type=[android | ios | all]'));
  console.log('');
  return false;

} else {
  releaseFiles = _.filter(fs.readdirSync('./release_files'), function(file) {
    if (argv.type === 'ios' && file.indexOf(typeIosPrefix) === 0) {
      return true;

    } else if (argv.type === 'android' && file.indexOf(typeAndroidPrefix) === 0) {
      return true;

    } else if (argv.type === 'all' && (file.indexOf(typeIosPrefix) === 0 || file.indexOf(typeAndroidPrefix) === 0)) {
      return true;
    }
  });
}

if (releaseFiles.length === 0) {
  console.log(colors.bold.red('\nERROR:'));
  console.log(colors.red('No files to upload'));
}

var requiredEnvironmentVariables = ['AZURE_STORAGE_ACCOUNT', 'AZURE_STORAGE_ACCESS_KEY'];
var missingEnvironmentVariables = _.difference(requiredEnvironmentVariables, _.keys(process.env));

if (missingEnvironmentVariables.length > 0) {
  console.log(colors.bold.red('\nERROR:'));
  console.log(colors.red('Environment variables missing:' + missingEnvironmentVariables));
  console.log('');
  return false;
}

var blobSvc = azure.createBlobService(process.env.AZURE_STORAGE_ACCOUNT, process.env.AZURE_STORAGE_ACCESS_KEY);
var containerName = 'etrips';

console.log('');

async.each(releaseFiles, function(file, eachCallback){
  var fileName = releaseFilesPath + '/' + file;

  async.waterfall([
    function(callback) {
      blobSvc.doesBlobExist(containerName, file, function(error, result){
        if (result.exists === true) {
          callback(null, true);
        } else {
          callback(null, false);
        }
      });
    },

    function(fileExists, callback) {
      if (fileExists === true) {
        blobSvc.deleteBlob(containerName, file, file, function(error){
          if (!error){
            callback(null, true);
          } else {
            callback(error);
          }
        });
      } else {
          callback(null, false);
      }
    },

    function(fileDeleted, callback) {
      blobSvc.createBlockBlobFromLocalFile(containerName, file, fileName, function(error){
        if (!error){
            callback(null, true);
        } else {
            callback(error);
        }
      });
    }
  ], function (err) {
      var date = new Date();
      if (err) {
        console.log(colors.red('[' + date.toISOString() + '] Error: ') + file, err);
      } else {
        console.log(colors.green('[' + date.toISOString() + '] Success: ') + file);
      }

      eachCallback();
  });

}, function(err, result) {
  if (err) {
    console.log(colors.red(err), result);
  }
});
