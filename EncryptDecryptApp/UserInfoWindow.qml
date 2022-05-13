import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Window {
    id: userinfowindow
    width: 300
    height: 250

    ColumnLayout {

        RowLayout {
            id: username
            height: 50
            Layout.topMargin: 20
            TextArea {
                implicitWidth: 120
                readOnly: true
                font.bold: true
                text: "Username: "
            }
            TextArea {
                implicitWidth: 120
                readOnly: true
                text: `${controller.username}`
            }
        }

        RowLayout {
            id: name
            height: 50
            TextArea {
                implicitWidth: 120
                readOnly: true
                font.bold: true
                text: "Name: "
            }
            TextArea {
                implicitWidth: 120
                readOnly: true
                text: `${controller.name}`
            }
        }

        RowLayout {
            id: buttons
            Layout.topMargin: 100
            Layout.margins: 15
            Layout.alignment: Qt.AlignCenter

            Button {
                id: passwordButton
                implicitWidth: 135
                text: "Change a password"
                onClicked: {
                    var component = Qt.createComponent("ChangePasswordWindow.qml")
                    var changepasswordwindow   = component.createObject()
                    changepasswordwindow.show()
                    userinfowindow.close()
                }
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }

            Button {
                id: cancelButton
                implicitWidth: 135
                text: "Cancel"
                onClicked: userinfowindow.close()
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }
        }
    }
}
