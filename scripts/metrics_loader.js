"user strict";

var fs=require('fs'),
    inputParams=process.argv,
    inFile=null,
    outFile=null,
    lineReader = require('line-reader'),
    server=null;


if(inputParams.length<4) {
  console.log("Need to enter the inFile and an ourFile as parameters!");
  process.exit();
} else {
  inFile=inputParams[2];
  outFile=inputParams[3];
  server=inFile.split('_')[0].split('/')[2];
}

// Check the inFile exists - use fs-extra !

var startDate=null,
    cpu=[],
    mem=[],
    disk=[],
    netIn=[],
    netOut=[],
    key=null,
    recs=[],    
    lineArray=null,
    firstRecord=true;

lineReader.eachLine(inFile, function(line, last) {
  lineArray=line.split(',');

  if (firstRecord) {
    startDate=lineArray[0];
    firstRecord=false;
  };

  if (startDate===lineArray[0]) {
    millSecs=new Date(startDate+' '+lineArray[1]).getTime();
    cpu.push([millSecs,Number(lineArray[2])]);
    mem.push([millSecs,Number(lineArray[4])]);
    disk.push([millSecs,Number(lineArray[3])]);
    netIn.push([millSecs,Number(lineArray[5])]);
    netOut.push([millSecs,Number(lineArray[6])]);
  } else {
    key=server+'-'+startDate.replace(/\//g,'');
    recs.push('{"_id":"'+key+'","server":"'+server+'","date":"'+startDate.replace(/\//g,'')+'","server_metrics":[{"cpu":'+JSON.stringify(cpu)+'},{"mem":'+JSON.stringify(mem)+'},{"disk":'+JSON.stringify(disk)+'},{"netIn":'+JSON.stringify(netIn)+'},{"netOut":'+ JSON.stringify(netOut)+'}]}');
    millSecs=new Date(lineArray[0]+' '+lineArray[1]).getTime();
    cpu=[[millSecs,Number(lineArray[2])]];
    mem=[[millSecs,Number(lineArray[4])]];
    disk=[[millSecs,Number(lineArray[3])]];
    netIn=[[millSecs,Number(lineArray[5])]];
    netOut=[[millSecs,Number(lineArray[6])]];
    firstRecord=true;
  };

  if (last) {
    key=server+'-'+startDate.replace(/\//g,'');
    recs.push('{"_id":"'+key+'","server":"'+server+'","date":"'+startDate.replace(/\//g,'')+'","server_metrics":[{"cpu":'+JSON.stringify(cpu)+'},{"mem":'+JSON.stringify(mem)+'},{"disk":'+JSON.stringify(disk)+'},{"netIn":'+JSON.stringify(netIn)+'},{"netOut":'+ JSON.stringify(netOut)+'}]}');
    var fs = require('fs');
    var stream = fs.createWriteStream(outFile);
    stream.once('open', function(fd) {
      recs.forEach(function(val,len,array) {
        stream.write(val+"\n");
      });
      stream.end();
    });
    return false;
  };
});