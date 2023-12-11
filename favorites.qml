import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import "Database.js" as JS
import QtQuick.LocalStorage

Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Last.fm API")

    

    ApiRequestStorage {id: api}

     StackLayout {
        id: stackPage
        anchors.fill: parent

        

        Row {
            anchors.topMargin: 20
            anchors.leftMargin: 20
            anchors.fill: parent

            ListModel {
                id: trackListModel
            }

            ListView {
                id: listView
                height: parent.height
                width: parent.width * 2 / 3
                spacing: 5
                model: trackListModel
                delegate: Rectangle {
                    width: parent.width - 50
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    color: "lightgray"
                    radius: 10
                    Column {
                        anchors.centerIn: parent
                        width: parent.width - 20
                        spacing: 3
                        Text {
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            text: `<b>Название:</b> ${api.resize(model.name, 55)}`
                        }
                        Text {
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            text: `<b>Исполнитель:</b> ${api.resize(model.artist, 55)}`
                        }
                        Text {
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            text: `<b>Прослушиваний:</b> ${model.listeners}`
                        }
                        Row {
                            anchors.horizontalCenter: parent.horizontalCenter
                            Button {
                                id: detailsButton
                                text: "Подробнее"
                                onClicked: {
                                    JS.dbShowTrack(model.id)
                                    var currentTrack = trackModel.get(0)
                                    currentTrackName.text = `<b>Название:</b> ${currentTrack.name}`;
                                    currentTrackArtist.text = `<b>Исполнитель:</b> ${currentTrack.artist}`;
                                    if (currentTrack.description) { 
                                        currentTrackDescription.visible = true; 
                                        currentTrackDescription.text = `<b>Описание:</b> ${currentTrack.description}` 
                                    } else {
                                        currentTrackDescription.visible = false;
                                    } 
                                    currentTrackListeners.text = `<b>Прослушали: </b> ${currentTrack.listeners}`;
                                    currentTrackDuration.text = `<b>Длительность: </b> ${currentTrack.duration}`;
                                    currentTrackAlbum.text = currentTrack.album ? `<b>Альбом:</b> ${currentTrack.album}` : '';
                                    currentTrackAlbumImage.source = currentTrack.image;
                                    stackPage.currentIndex = 1;
                                }
                            }
                            Button {
                                id: deleteButton
                                text: "Удалить"
                                onClicked: {
                                    JS.deleteTrack(model.id)
                                    trackListModel.remove(index)
                                }
                            }
                        }
                    }
                    border { color: "black"; width: 5 }
                }
            }
        }
        
        Column {
            anchors.fill: parent
            anchors.topMargin: 20
            anchors.leftMargin: 20
            spacing: 3
            Button {
                id: btn
                text: "Вернуться назад"
                anchors.left: parent.left
                onClicked: stackPage.currentIndex = 3
            }
            Text {
                id: currentTrackName
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackArtist
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackDescription
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackListeners
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackDuration
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackAlbum
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            
            Image {
                id: currentTrackAlbumImage
                anchors.horizontalCenter: parent.horizontalCenter
                width: 174
                height: 174
                // fillMode: Image.PreserveAspectFit
                source: ''
            }
        }
}
    Component.onCompleted: {
        JS.dbInit()
        JS.dbShowTrackList()
    }
}