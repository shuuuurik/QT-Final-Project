import QtQuick
import QtQuick.Controls
import QtQuick.Window

Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Last.fm API")

    ApiRequestStorage {id: api}

    Row {
        anchors.topMargin: 20
        anchors.leftMargin: 20
        // spacing: 10
        anchors.fill: parent

        Column {
            spacing: 10
            width: parent.width / 3
            height: parent.height

            TextField {
                id: query
                width: parent.width - 10
                height: 30
                anchors.horizontalCenter: parent.horizontalCenter
                
                placeholderText: "Введите название трека"
                font.pointSize: 12
            }

            Button {
                text: "Искать"
                font.pointSize: 12
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: {
                    api.getTracks(dataModel)
                }
            }
        }

        ListView {
            id: view
            height: parent.height
            width: parent.width * 2 / 3
            spacing: 5
            model: dataModel
            delegate: Rectangle {
                width: parent.width - 50
                height: 100
                anchors.horizontalCenter: parent.horizontalCenter
                color: "skyblue"
                Column {
                    anchors.centerIn: parent
                    width: parent.width - 20
                    spacing: 3
                    Text {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        font.pointSize: 10
                        text: `<b>Название:</b> ${model.name}`
                    }
                    Text {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        font.pointSize: 10
                        text: `<b>Исполнитель:</b> ${model.artist}`
                    }
                    Text {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        font.pointSize: 10
                        text: `<b>Прослушиваний:</b> ${model.listeners}`
                    }
                }
                border { color: "black"; width: 5 }
            }
        }
    }

    ListModel {
        id: dataModel
    }
}
