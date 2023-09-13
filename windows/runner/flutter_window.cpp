#include "flutter_window.h"
#include <flutter/event_channel.h>
#include <flutter/event_sink.h>
#include <flutter/event_stream_handler_functions.h>
#include <flutter/method_channel.h>
#include <flutter/standard_method_codec.h>
#include <windows.h>
#include <AtlBase.h>
#include <atlconv.h>

#include <memory>
#include <optional>
#include <locale>
#include <codecvt>
#include <string>

#include "flutter/generated_plugin_registrant.h"
#include "BasicStreamHandler.h"

bool isWinToastLibInitialized;
flutter::EventSink<>* attachEvent;

CustomHandler::CustomHandler(const std::string task_name) {
    _task_name = task_name;
}
void CustomHandler::toastActivated() const {
    attachEvent->Success(0);
}

void CustomHandler::toastActivated(int actionIndex) const {
    attachEvent->Success(0);
}

void CustomHandler::toastFailed() const {
}

void CustomHandler::toastDismissed(WinToastDismissalReason state) const {
}


static void sendAlarmNotification(const std::string& task_name) {
    if (isWinToastLibInitialized) {
        const int size = MultiByteToWideChar(CP_UTF8, 0, task_name.c_str(), static_cast<int>(task_name.length()), NULL, 0);
        std::wstring task_name_wide(static_cast<size_t>(size), 0);
        MultiByteToWideChar(CP_UTF8, 0, task_name.c_str(), static_cast<int>(task_name.length()), &task_name_wide[0], size);

        WinToastLib::WinToastTemplate templ = WinToastTemplate(WinToastTemplate::Text01);
        templ.setFirstLine(L"Task \"" + task_name_wide + L"\" was finished.");
        templ.setAudioPath(WinToastLib::WinToastTemplate::AudioSystemFile::Alarm2);
        templ.setAudioOption(static_cast<WinToastTemplate::AudioOption>(WinToastTemplate::AudioOption::Loop));

        CustomHandler* handler = new CustomHandler(task_name);
        if (WinToastLib::WinToast::instance()->showToast(templ, handler) < 0) {
            std::wcerr << L"Could not launch your toast notification!";
        }
        delete handler;
    }
}

FlutterWindow::FlutterWindow(const flutter::DartProject& project)
    : project_(project) {

    WinToastLib::WinToast::instance()->setAppName(L"Trimsky's Drafts");
    const auto aumi = WinToast::configureAUMI(L"Trimsky", L"Trimsky's Drafts", L"", L"1");
    WinToast::instance()->setAppUserModelId(aumi);
    if (!WinToastLib::WinToast::instance()->initialize()) {
        std::cerr << L"Your system is not compatible with WinToastLib(notifications)";
        isWinToastLibInitialized = false;
    }
    else {
        isWinToastLibInitialized = true;
    }
}

FlutterWindow::~FlutterWindow() {}

bool FlutterWindow::OnCreate() {
  if (!Win32Window::OnCreate()) {
    return false;
  }
  RECT frame = GetClientArea();

  // The size here must match the window dimensions to avoid unnecessary surface
  // creation / destruction in the startup path.
  flutter_controller_ = std::make_unique<flutter::FlutterViewController>(
      frame.right - frame.left, frame.bottom - frame.top, project_);
  // Ensure that basic setup of the controller was successful.
  if (!flutter_controller_->engine() || !flutter_controller_->view()) {
    return false;
  }
  RegisterPlugins(flutter_controller_->engine());

  flutter::MethodChannel<> channel(
      flutter_controller_->engine()->messenger(), "dev.trimsky/notifications",
      &flutter::StandardMethodCodec::GetInstance());

  channel.SetMethodCallHandler(
      [](const flutter::MethodCall<>& call,
          std::unique_ptr<flutter::MethodResult<>> result) {
              if (call.method_name() == "sendAlarmNotification") {
                  const std::string* task_name = std::get_if<std::string>(call.arguments());
                  if (!task_name) {
                      result->Error("NO_ARGUMENTS", "No arguments found in sendAlarmNotification function");
                  }
                  else {
                      sendAlarmNotification(*task_name);
                      result->Success();
                  }
              }
      });

  flutter::EventChannel<> eventChannel(
      flutter_controller_->engine()->messenger(), "dev.trimsky/notifications_events",
      &flutter::StandardMethodCodec::GetInstance());

  eventChannel.SetStreamHandler(
      std::make_unique<BasicStreamHandler>(/*&attachEvent*/));

  SetChildContent(flutter_controller_->view()->GetNativeWindow());
  return true;
}

void FlutterWindow::OnDestroy() {
  if (flutter_controller_) {
    flutter_controller_ = nullptr;
  }
  attachEvent = nullptr;
  Win32Window::OnDestroy();
}

LRESULT FlutterWindow::MessageHandler(HWND hwnd, UINT const message,
                              WPARAM const wparam,
                              LPARAM const lparam) noexcept {
  // Give Flutter, including plugins, an opportunity to handle window messages.
  if (flutter_controller_) {
    std::optional<LRESULT> result =
        flutter_controller_->HandleTopLevelWindowProc(hwnd, message, wparam,
                                                      lparam);
    if (result) {
      return *result;
    }
  }

  switch (message) {
    case WM_FONTCHANGE:
      flutter_controller_->engine()->ReloadSystemFonts();
      break;
  }

  return Win32Window::MessageHandler(hwnd, message, wparam, lparam);
}
