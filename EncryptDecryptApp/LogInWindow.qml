import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.15

Window {
    id: loginwindow
    width: 500
    height: 250
    visible: true
    title: qsTr("Log In to Encrypt & Decrypt App")

    ColumnLayout {
        width: 500
        height: 250

        Text {
            Layout.alignment: Qt.AlignCenter
            Layout.topMargin: 10
            text: "Welcome to Encrypt & Decrypt App. Enter your username and
password to log in, or press Help to contact customer service."
            font.pointSize: 12
            font.bold: true
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true

            Text {
                text: "Username:"
            }
            TextField {
                id: username
                implicitWidth: 200
                anchors.margins: 5
                selectByMouse: true
                placeholderText: "Username"
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignCenter
            Layout.fillWidth: true

            Text {
                text: "Password:"
            }
            TextField {
                id: password
                implicitWidth: 200
                anchors.margins: 5
                selectByMouse: true
                echoMode: TextInput.Password
                placeholderText: "Password"
            }
        }

        Text {
            id: infotext
            Layout.alignment: Qt.AlignHCenter
            text: ""
            color: "red"
        }

        RowLayout {
            width: parent.width
            Layout.alignment: Qt.AlignRight
            Layout.rightMargin: 25

            Button {
                id: loginButton
                Layout.margins: 3
                implicitWidth: 60
                text: "Log In"
                onClicked: {
                    controller.login(username.text, password.text);
                    if (controller.loggedIn) {
                        var component = Qt.createComponent("ApplicationWindow.qml")
                        var appwindow    = component.createObject()
                        appwindow.show()
                        loginwindow.close()
                    }
                    else {
                        infotext.text = "Invalid username or password. Try again or contact customer service."
                    }
                }
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }

            Button {
                id: helpButton
                Layout.margins: 3
                implicitWidth: 60
                text: "Help"
                onClicked: {
                    var component = Qt.createComponent("HelpWindow.qml")
                    var helpwindow    = component.createObject(loginwindow)
                    helpwindow.show()
                }
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }

            Button {
                id: cancelButton
                Layout.margins: 4
                implicitWidth: 60
                text: "Cancel"
                onClicked: Qt.quit()
                background: Rectangle {
                    radius: 6
                    border.color: "#6495ed"
                    border.width: 2
                }
            }
        }
    }
}
