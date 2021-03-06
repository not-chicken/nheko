# Changelog

## [0.7.0] -- 2020-04-19

0.7.0 *requires* mtxclient 0.3.0.  Make sure you compile against 0.3.0
if you do not use the mtxclient bundled with nheko.

### Features
- Make nheko session import / export format match riot.  Fixes #48
- Implement proper replies
- Add .well-known support for auto-completing homeserver information
- Add mentions viewer so you can see all the messages you have been mentioned in
  - Currently broken due to QML changes.  Will be fixed in the future.
- Add emoji font selection preference
- Encryption and decryption of media in E2EE rooms
- Square avatars
- Support for muting and unmuting rooms
- Basic support for playing audio and video messages in the timeline
- Support for a lot more event types (hiding them will come in the future)
- Support for sending all messages as plain text
- Support for inviting, kicking, banning and unbanning users
- Sort the room list by importance of messages (thanks @Alch-Emi)
- Experimental support for [blurhashes](https://github.com/matrix-org/matrix-doc/pull/2448)

### Improvements
- Add dedicated reply button to Timeline items.  Add button for other options so
    that right click isn't always required.
- Fix various things with regards to emoji rendering and the emoji picker
- Lots and lots and lots of localization updates.
- Additional tweaks to the system theme
- Render timeline in Qml to drop memory usage
- Reduce memory usage of avatars
- Close notifications after they have been read on Linux
- Escape html properly in most places
- A lot of improvements around the image overlay
- The settings page now resizes properly for small screens
- Miscellaneous styling improvements
- Simplify and speedup build
- Display more emojis in the selected emoji font
- Use 'system' theme as default if QT_QPA_PLATFORMTHEME is set

### Bugfixes

- Fix messages stuck on unread
- Reduce the amount of messages shown as "xxx sent an encrypted message"
- Fix various race conditions and crashes
- Fix some compatibility issues with the construct homeserver

Be aware, that Nheko now requires Qt 5.10 and boost 1.70 or higher.

## [0.6.4] - 2019-05-22

*Most* of the below fixes are due to updates in mtxclient.  Make sure you compile against 0.2.1
if you do not use the mtxclient bundled with nheko to get these fixes.

### Features
- Support V3 Rooms

### Improvements
- Fix #19
    - Fix initial sync issue caused by matrix-org/synapse#4898 (thanks @monokelpinguin)
    - Add additional lmbd max_dbs setting (thanks @AndrewJDR)
- Update DE translations (thanks @miocho)
- Update Dutch translations (thanks @vistaus)
- Fix text input UI bug (thanks @0xd800)
- Update linkifyMessage to parse HTML better (thanks @monokelpinguin)
- Update to Boost 1.69.0
- Fix some memory-leak scenarios due to mismatched new / delete (thanks @monokelpinguin)

### Other Changes
- mtxclient now builds as a Shared Library by default (instead of statically)

## [0.6.3] - 2019-02-08

### Features
- Room notifications now distinguish between general and user mentions by using different colors
- User names are now colored based on both the theme and a hash from their user id.
- Add font selection preference


### Improvements
- Fix room joining issue by escaping (thanks rnhmjoj)
- Mild tweaks to the dark and light themes
- Add paragraph tags back to markdown, fixing #2 / mujx#438
- Tweak author text to help differentiate it from the message text
- Some Russian translations have been added/fixed (thanks tim77)
- Partially address some build issues (related to #10)

## [0.6.2] - 2018-10-07

### Features
- Display tags as sorting items in the community panel (#401 @vberger)
- Add ability to configure the font size.

### Improvements
- Don't enable tray by default.
- Hard-coded pixel values were removed. The sizes are derived from the font.

### Other changes
- Removed room re-ordering option.

## [0.6.1] - 2018-09-26

### Improvements
- Add infinite scroll in member list. (#446)
- Use QPushButton on the preview modal.

### Bug fixes
- Clear text selection when focus is lost. (#409)
- Don't clear the member list when the modal is hidden. (#447)

## [0.6.0] - 2018-09-21

### Features
- Support for sending & receiving markdown formatted messages. (#283)
- Import/Export of megolm session keys. (Incompatible with Riot) (#358)
- macOS: The native emoji picker can be used.
- Context menu option to show the raw text message of an event. (#437)
- Rooms with unread messages are marked in the room list. (#313)
- Clicking on a user pill link will open the user profile.

### Improvements
- Update Polish translation (#430)
- Enable Qt auto scaling. (#397)
- Enable colors in the console logger.
- Refactor styling to better work with the system theme.

### Bug fixes
- Fixed crash when switching rooms. (#433)
- Fixed crash during low connectivity. (#406)
- Fixed issue with downloading media that don't have a generated thumbnail.
- macOS: Add missing border on the top bar.
- Fallback to the login screen when the one-time keys cannot be uploaded.
- Show the sidebar after initial sync. (#412)
- Fix regression, where cache format changes didn't trigger a logout.

## [0.5.5] - 2018-09-01

### Features
- Add the ability to change the room avatar. (#418)
- Show the room id in the room settings modal. (#416)

### Improvements
- More flicker improvements.
- Auto remove old messages from cache.

### Bug fixes
- Fixed issue where nheko will stop retrying initial sync. (#422)
- Fixed the incomplete version string on Info.plist (macOS) (#423)
- Fixed a use-after-free error during logout.
- Temporary fix to work with servers that don't support e2ee. i.e Construct, Dendrite (#371)

## [0.5.4] - 2018-08-21

Small release to address a crash during logout.

### Features

- The settings page now includes the device id & device fingerprint (thanks @valkum )
- The Polish translation has been updated (thanks @m4sk1n )

## [0.5.3] - 2018-08-12

### Features
- Add option to disable desktop notifications (#388)
- Allow user to configure join rules for a room.
- Add tab-completion for usernames (#394).

### Improvements
- Remove the space gap taken by the typing notifications.
- Remove hover event from emoji picker.
- Add tooltips for the message indicators (#377).
- Fix compilation on FreeBSD (#403)
- Update Polish translation.
- Small modal improvements.

### Bug fixes
- Remove dash from the version string when building outside of git.
- Remove unwanted whitespace from the user settings menu.
- Consider the scale ratio when scaling down images (#393).

## [0.5.2] - 2018-07-28

### Features
- Mark own read messages with a double checkmark (#377).
- Add option to specify the scale factor (#357, #335, #230).
- Add input field to specify the device name on login.
- Add option to ignore key requests altogether.
- Show device list in user profile & add option to create 1-1 chat.

### Improvements
- Add foreground color for disabled buttons on the dark theme.
- Increase the opacity of the hover color on the room list.
- Add missing tooltips on buttons (#249).
- Performance Improvements when filtering large number for rooms.
- Clear timeline widgets when they exceed a certain limit, to reduce the memory footprint (#158).
- Use native scrollbar in the timeline.
- Enable scrollbar on the room list for macOS.
- Remove some timeline flickering on macOS.
- Remove pixel values from modals.
- Update Polish translation.

### Bug fixes
- Fix crash when the server doesn't have the joined_groups endpoint (#389).
- Reject key requests for users that are not members of the room.
- Add user avatar after the `encryption is enabled` message (#378)

## [0.5.1] - 2018-07-17

### Improvements
- Add the -v / --version option, which displays the version of the application.
- Explicitly set no timeout for the Linux notifications.

### Bug fixes
- Fix crash when drag 'n drop files on text input. (#363)
- Convert MXC to HTTP URI for video files.
- Don't display the `m.room.encryption` event twice.
- Properly reset the auto-complete anchor when the popup closes. (#305)
- Use a brighter color for button's text on the system theme. (#355)

## [0.5.0] - 2018-07-15

### Features
- End-to-End encryption for text messages.
- Context menu option to request missing encryption keys.
- Desktop notifications on all platforms (Linux, macOS, Windows).
- Responsive UI (hidden sidebar/timeline).
- Basic support for replies (#292)

### Improvements
- Save timeline messages in cache for faster startup times.
- Debug logs will now be saved in a file.
- New translations
    - French (#329)
    - Polish (#349)
- No dependencies will be downloaded during build.

### Bug fixes
- Allow close events from the session manager (#353).
- Send image dimensions in m.image event (#215).
- Allow arbitrary resizing of the main window & restore sidebar's size (#160, #163, #187, #127).

## [0.4.3] - 2018-06-02

### Bug fixes
- Overdue fixes for some regressions with regard to widget height introduced in the previous two releases
- The matrix id will be shown on hover on the display name.

## [0.4.2] - 2018-05-25

### Bug fixes
- Make the number of unread messages fit in the bubble (#330)
- Use white for messages on the dark theme (#331)
- Fix "jumpy messages" regression

## [0.4.1] - 2018-05-23

### Features
- Menu to modify the name & topic of the room.
- Desktop notifications for macOS.
- Option to start in tray (#319)
- Russian translation (#318)
- Read support for the room access level (#324)

### Improvements
- HiDPI avatars.

### Bug fixes
- Fix for the line break on messages with very long words/links.
- Translations are working again.

## [0.4.0] - 2018-05-03

### Features
- Basic member list
- Basic room settings menu
- Support for displaying stickers
- Fuzzy search for rooms

### Improvements
- Cache refactoring (reduced memory consumption)
- Implement media cache (faster avatar loading)
- Show room tooltips when the sidebar is collapsed
- Flicker-free auto-completion menus (rooms, users)
- Improved message spacing in the timeline
- Improved macOS installer
- Fancier date separator widget
- Minor popup improvements

### Bug fixes
- Fix UI inconsistencies between room list & communities
- Adjust popup completion menu to fit its contents
- Fix stuck typing notifications
- Handle invalid access tokens

## [0.3.1] - 2018-04-13

### Improvements
- The auto-completion menu can be navigated with TAB.  (#294 )

### Bug fixes
- Show auto-completion menu even if there are fewer than the max number of matches (#294)
- Hide emoji panel when it's not under the mouse cursor. (#254, #246)

## [0.3.0] - 2018-04-03

### Features
- Add auto-completion pop-up for usernames (triggered with @). (#40)
- Add ability to redact messages.
- Add context menu option to save images. (#265)
- Pin invites to the top of the room list. (#252)
- Add environment variable to allow insecure connections (e.g self-signed certs) (#260)

### Improvements
- Updated dark theme.
- Add border in community list.
- Add version & build info in the settings menu.
- Easier packaging by allowing to use already built dependencies.

### Bug fixes
- Fix invite unreadable button colors on the system theme. (#248)
- Track invites so they can be removed from other clients. (#213)
- Fix text color on the room switcher. (#245)

## [0.2.1] - 2018-03-13

### Features
- Implement user registration with reCAPTCHA
- Add context menu option to mark events individually as read

### Bug fixes
- Update room name & avatar on newly created rooms
- Fix image uploading that was causing other image items to render its content

## [0.2.0] - 2018-03-05

### Features
- Support for pasting media & files into a room (#180)
- Server-side message & mention notifications
- Two new commands (`/fliptable`, `/shrug`)
- Option to disable typing notifications
- Check-mark to messages that have been received by the server (#93)
- Basic communities support (#195)
- Read receipt support
- Re-ordering of rooms based on activity

### Improvements
- Automatically focus on input when opening a dialog
- Keep syncing regardless of connectivity (#93)
- Create widgets on demand for messages added to the end of the timeline
- Messages received by `/messages` will be rendered upon entering the room
- Load last content from all rooms
- Load the initial cache data without blocking the UI

### Bug fixes
- Messages will be visible in the side bar after initial sync
- Enable room switcher only in the chat view (#251)
- Retry initial sync forever (#234)
- Show loading indicator while waiting for `/login` & `/logout`
- Disable minimize to tray except for the chat view.
- Fixed transparency issue on custom dialogs (#87)
- Fixed crash when there weren't any rooms

## [0.1.0] - 2017-12-26

The first release providing the basic features to make use of the Matrix network.
