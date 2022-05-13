import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15


Window {
    id: applicationwindow
    width: 950
    height: 550
    visible: true
    title: qsTr("Encrypt & Decrypt App")

    MouseArea {
        anchors.fill: parent
        onClicked: {
            closeTimer.max = 120000
        }
    }

    Timer {
        id: closeTimer
        property int max : 120000
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            max = max - 1000
            if (max < 1000) {
                closeTimer.stop()
                Qt.quit()
            }
        }
    }

    RowLayout {
        anchors.margins: 10
        ColumnLayout {

            TextArea {
                id: infobox
                Layout.alignment: Qt.AlignTop
                Layout.margins: 10
                Layout.topMargin: 30
                implicitWidth: 200
                implicitHeight: 450
                readOnly: true
                text:
    "This is a program for
encrypting and decrypting
messages.

Enter your key below this
section.

To encrypt your message,
write the text you want to
encrypt in the left box
of the encryption section,
and the encrypted text will
appear on the right side.

To decrypt a secret message,
write the text to the left
of the decrypt section, and
the decrypted text will appear
on the right side.

You can also use copy/paste
methods from your keyboard.

In the username section,
you can change your user
informations."

                background: Rectangle {
                    border.color: "lightgray"
                    border.width: 1
                }
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closeTimer.max = 120000
                    }
                }
            }
            RowLayout {
                Layout.leftMargin: 10

                TextArea {
                    text: "Key: "
                    implicitWidth: 35
                    readOnly: true
                    horizontalAlignment: TextEdit.AlignLeft
                    font.bold: true
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            closeTimer.max = 120000
                        }
                    }
                }
                TextField {
                    id: key
                    Layout.margins: 10
                    implicitWidth: 150
                    selectByMouse: true
                    placeholderText: "Enter the key (16bytes)"
                    horizontalAlignment: TextEdit.AlignRigth
                    background: Rectangle {
                        border.color: "lightgray"
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignTop | Qt.AlignCenter

            RowLayout {
                Layout.fillWidth: true

                TextArea {
                    implicitWidth: 500
                    implicitHeight: 80
                    readOnly: true
                    text: "Welcome to Encrypt & Decrypt Application!"
                    font.bold: true
                    font.pixelSize: 14
                    horizontalAlignment: TextEdit.AlignHCenter
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            closeTimer.max = 120000
                        }
                    }
                }
                TextArea {
                    implicitWidth: 160
                    implicitHeight: 80
                    Layout.topMargin: 5
                    readOnly: true
                    text: `${controller.username}`
                    color: "#6495ed"
                    font.bold: true
                    horizontalAlignment: TextEdit.AlignRight
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var component = Qt.createComponent("UserInfoWindow.qml")
                            var userinfowindow    = component.createObject(applicationwindow)
                            userinfowindow.show()
                        }
                    }
                }
                Image {
                    Layout.alignment: Qt.AlignTop
                    Layout.topMargin: 8
                    source: "images/user.png"
                }

            }
            TextArea {
                text: "Encrypt"
                readOnly: true
                horizontalAlignment: TextEdit.AlignLeft
                font.bold: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closeTimer.max = 120000
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter

                TextField {
                    id: encrypttext
                    Layout.margins: 10
                    implicitWidth: 250
                    implicitHeight: 100
                    selectByMouse: true
                    placeholderText: "Enter the text"
                    verticalAlignment: TextEdit.AlignTop
                    background: Rectangle {
                        border.color: "lightgray"
                    }

                    onTextChanged: {
                        closeTimer.max = 120000
                        encrypttext.text = text
                        controller.getText(text, "encrypt", key.text)
                    }
                }

                TextArea {
                    Layout.margins: 10
                    implicitWidth: 250
                    implicitHeight: 100
                    selectByMouse: true
                    text: `${(controller.encryptedText)}`
                    verticalAlignment: TextEdit.AlignTop
                    background: Rectangle {
                        border.color: "lightgray"
                        border.width: 1
                    }
                }
            }

            Rectangle {
                height: 1
                implicitWidth: parent.width
                color: "black"
                Layout.alignment: Qt.AlignCenter
                Layout.topMargin: 20
                Layout.bottomMargin: 20
            }

            TextArea {
                text: "Decrypt"
                readOnly: true
                horizontalAlignment: TextEdit.AlignLeft
                font.bold: true
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        closeTimer.max = 120000
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignCenter

                TextField {
                    id: decrypttext
                    Layout.margins: 10
                    implicitWidth: 250
                    implicitHeight: 100
                    selectByMouse: true
                    placeholderText: "Enter the text"
                    verticalAlignment: TextEdit.AlignTop
                    background: Rectangle {
                        border.color: "lightgray"
                    }
                    onTextChanged: {
                        closeTimer.max = 120000
                        decrypttext.text = text
                        controller.getText(text, "decrypt", key.text)
                    }
                }

                TextArea {
                    Layout.margins: 10
                    implicitWidth: 250
                    implicitHeight: 100
                    selectByMouse: true
                    text: `${(controller.decryptedText)}`
                    verticalAlignment: TextEdit.AlignTop
                    background: Rectangle {
                        border.color: "lightgray"
                        border.width: 1
                    }
                }
            }

            Button {
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                Layout.margins: 20
                implicitWidth: 60
                text: "Log out"
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

