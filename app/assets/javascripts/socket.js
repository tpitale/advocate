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

  // replace interactions with socket registered in user_socket in bridge
  // if needed pass ID along to channel call with socket.channel('requests:request_id')
  channel = socket.channel("interactions", {});

  channel.join().receive("ok", function(resp) {
    console.log("Joined successfully: " + resp);
  }).receive("error", function(resp) {
    console.log("Unable to join: " + resp.reason);
  }).after(10000, function() {
    console.log("Connection interruption");
  });

  channel.onError(function() {
    console.log("there was an error with the channel!");
  });

  channel.onClose(function() {
    console.log("the channel has gone away gracefully");
  });

  // rename event2/3 based on the event name that we're broadcasting in bridge
  // https://hexdocs.pm/phoenix/Phoenix.Channel.html#broadcast!/3
  //
  // https://github.com/tpitale/counselor-bridge/blob/master/web/channels/interactions_channel.ex#L55
  // in our bridge above, "interactions:#{event.interaction_id}" is the socket,
  // "event" is event and payload is the message. so event2/event3
  // will change to the event in the bridge
  channel.on("event", function(data) {
    console.log(data);
    var formattedDateTime = moment().format('M/D/Y h:m a');
    $(".container-left .messages-container").prepend("<p class='incoming-msg-from'>Client " + formattedDateTime + "</p><div class='clear'></div><div class='text-bubble incoming'>" + data.content + "</div><div class='msg-sep'></div>")
  });

  channel.on("event2", function(data) {
    // do templating
  });

  channel.on("event3", function(data) {
    // do templating
  });
});