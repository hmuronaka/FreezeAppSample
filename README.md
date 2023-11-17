This sample project is for reproducing the issue below.
 
[App Freezes with AVPlayer Inside NavigationStack on iOS 17.2 beta](https://developer.apple.com/forums/thread/741002)
FB13337560

Environment:
macOS: macOS Sonoma 14.1.1
Xcode: 15.1 beta 3(15C5059c)
iPhone Simulator: iPhone SE(3rd generation) 1OS 17.2 (21C5046b)

Steps:

1. Launch the app.
2. Scroll through the list.
3. Tap on a cell. The issue is reproduced if scrolling does not reach 500 lines on the next screen.
4. If the issue is not reproduced, close the app and return to Step 1.

NOTE: 
- Sometimes the issue is immediately reproduced, but in this reproduction app, if it does not occur, it will not occur for 40 to 50 tries.
- The tendency appears to be that it occurs right after launch or when there are many views being rendered.
- On the iOS 17.2 beta simulator, the issue is reproduced 100% of the time when running my production app. However, on the actual iPadOS 17.2 beta device, the issue has not been reproduced with the production app.
