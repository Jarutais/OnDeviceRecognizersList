# OnDeviceRecognizersList
This repo to demonstrates that it isn't possible to list SFSpeechRecognizers with on device transcription capabilities on iOS 14.

Fetching SFSpeechRecognizers with on device transcription capabilities is done by:
1) Creating all available SFSpeechRecognizers
2) Filtering the ones with property "supportsOnDeviceRecognition" true

## As shown in the following snippet:
```
let onDeviceRecognizers = SFSpeechRecognizer.supportedLocales()
                                            .compactMap { SFSpeechRecognizer(locale: $0) }
                                            .filter { $0.supportsOnDeviceRecognition }
```

Running this code on device on iOS 13 returns a list of recognizers. On iOS 14 the results are varied. Sometimes there are results and most of the time there are 0 results.
