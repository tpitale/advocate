//= require phoenix_socket
//= require_self

var ADVOCATE = ADVOCATE || {};

ADVOCATE.document_ready = function(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('DOMContentLoaded', fn);
  }
};

ADVOCATE.user_token = function() {
  return document.getElementById('current_user_token').value || null;
}

ADVOCATE.subscribe = function(component, interaction_id = 0) {
  var hostname = window.location.hostname;
  var socket;

  if (hostname === "localhost") { // docker local/mix phoenix.server
    socket = new Socket("ws://" + hostname + ":3001/socket", {})
  } else if (hostname === "advocate.dev") { // docker local with nginx/compose
    socket = new Socket("ws://bridge." + hostname + ":8080/socket", {})
  } else { // production
    socket = new Socket("ws://bridge." + hostname + "/socket", {})
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
  var channel_name = "interactions";
  var channel_params = {params: {token: ADVOCATE.user_token}};

  if (interaction_id > 0) {
    channel_name = [channel_name, interaction_id].join(":")
  }

  // replace interactions with socket registered in user_socket in bridge
  // if needed pass ID along to channel call with socket.channel('requests:request_id')
  channel = socket.channel(channel_name, channel_params);

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
