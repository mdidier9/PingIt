dispatcher = new WebSocketRails(window.location.host + '/websocket');
channel = dispatcher.subscribe('pingas');

function submitToSocket(data) {
    dispatcher.trigger('pingas.create', data);
}

function deleteToSocket(id) {
    dispatcher.trigger('pingas.destroy', id)
}