$(function() {
  var hostname = window.location.hostname;

  var socket;
  // by default I think phoenix makes non secure websocket be at port 4000 and
  // secure websockets at port 4040
  if (window.location.hostname === "localhost") {
    socket = new Socket("ws://" + hostname + ":4000/socket", {params: {userToken: "123"}})
  } else {
    socket = new Socket("wss://" + hostname + ":4040/socket", {params: {userToken: "123"}})
  }

  socket.connect();

  socket.onOpen(function() {
    console.log("the connection is open!");
  });

  socket.onError(function(error) {
    console.log("there was an error with the connection!");
  });

  socket.onClose(function() {
    console.log("the connection dropped");
  });

  var channel;

  // replace requests with socket registered in user_socket in bridge
  // if needed pass ID along to channel call with socket.channel('requests:request_id')
  channel = socket.channel("requests", {});

  channel.join().receive("ok", function(resp) {
    console.log("Joined successfully" + resp);
  }).receive("error", function(resp) {
    console.log("Unable to join" + resp);
  }).after(10000, function() {
    console.log("Connection interruption");
  });

  channel.onError(function() {
    console.log("there was an error with the channel!");
  });

  channel.onClose(function() {
    console.log("the channel has gone away gracefully");
  });

  // rename event1/2/3 based on what we're broadcasting in bridge
  channel.on("event1", function(data) {
    // do templating
  });

  channel.on("event2", function(data) {
    // do templating
  });

  channel.on("event3", function(data) {
    // do templating
  });
});