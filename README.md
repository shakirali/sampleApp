# dogApp
This is the repository to use the dogAPI: https://thedogapi.com

This App has following features:
1. Asynchronously download random dog images along with information such as breed name, origin, breed group and temperament.
2. Allow users to vote up or down for a particular image and asynchronously sends the voting request to the server.
3. Display the Alert when the vote is casted successfully.
3. UI adjusts correctly in case of missing information such as origin, breed group and temperament.

# Software Tools
Xcode 10.2, Swift version 5.0

# Architecture
The app has separate networking, data provider and view layers. The viewController asks for data from the data provider layer which downloads it using the network layer. The data from the data provider is converted into viewModel before being used by the ViewController.

# Unit test
Most of the code base is covered by the unit tests.

# Third party library
No third party library is currently used. However networking code is inspired by the objc.io presentation of Tiny Network library.

# Device
The App is universal and works both on iPhone and iPad. It also supports rotation, however at the moment, adjustments are required to display it correctly on iPhone landscape mode.

# Improvements
1. Categories search is not yet implemented.
2. Implementation of snapshot tests using Snapshot library.
