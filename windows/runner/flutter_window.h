#ifndef RUNNER_FLUTTER_WINDOW_H_
#define RUNNER_FLUTTER_WINDOW_H_

#include <flutter/dart_project.h>
#include <flutter/flutter_view_controller.h>

#include <memory>

#include "win32_window.h"
#include "wintoastlib.h"
using namespace WinToastLib;

// A window that does nothing but host a Flutter view.
class FlutterWindow : public Win32Window {
 public:
  // Creates a new FlutterWindow hosting a Flutter view running |project|.
  explicit FlutterWindow(const flutter::DartProject& project);
  virtual ~FlutterWindow();

 protected:
  // Win32Window:
  bool OnCreate() override;
  void OnDestroy() override;
  LRESULT MessageHandler(HWND window, UINT const message, WPARAM const wparam,
                         LPARAM const lparam) noexcept override;

 private:
  // The project to run.
  flutter::DartProject project_;
  // The Flutter instance hosted by this window.
  std::unique_ptr<flutter::FlutterViewController> flutter_controller_;
};

class CustomHandler : public IWinToastHandler {
public:
    CustomHandler(const std::string task_name);

    void toastActivated() const override;
    void toastActivated(int actionIndex) const override;
    void toastFailed() const override;
    void toastDismissed(WinToastDismissalReason state) const override;
private:
    std::string _task_name;
};

#endif  // RUNNER_FLUTTER_WINDOW_H_