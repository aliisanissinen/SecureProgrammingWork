import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Window {
    id: helpwindow
    width: 300
    height: 150
    title: qsTr("Help")

    ColumnLayout {
        width: 300
        height: 150
        Layout.fillWidth: true
        Layout.fillHeight: true

        ColumnLayout {
            Layout.alignment: Qt.AlignCenter
            TextArea {
                Layout.alignment: Qt.AlignCenter
                readOnly: true
                font.bold: true
                text: qsTr("Contact customer service:")
            }
            TextArea {
                Layout.alignment: Qt.AlignCenter
                readOnly: true
                text: qsTr("email: aliisa.nissinen@tuni.fi")
            }
            TextArea {
                Layout.alignment: Qt.AlignCenter
                readOnly: true
                text: qsTr("phone: XXX XXX XXXX")
            }
        }

        Button {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.bottomMargin: 15
            id: cancelButton
            text: "Cancel"
            onClicked: helpwindow.close()
            background: Rectangle {
                radius: 6
                border.color: "#6495ed"
                border.width: 2
            }
        }
    }
}
