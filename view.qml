import QtQuick
import QtQuick.Controls
import QtQuick.Window
import QtQuick.Layouts
import QtQuick.LocalStorage
import "Database.js" as JS
import "components" as Components
import "utils" as Utils
import "pages" as Pages

Window {
    visible: true
    width: 900
    height: 480
    title: qsTr("Last.fm API")

    Utils.ApiRequestStorage { id: api }
    Utils.FormatFunctions { id: helper }

    Components.MyTabBar {id: bar}

    StackLayout {
        id: stackPage
        anchors.fill: parent
        anchors.topMargin: 30

        ListModel {
            id: currentTrackModel
            onCountChanged: {
                if (currentTrackModel.count) {
                    var currentTrack = currentTrackModel.get(0)
                    detailsPage.currentTrackName = `<b>Название:</b> ${currentTrack.name}`;
                    detailsPage.currentTrackArtist = `<b>Исполнитель:</b> ${currentTrack.artist}`;
                    if (currentTrack.description) { 
                        detailsPage.currentTrackDescription.visible = true; 
                        detailsPage.currentTrackDescription.text = `<b>Описание:</b> ${currentTrack.description}` 
                    } else {
                        detailsPage.currentTrackDescription.visible = false;
                    } 
                    detailsPage.currentTrackListeners = `<b>Прослушали: </b> ${currentTrack.listeners}`;
                    detailsPage.currentTrackDuration = `<b>Длительность: </b> ${helper.msToTime(currentTrack.duration)}`;
                    detailsPage.currentTrackAlbum = currentTrack.album ? `<b>Альбом:</b> ${currentTrack.album}` : '';
                    if (currentTrack.albumImage) {
                        detailsPage.currentTrackAlbumImage.visible = true;
                        detailsPage.currentTrackAlbumImage.source = currentTrack.albumImage;
                    }
                    else {
                        detailsPage.currentTrackAlbumImage.visible = false;
                    }
                    stackPage.currentIndex = 1;

                    // Выключить добавление в избранное, когда элемент уже добавлен
                    favoritesButton.enabled = !JS.checkFavorites(currentTrack.name, currentTrack.artist, currentTrack.album)
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

                Components.QueryInput { inputPlaceholder: "Введите название трека"; apiMethod: "getTracksByName" }

                Components.QueryInput { inputPlaceholder: "Введите имя исполнителя"; apiMethod: "getTracksByArtist" }

                Components.QueryInput { inputPlaceholder: "Введите название альбома"; apiMethod: "getTracksByAlbum" }
            }

            ListModel {
                id: trackModel 
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
                delegate: Components.ListViewDelegate {}
            }
        }
        
        Pages.TrackDetailsPage { id: detailsPage }

        Row {
            anchors.topMargin: 20
            anchors.leftMargin: 20
            anchors.fill: parent

            ListModel {
                id: trackListModel
            }

            ListView {
                id: listView2
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
                            text: `<b>Название:</b> ${helper.resize(model.name, 55)}`
                        }
                        Text {
                            width: parent.width
                            wrapMode: Text.WordWrap
                            font.pointSize: 10
                            text: `<b>Исполнитель:</b> ${helper.resize(model.artist, 55)}`
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
                                id: detailsButton2
                                text: "Подробнее"
                                onClicked: {
                                    JS.dbShowTrack(model.id)
                                    var currentTrack = trackModel.get(0)
                                    currentTrackName2.text = `<b>Название:</b> ${currentTrack.name}`;
                                    currentTrackArtist2.text = `<b>Исполнитель:</b> ${currentTrack.artist}`;
                                    if (currentTrack.description) { 
                                        currentTrackDescription2.visible = true; 
                                        currentTrackDescription2.text = `<b>Описание:</b> ${currentTrack.description}` 
                                    } else {
                                        currentTrackDescription2.visible = false;
                                    } 
                                    currentTrackListeners2.text = `<b>Прослушали: </b> ${currentTrack.listeners}`;
                                    currentTrackDuration2.text = `<b>Длительность: </b> ${currentTrack.duration}`;
                                    currentTrackAlbum2.text = currentTrack.album ? `<b>Альбом:</b> ${currentTrack.album}` : '';
                                    if (currentTrack.image) {
                                        currentTrackAlbumImage2.visible = true;
                                        currentTrackAlbumImage2.source = currentTrack.image;
                                    }
                                    else currentTrackAlbumImage2.visible = false;

                                    stackPage.currentIndex = 3;
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
                id: comeBackButton
                text: "Вернуться назад"
                anchors.left: parent.left
                onClicked: stackPage.currentIndex = 2
            }
            Text {
                id: currentTrackName2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackArtist2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackDescription2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackListeners2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackDuration2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            Text {
                id: currentTrackAlbum2
                width: parent.width
                wrapMode: Text.WordWrap
                font.pointSize: 10
            }
            
            Image {
                id: currentTrackAlbumImage2
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
        dataModel.append({
            "name": 'andrey',
            "artist": 'andrey',
            "listeners": 'andrey',
            "duration": 'andrey',
        });
        dataModel.clear();
    }
}
