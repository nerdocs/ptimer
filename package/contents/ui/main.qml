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
        running: true
        repeat: true
        onTriggered: {
            root.elapsedSeconds++
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

        MouseArea {
            anchors.fill: parent
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
            }
        }
    }

    // Compact representation (for panel)
    compactRepresentation: Item {
        Layout.preferredWidth: timerText.implicitWidth + Kirigami.Units.smallSpacing * 2
        Layout.preferredHeight: Kirigami.Units.gridUnit * 2

        Rectangle {
            anchors.fill: parent
            color: root.currentBackgroundColor
            radius: 4
        }

        PlasmaComponents.Label {
            id: timerText
            anchors.centerIn: parent
            text: root.formatTime(root.elapsedSeconds)
            font.pixelSize: Kirigami.Theme.defaultFont.pixelSize * 1.5
            font.bold: true
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.resetTimer()
            }
            cursorShape: Qt.PointingHandCursor
        }
    }
}
