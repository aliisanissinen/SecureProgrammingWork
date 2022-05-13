import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Window {
    id: changepasswordwindow
    width: 350
    height: 250

    ColumnLayout {
        width: 350
        height: 250

        RowLayout {
            width: 350
            TextArea {
                implicitWidth: 140
                readOnly: true
                font.bold: true
                text: "Old Password: "
            }
            TextField {
                implicitWidth: 170
                id: oldpassword
                Layout.margins: 10
                selectByMouse: true
                text: ""
                echoMode: TextInput.Password
                placeholderText: "Enter the old password"
                background: Rectangle {
                    border.color: "lightgray"
                }
            }
        }

        RowLayout {
            width: 350
            TextArea {
                implicitWidth: 140
                readOnly: true
                font.bold: true
                text: "New Password: "
            }
            TextField {
                implicitWidth: 170
                id: newpassword
                Layout.margins: 10
                selectByMouse: true
                text: ""
                echoMode: TextInput.Password
                placeholderText: "Enter the new password"
                background: Rectangle {
                    border.color: "lightgray"
                }
            }
        }

        RowLayout {
            width: 350
            height: 250
            TextArea {
                implicitWidth: 140
                readOnly: true
                font.bold: true
                text: "Confirm Password: "
            }
            TextField {
                implicitWidth: 170
                id: confirmpassword
                Layout.margins: 10
                selectByMouse: true
                echoMode: TextInput.Password
                text: ""
                placeholderText: "Enter the new password"
                background: Rectangle {
                    border.color: "lightgray"
                }
            }
        }
        Text {
            id: infotext
            Layout.alignment: Qt.AlignHCenter
            text: ""
            color: "red"
        }

        RowLayout {
            Layout.alignment: Qt.AlignBottom | Qt.AlignHCenter
            Layout.topMargin: 50
            Layout.bottomMargin: 15

            Button {
                id: changeButton
                text: "Change"
                onClicked: {
                   controller.getNewPassword(oldpassword.text, newpassword.text, confirmpassword.text);
                   if (controller.newPassword) {
                       infotext.text = "Ok, password changed."
                   }
                   else {
                       infotext.text = "Something went wrong."
                   }
                }
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }

            Button {
                id: cancelButton
                text: "Cancel"
                onClicked: changepasswordwindow.close()
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }
        }
    }
}
