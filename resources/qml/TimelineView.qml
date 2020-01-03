import QtQuick 2.9
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.2
import QtGraphicalEffects 1.0
import QtQuick.Window 2.2

import im.nheko 1.0

import "./delegates"

Item {
	property var colors: currentActivePalette
	property var systemInactive: SystemPalette { colorGroup: SystemPalette.Disabled }
	property var inactiveColors: currentInactivePalette ? currentInactivePalette : systemInactive
	property int avatarSize: 40

	Rectangle {
		anchors.fill: parent
		color: colors.window

		Text {
			visible: !timelineManager.timeline && !timelineManager.isInitialSync
			anchors.centerIn: parent
			text: qsTr("No room open")
			font.pointSize: 24
			color: colors.windowText
		}

		BusyIndicator {
			anchors.centerIn: parent
			running: timelineManager.isInitialSync
			height: 200
			width: 200
		}

		ListView {
			id: chat

			cacheBuffer: 2000

			visible: timelineManager.timeline != null
			anchors.fill: parent

			anchors.leftMargin: 4
			anchors.rightMargin: scrollbar.width

			model: timelineManager.timeline

			boundsBehavior: Flickable.StopAtBounds

			onVerticalOvershootChanged: contentY = contentY - verticalOvershoot

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.NoButton
				propagateComposedEvents: true
				z: -1
				onWheel: {
					if (wheel.angleDelta != 0) {
						chat.contentY = chat.contentY - wheel.angleDelta.y
						wheel.accepted = true
						chat.forceLayout()
						chat.updatePosition()
					}
				}
			}

			onModelChanged: {
				if (model) {
					currentIndex = model.currentIndex
					if (model.currentIndex == count - 1) {
						positionViewAtEnd()
					} else {
						positionViewAtIndex(model.currentIndex, ListView.End)
					}
				}
			}

			ScrollBar.vertical: ScrollBar {
				id: scrollbar
				parent: chat.parent
				anchors.top: chat.top
				anchors.left: chat.right
				anchors.bottom: chat.bottom
				onPressedChanged: if (!pressed) chat.updatePosition()
			}

			property bool atBottom: false
			onCountChanged: {
				if (atBottom) {
					var newIndex = count - 1 // last index
					positionViewAtEnd()
					currentIndex = newIndex
					model.currentIndex = newIndex
				}

				if (contentHeight < height && model) {
					model.fetchHistory();
				}
			}

			onAtYBeginningChanged: if (atYBeginning) { chat.model.currentIndex = 0; chat.currentIndex = 0; model.fetchHistory(); }

			function updatePosition() {
				for (var y = chat.contentY + chat.height; y > chat.height; y -= 9) {
					var i = chat.itemAt(100, y);
					if (!i) continue;
					if (!i.isFullyVisible()) continue;
					chat.model.currentIndex = i.getIndex();
					chat.currentIndex = i.getIndex()
					atBottom = i.getIndex() == count - 1;
					break;
				}
			}
			onMovementEnded: updatePosition()

			spacing: 4
			verticalLayoutDirection: ListView.BottomToTop

			delegate: Rectangle {
				// This would normally be previousSection, but our model's order is inverted.
				property bool sectionBoundary: (ListView.nextSection != "" && ListView.nextSection !== ListView.section) || model.index === chat.count - 1

				id: wrapper
				property Item section
				width: chat.width
				height: section ? section.height + timelinerow.height : timelinerow.height

				TimelineRow {
					id: timelinerow
					y: section ? section.y + section.height : 0
				}
				function isFullyVisible() {
					return height > 1 && (y - chat.contentY - 1) + height < chat.height
				}
				function getIndex() {
					return index;
				}

				onSectionBoundaryChanged: {
					if (sectionBoundary) {
						var properties = {
							'modelData': model.dump,
							'section': ListView.section,
							'nextSection': ListView.nextSection
						}
						section = sectionHeader.createObject(wrapper, properties)
					} else {
						section.destroy()
						section = null
					}
				}

			}

			section {
				property: "section"
			}
			Component {
				id: sectionHeader
				Column {
					property var modelData
					property string section
					property string nextSection

					topPadding: 4
					bottomPadding: 4
					spacing: 8

					visible: !!modelData

					width: parent.width
					height: (section.includes(" ") ? dateBubble.height + 8 + userName.height : userName.height) + 8

					Label {
						id: dateBubble
						anchors.horizontalCenter: parent ? parent.horizontalCenter : undefined
						visible: section.includes(" ")
						text: chat.model.formatDateSeparator(modelData.timestamp)
						color: colors.windowText

						height: contentHeight * 1.2
						width: contentWidth * 1.2
						horizontalAlignment: Text.AlignHCenter
						background: Rectangle {
							radius: parent.height / 2
							color: colors.dark
						}
					}
					Row {
						height: userName.height
						spacing: 4
						Avatar {
							width: avatarSize
							height: avatarSize
							url: chat.model.avatarUrl(modelData.userId).replace("mxc://", "image://MxcImage/")
							displayName: modelData.userName

							MouseArea {
								anchors.fill: parent
								onClicked: chat.model.openUserProfile(modelData.userId)
								cursorShape: Qt.PointingHandCursor
							}
						}

						Text { 
							id: userName
							text: chat.model.escapeEmoji(modelData.userName)
							color: chat.model.userColor(modelData.userId, colors.window)
							textFormat: Text.RichText

							MouseArea {
								anchors.fill: parent
								onClicked: chat.model.openUserProfile(section.split(" ")[0])
								cursorShape: Qt.PointingHandCursor
							}
						}
					}
				}
			}
		}
	}
}