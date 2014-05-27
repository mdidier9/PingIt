dispatcher = new WebSocketRails('localhost:3000/websocket');

function submitToSocket(data) {
    dispatcher.trigger('tasks.create', data);
}

function deleteToSocket(id) {
    console.log(id);
    console.log("message from deletetosocket");
    dispatcher.trigger('tasks.destroy', id)
}