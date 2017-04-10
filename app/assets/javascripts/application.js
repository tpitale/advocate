//= require phoenix_socket
//= require_self
//= require messages/dist/app

var ADVOCATE = ADVOCATE || {};

ADVOCATE.document_ready = function(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
};

ADVOCATE.subscribe = function(component) {
  console.log("Subscribing component: ", component);
  var hostname = window.location.hostname;

  var socket_params = {params: {userToken: "123"}};
  var socket;

  if (hostname === "localhost") { // docker local/mix phoenix.server
    socket = new Socket("ws://" + hostname + ":3001/socket", socket_params)
  } else if (hostname === "advocate.dev") { // docker local with nginx/compose
    socket = new Socket("ws://bridge." + hostname + ":8080/socket", socket_params)
  } else { // production
    socket = new Socket("ws://bridge." + hostname + "/socket", socket_params)
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
  // https://github.com/tpitale/advocate-bridge/blob/master/web/channels/interactions_channel.ex#L55
  // in our bridge above, "interactions:#{event.interaction_id}" is the socket,
  // "event" is event and payload is the message. so event2/event3
  // will change to the event in the bridge
  channel.on("event", function(data) {
    component.add_event(data);

    // var formattedDateTime = moment().format('M/D/Y h:m a');
    // $("#blank-slate").hide();
    // $(".container-left .messages-container").prepend("<div class='text-bubble incoming'>" + data.content + "</div><p class='incoming-msg-from'>Client " + formattedDateTime + "</p>")
  });

  // channel.on("event2", function(data) {
  //   // do templating
  // });

  // channel.on("event3", function(data) {
  //   // do templating
  // });
};
