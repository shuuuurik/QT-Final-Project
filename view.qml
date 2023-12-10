import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts

Window {
    visible: true
    width: 900
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
                    currentTrackDuration.text = `<b>Длительность: </b> ${api.msToTime(currentTrack.duration)}`;
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

                Row {
                    width: parent.width
                    height: 100
                    spacing: 5

                    TextField {
                        id: trackQuery
                        width: parent.width - 50
                        height: 30
                        
                        placeholderText: "Введите название трека"
                        font.pointSize: 12
                    }

                    Button {
                        id: trackQueryButton
                        enabled: { trackQuery.text == '' ? false : true}
                        text: "Искать"
                        font.pointSize: 12
                        onClicked: {
                            labelNotFound.flag = true;
                            api.getTracksByName(dataModel, trackQuery.text);
                        }
                    }
                }

                Row {
                    width: parent.width
                    height: 100
                    spacing: 5

                    TextField {
                        id: artistQuery
                        width: parent.width - 50
                        height: 30
                        
                        placeholderText: "Введите имя исполнителя"
                        font.pointSize: 12
                    }
                    
                    Button {
                        id: artistQueryButton
                        text: "Искать"
                        enabled: { artistQuery.text == '' ? false : true}
                        font.pointSize: 12
                        onClicked: {
                            labelNotFound.flag = true;
                            api.getTracksByArtist(dataModel, artistQuery.text);
                        }
                    }
                }

                Row {
                    width: parent.width
                    height: 100
                    spacing: 5

                    TextField {
                        id: albumQuery
                        width: parent.width - 50
                        height: 30

                        placeholderText: "Введите название альбома"
                        font.pointSize: 12
                    }
                    
                    Button {
                        id: albumQueryButton
                        text: "Искать"
                        enabled: { albumQuery.text == '' ? false : true}
                        font.pointSize: 12
                        onClicked: {
                            labelNotFound.flag = true;
                            api.getTracksByAlbum(dataModel, albumQuery.text);
                        }
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
                Label {
                    id: labelNotFound
                    height: 30
                    anchors.centerIn: parent
                    color: "red"
                    text: "К сожалению, по данному запросу треков не найдено"
                    font.pointSize: 12
                    property bool flag: false
                    visible: { flag && dataModel.count == 0 ? true : false }
                }
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
                            visible: {model.listeners ? true : false}
                            text: `<b>Прослушиваний:</b> ${model.listeners}`
                        }
                        Text {
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            visible: {model.duration ? true : false}
                            text: `<b>Длительность:</b> ${api.secondsToTime(model.duration)}`
                        }
                        Button {
                            id: detailsButton
                            text: "Подробнее"
                            anchors.horizontalCenter: parent.horizontalCenter
                            onClicked: {
                                api.getTrackInfo(currentTrackModel, model.name, model.artist);
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
                width: 174
                height: 174
                // fillMode: Image.PreserveAspectFit
                source: ''
            }
        }
        Component.onCompleted: {
            dataModel.append({
                "name": null,
                "artist": null,
                "listeners": null,
                "duration": null,
            });
            dataModel.clear();
        }
    }
}
