

// simple microservice. 

'use strict';
//const arrNodes = [ "node-svc-01" ]
const arrNodes = [ "node-svc-01", "node-svc-02" ]
//const arrNodes = [ "node-svc-01", "node-svc-02" , "node-svc-03" ]
const express = require('express');
const fetch = require('node-fetch');
const bodyParser = require('body-parser')
//const Request = require("request");

// Constants
const PORT = 30100;
const HOST = '0.0.0.0';
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/0?', (req, res) => {     // matches either / or /0
  //(async () => {
    res.write(dateIPStamp({ "action":"GET" }, req.ip));
    res.status(200).end();
    console.log('Console: / Server returned success on get.');
  //y})();
});

// app.get('/:depth(\d+)', (req, res) => {   // WHY does this not work
app.get('/:depth', (req, res) => {   // everything else but / or /0
  console.log("/n GET, making GET subrequest");
  if (!boolValidateRoute(res, req.params.depth)) return;
  let strURL = buildURL(req.params.depth);
  (async () => {
	const response = await fetch(strURL);
	const json = await response.json();
	console.log(json);
        res.write(dateIPStamp(json, req.ip));  
        res.status(200).end();
        console.log('Console: /1 Server returned success on get.');
  })();
});


app.post('/0?', (req, res) => {     // matches either / or /0
  console.log ("Console: entered / post");
  console.log("Console: / received " + JSON.stringify(req.body));
  let recd = req.body;
  recd.action = "POST";
  let stampedRecd = dateIPStamp(recd, req.ip);
  res.write(stampedRecd); //
  res.status(200).end();
  console.log('Console: / returned ' + stampedRecd);
});

app.post('/:depth', (req, res) => {
  console.log ("Console: /n POST");
  if (!boolValidateRoute(res, req.params.depth)) return;
  let strURL = buildURL(req.params.depth);
  (async () => {
        console.log("/n POST trying subrequest");
        const recd = await req.body;
        const headers = {"Content-Type": "application/json"};
        const postData = await JSON.stringify({recd});
        const response = await fetch(strURL, { method: 'POST', headers: headers, body: postData});
        const json = await response.json();
        console.log(json);
        res.write(dateIPStamp(json, req.ip));  
        res.status(200).end();
        console.log('Console: /1 Server returned success on get.');
  })();
});


app.listen(PORT, HOST);

console.log(`Running on ${PORT}`);

// test a simple self-get

console.log('Console: request is testing a simple self-get')

fetch('http://localhost:30100')
  .then(response => response.json())
  .then(data => console.log(data));

// test a simple self-post
console.log('Console: request is testing a simple self-post')

const url ='http://localhost:30100';
const headers = {
  "Content-Type": "application/json"
};
const postData = JSON.stringify({
  "firstName": "myFirstName",
  "lastName": "myLastName"
});

fetch(url, { method: 'POST', headers: headers, body: postData})
  .then((res) => {
     return res.json()
})
.then((json) => {
  console.log(json);
});

function boolValidateRoute (res, strRoute) {
 if (!isNumeric(strRoute)) { 
    console.log("non-numeric path attempted");
    res.write("error, only numeric depth path supported");
    res.status(405).end();
    return false; } else  { return true; }
  }

function dateIPStamp(recdJSON, someIP) {
  console.log ("DateIPStamp reached with " + JSON.stringify(recdJSON) + " " + someIP);
  let now = new Date();
  if (!recdJSON.hasOwnProperty("arrTimeStamp")) {
  recdJSON.arrTimeStamp = [ someIP + " " + now ];
  } else {
  recdJSON["arrTimeStamp"].push(someIP + " " + now)
  };
  let strReturnJSON = JSON.stringify(recdJSON);
  return(strReturnJSON);
  
}

function isNumeric(strIn) {
  // returns  bool
  let re = /\d+/;
  return (re.test(strIn));
}
 
function buildURL (strLevel) {


  // what is the formula for which node to call? 
  // given x levels and n nodes
  // x % n  where x>n, else n
  
      
  let intCurrLevel = parseInt(strLevel);
  let nextLevel = intCurrLevel - 1;
  let numNodes = arrNodes.length; // to be derived from arrNodes
  let nextNode = nextLevel >= numNodes ? nextLevel % numNodes : nextLevel;
  let strURL = "http://"+ arrNodes[nextNode] + ":30100/" + nextLevel;
    
  console.log ("returning URL " + strURL);
   return(strURL);

}

