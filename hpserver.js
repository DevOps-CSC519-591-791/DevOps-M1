var http = require('http');
var dispatcher = require('httpdispatcher');

const PORT = 8080;

function handleRequest(request, response){
    try{
        console.log(request.url);
        dispatcher.dispatch(request, response);
    } catch(err){
        console.log(err);
    }
}

var server = http.createServer(handleRequest);

server.listen(PORT, function(){
    console.log('Server listening on: http://localhost:%s', PORT);
});


