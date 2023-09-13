#include "BasicStreamHandler.h"

std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> BasicStreamHandler::OnListenInternal(
    const flutter::EncodableValue* arguments,
    std::unique_ptr<flutter::EventSink<>>&& events) {

    //*_attachEvent = events.get();
    return std::make_unique<flutter::StreamHandlerError<flutter::EncodableValue>>("Nothing", "Nothing", nullptr);
}
std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> BasicStreamHandler::OnCancelInternal(
    const flutter::EncodableValue* arguments) {

    //_attachEvent = nullptr;
    return std::make_unique<flutter::StreamHandlerError<flutter::EncodableValue>>("Nothing", "Nothing", nullptr);
}

BasicStreamHandler::BasicStreamHandler(/*flutter::EventSink<>** attachEvent*/) {
    //_attachEvent = attachEvent;
}