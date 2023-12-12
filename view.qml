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
        property bool isLabelNotFoundVisible: false

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
                    visible: false
                }
                delegate: Components.FoundedTracksList {}
                onCountChanged: {
                    labelNotFound.visible = (count == 0 && stackPage.isLabelNotFoundVisible);
                }
            }
        }
        
        Pages.TrackDetailsPage { 
            id: detailsPage
            Components.AddToFavorites {id: favoritesButton}
        }
        

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
                delegate: Components.FavoriteTracksList {}
            }
        }
        
        Pages.FavoriteTrackPage {id: favoritePage}
        
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
