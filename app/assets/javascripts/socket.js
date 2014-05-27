dispatcher = new WebSocketRails('localhost:3000/websocket');

function submitToSocket(data) {
    dispatcher.trigger('tasks.create', data);
}