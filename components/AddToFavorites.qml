import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../Database.js" as JS

Button {
    id: favoritesButton
    text: "Добавить в избранное"
    onClicked: {
        var track = currentTrackModel.get(0)
        JS.dbAddTrack(track.name, track.artist, track.album, 
                track.listeners, track.duration, track.description, track.albumImage)

        // Выключить добавление в избранное, когда элемент уже добавлен
        favoritesButton.enabled = false
    }
}