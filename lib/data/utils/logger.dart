extension Logger on String {
  get toErrorPrint {
    print('\x1B[31m$this\x1B[0m');
  }

  get toSuccessPrint {
    print('\x1B[32m$this\x1B[0m');
  }

  get toWarningPrint {
    print('\x1B[33m$this\x1B[0m');
  }

  get toBluePrint {
    print('\x1B[36m$this\x1B[0m');
  }
}
