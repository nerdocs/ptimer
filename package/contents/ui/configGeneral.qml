import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts
import org.kde.kirigami as Kirigami
import org.kde.kcmutils as KCM

KCM.SimpleKCM {
    property alias cfg_updateInterval: updateIntervalSpinBox.value
    property alias cfg_warningThreshold: warningThresholdSpinBox.value
    property alias cfg_criticalThreshold: criticalThresholdSpinBox.value
    property string cfg_warningColor
    property string cfg_criticalColor

    Kirigami.FormLayout {
        QQC2.SpinBox {
            id: updateIntervalSpinBox
            Kirigami.FormData.label: i18n("Update interval (ms):")
            from: 100
            to: 10000
            stepSize: 100
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        QQC2.SpinBox {
            id: warningThresholdSpinBox
            Kirigami.FormData.label: i18n("Warning threshold (minutes):")
            to: 86400
            stepSize: 30

            textFromValue: function(value) {
                var minutes = Math.floor(value / 60)
                var seconds = value % 60
                return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
            }

            valueFromText: function(text) {
                var parts = text.split(":")
                return parseInt(parts[0]) * 60 + parseInt(parts[1])
            }
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Warning color:")

            Rectangle {
                id: warningColorPreview
                width: Kirigami.Units.gridUnit * 3
                height: Kirigami.Units.gridUnit * 1.5
                color: cfg_warningColor
                border.color: Kirigami.Theme.textColor
                border.width: 1
            }

            QQC2.TextField {
                id: warningColorField
                text: cfg_warningColor
                Layout.preferredWidth: Kirigami.Units.gridUnit * 6
                onTextChanged: {
                    if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        cfg_warningColor = text
                    }
                }
            }

            QQC2.Button {
                text: i18n("Yellow")
                onClicked: {
                    cfg_warningColor = "#FFEB3B"
                    warningColorField.text = cfg_warningColor
                }
            }
        }

        Item {
            Kirigami.FormData.isSection: true
        }

        QQC2.SpinBox {
            id: criticalThresholdSpinBox
            Kirigami.FormData.label: i18n("Critical threshold (minuts):")
            to: 86400
            stepSize: 30

            textFromValue: function(value) {
                var minutes = Math.floor(value / 60)
                var seconds = value % 60
                return minutes + ":" + (seconds < 10 ? "0" : "") + seconds
            }

            valueFromText: function(text) {
                var parts = text.split(":")
                return parseInt(parts[0]) * 60 + parseInt(parts[1])
            }
        }

        RowLayout {
            Kirigami.FormData.label: i18n("Critical color:")

            Rectangle {
                id: criticalColorPreview
                width: Kirigami.Units.gridUnit * 3
                height: Kirigami.Units.gridUnit * 1.5
                color: cfg_criticalColor
                border.color: Kirigami.Theme.textColor
                border.width: 1
            }

            QQC2.TextField {
                id: criticalColorField
                text: cfg_criticalColor
                Layout.preferredWidth: Kirigami.Units.gridUnit * 6
                onTextChanged: {
                    if (text.match(/^#[0-9A-Fa-f]{6}$/)) {
                        cfg_criticalColor = text
                    }
                }
            }

            QQC2.Button {
                text: i18n("Red")
                onClicked: {
                    cfg_criticalColor = "#F44336"
                    criticalColorField.text = cfg_criticalColor
                }
            }
        }
    }
}
