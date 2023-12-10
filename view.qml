import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

Window {
    visible: true
    width: 800
    height: 480
    title: qsTr("Last.fm API")

    ApiRequestStorage {id: api}
    StackLayout {
        id: stackPage
        anchors.fill: parent

        ListModel {
            id: currentTrackModel
            onCountChanged: {
                if (currentTrackModel.count) {
                    var currentTrack = currentTrackModel.get(0)
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
                    currentTrackAlbumImage.source = currentTrack.albumImage;
                    stackPage.currentIndex = 1;
                }
            }
        }

        Row {
            anchors.topMargin: 20
            anchors.leftMargin: 20
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
                    rightInset: 10
                    font.pointSize: 12
                }

                Button {
                    text: "Искать"
                    font.pointSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    onClicked: {
                        api.getTracks(dataModel, query.text)
                    }
                }
            }

            ListModel {
                id: dataModel
            }

            ListView {
                id: listView
                height: parent.height
                width: parent.width * 2 / 3
                spacing: 5
                model: dataModel
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
                        Button {
                            id: detailsButton
                            text: "Подробнее"
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                api.getTrackInfo(currentTrackModel, model.mbid, model.name, model.artist);
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
                onClicked: stackPage.currentIndex = 0
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
}
