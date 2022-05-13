import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id: root
    width: 500
    height: 250
    visible: true
    title: qsTr("Log In to Encrypt & Decrypt Program")

    LogInWindow{
        anchors.fill: parent
    }
}
