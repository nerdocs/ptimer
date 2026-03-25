import QtQuick
import QtQuick.Layouts
import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

PlasmoidItem {
    id: root

    property int elapsedSeconds: 0
    property int updateInterval: plasmoid.configuration.updateInterval
    property bool isPaused: false
    property bool flashWhenPaused: plasmoid.configuration.flashWhenPaused

    // Threshold settings
    property int warningThreshold: plasmoid.configuration.warningThreshold
    property int criticalThreshold: plasmoid.configuration.criticalThreshold
    property string warningColor: plasmoid.configuration.warningColor
    property string criticalColor: plasmoid.configuration.criticalColor

    // Current background color based on thresholds
    property string currentBackgroundColor: {
        if (elapsedSeconds >= criticalThreshold) {
            return criticalColor
        } else if (elapsedSeconds >= warningThreshold) {
            return warningColor
        }
        return "transparent"
    }

    width: Kirigami.Units.gridUnit * 10
    height: Kirigami.Units.gridUnit * 4

    Plasmoid.backgroundHints: PlasmaCore.Types.DefaultBackground | PlasmaCore.Types.ConfigurableBackground

    // Timer for updating elapsed time
    Timer {
        id: updateTimer
        interval: root.updateInterval
        running: !root.isPaused
        repeat: true
        onTriggered: {
            root.elapsedSeconds++
        }
    }

    // Timer for flashing effect when paused
    Timer {
        id: flashTimer
        interval: 500
        running: root.isPaused && root.flashWhenPaused
        repeat: true
        property bool visible: true
        onTriggered: {
            visible = !visible
        }
    }

    // Format seconds to MM:SS
    function formatTime(totalSeconds) {
        var minutes = Math.floor(totalSeconds / 60)
        var seconds = totalSeconds % 60
        return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
    }

    // Reset timer
    function resetTimer() {
        root.elapsedSeconds = 0
    }

    // Full representation (widget on desktop or expanded in panel)
    fullRepresentation: Item {
        Layout.preferredWidth: Kirigami.Units.gridUnit * 10
        Layout.preferredHeight: Kirigami.Units.gridUnit * 4

        Rectangle {
            anchors.fill: parent
            color: root.currentBackgroundColor
            radius: 4
        }

        RowLayout {
            anchors.fill: parent
            spacing: Kirigami.Units.smallSpacing

            PlasmaComponents.Button {
                Layout.leftMargin: Kirigami.Units.smallSpacing
                Layout.preferredWidth: Kirigami.Units.gridUnit * 2
                Layout.preferredHeight: Kirigami.Units.gridUnit * 2
                Layout.alignment: Qt.AlignVCenter

                icon.name: root.isPaused ? "media-playback-start" : "media-playback-pause"

                onClicked: {
                    root.isPaused = !root.isPaused
                    if (root.isPaused) {
                        flashTimer.visible = true
                    }
                }

                PlasmaComponents.ToolTip {
                    text: root.isPaused ? i18n("Resume timer") : i18n("Pause timer")
                }
            }

            MouseArea {
                Layout.fillWidth: true
                Layout.fillHeight: true
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    root.resetTimer()
                }

                hoverEnabled: true

                PlasmaComponents.ToolTip {
                    text: i18n("Click to reset timer")
                }

                PlasmaComponents.Label {
                    id: timerLabel
                    anchors.centerIn: parent
                    text: root.formatTime(root.elapsedSeconds)
                    font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 3
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    opacity: root.isPaused ? (root.flashWhenPaused ? (flashTimer.visible ? 1.0 : 0.3) : 0.5) : 1.0
                }
            }
        }
    }

    // Compact representation (for panel)
    compactRepresentation: Item {
        Layout.preferredWidth: compactRow.implicitWidth + Kirigami.Units.smallSpacing * 2
        Layout.preferredHeight: Kirigami.Units.gridUnit * 2

        Rectangle {
            anchors.fill: parent
            color: root.currentBackgroundColor
            radius: 4
        }

        RowLayout {
            id: compactRow
            anchors.centerIn: parent
            spacing: Kirigami.Units.smallSpacing

            PlasmaComponents.Button {
                Layout.preferredWidth: Kirigami.Units.gridUnit * 1.5
                Layout.preferredHeight: Kirigami.Units.gridUnit * 1.5

                icon.name: root.isPaused ? "media-playback-start" : "media-playback-pause"

                onClicked: {
                    root.isPaused = !root.isPaused
                    if (root.isPaused) {
                        flashTimer.visible = true
                    }
                }

                PlasmaComponents.ToolTip {
                    text: root.isPaused ? i18n("Resume timer") : i18n("Pause timer")
                }
            }

            PlasmaComponents.Label {
                id: timerText
                text: root.formatTime(root.elapsedSeconds)
                font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
                font.bold: true
                opacity: root.isPaused ? (root.flashWhenPaused ? (flashTimer.visible ? 1.0 : 0.3) : 0.5) : 1.0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.resetTimer()
                    }
                    cursorShape: Qt.PointingHandCursor

                    PlasmaComponents.ToolTip {
                        text: i18n("Click to reset timer")
                    }
                }
            }
        }
    }
}
