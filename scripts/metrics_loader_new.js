"user strict";

// Import Libraries
var fs=require('fs'),
    inputParams=process.argv,
    inFile=null,
    outFile=null,
    lineReader = require('line-reader'),
    server=null;

// Check Arguments
if(inputParams.length<4) {
  console.log("Need to enter the inFile and an ourFile as parameters!");
  process.exit();
} else {
  inFile=inputParams[2];
  outFile=inputParams[3];
  server=inFile.split('_')[1];
}

// Check the inFile exists - use fs-extra !

// Initialise Variables
var globalStartDate=null,
    globalCpu=[],
    globalMem=[],
    globalDisk=[],
    globalNetIn=[],
    globalNetOut=[],
    key=null,
    outputArray=[],    
    lineArray=null,
    firstGlobalRecord=true,
    processHash={},
    firstProcessRecord=true;

// Define some helper functions
function milliSecs(date,time) {
  return new Date(date+' '+time).getTime();
}

function buildMetricArray(array,date,time,value) {
  array.push([milliSecs(date,time),Number(value)])
}

function buildServerMetrics(cpu,mem,disk,netIn,netOut) {
  return JSON.stringify([{"cpu":cpu},{"mem":mem},{"disk":disk},{"netIn":netIn},{"netOut":netOut}]);
}

function buildProcessMetrics() {
  return JSON.stringify([]);
}

function buildOutputArray(key,server,startDate,serverMetrics,processMetrics) {
  outputArray.push('{"_id":"'+key+'","server":"'+server+'","date":"'+startDate.replace(/\//g,'')+'","server_metrics":'+serverMetrics+'}');
  //outputArray.push('{"_id":"'+key+'","server":"'+server+'","date":"'+startDate.replace(/\//g,'')+'","server_metrics":'+serverMetrics+',"process_metrics":'+processMetrics+'}');
}

// Main Code - Read each line and apply the transformations
lineReader.eachLine(inFile, function(line, last) {
  lineArray=line.split(',');

  switch(lineArray[0]) {
    case 'GLOBAL' :
      if (firstGlobalRecord) {
        globalStartDate=lineArray[1];
        firstGlobalRecord=false;
      };

      if (globalStartDate===lineArray[1]) {
        buildMetricArray(globalCpu,lineArray[1],lineArray[2],lineArray[3]);
        buildMetricArray(globalMem,lineArray[1],lineArray[2],lineArray[4]);
        buildMetricArray(globalDisk,lineArray[1],lineArray[2],lineArray[7]);
        buildMetricArray(globalNetIn,lineArray[1],lineArray[2],lineArray[5]);
        buildMetricArray(globalNetOut,lineArray[1],lineArray[2],lineArray[6]);
      } else {
        key=server+'-'+globalStartDate.replace(/\//g,'');
        buildOutputArray(key,server,globalStartDate,buildServerMetrics(globalCpu,globalMem,globalDisk,globalNetIn,globalNetOut),buildProcessMetrics());
        globalCpu=[[milliSecs(lineArray[1],lineArray[2]),Number(lineArray[3])]];
        globalMem=[[milliSecs(lineArray[1],lineArray[2]),Number(lineArray[4])]];
        globalDisk=[[milliSecs(lineArray[1],lineArray[2]),Number(lineArray[7])]];
        globalNetIn=[[milliSecs(lineArray[1],lineArray[2]),Number(lineArray[5])]];
        globalNetOut=[[milliSecs(lineArray[1],lineArray[2]),Number(lineArray[6])]];
        firstGlobalRecord=true;
      };
      break;
    case 'PROCESS' :
      if (firstProcessRecord) {
        firstProcessRecord=false;
      }
    }

  if (last) {
    key=server+'-'+globalStartDate.replace(/\//g,'');
    buildOutputArray(key,server,globalStartDate,buildServerMetrics(globalCpu,globalMem,globalDisk,globalNetIn,globalNetOut),buildProcessMetrics());
    var fs = require('fs');
    var stream = fs.createWriteStream(outFile);
    stream.once('open', function(fd) {
      outputArray.forEach(function(val,len,array) {
        stream.write(val+"\n");
      });
      stream.end();
    });
    return false;
  };
});