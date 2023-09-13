#ifndef BASIC_STREAM_HANDLER_H_
#define BASIC_STREAM_HANDLER_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>

#include <memory>

#include "win32_window.h"

#include <flutter/event_stream_handler.h>
#include <flutter/event_sink.h>

class BasicStreamHandler : public flutter::StreamHandler<flutter::EncodableValue>
{
public:
    BasicStreamHandler(/*flutter::EventSink<flutter::EncodableValue>** attachEvent*/);
protected:
    std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> OnListenInternal(
        const flutter::EncodableValue* arguments,
        std::unique_ptr<flutter::EventSink<>>&& events) override;

    std::unique_ptr<flutter::StreamHandlerError<flutter::EncodableValue>> OnCancelInternal(
        const flutter::EncodableValue* arguments) override;

    //flutter::EventSink<flutter::EncodableValue>** _attachEvent;
};

#endif // BASIC_STREAM_HANDLER_H_