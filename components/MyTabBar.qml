import QtQuick
import QtQuick.Controls
import QtQuick.LocalStorage
import "../Database.js" as JS

TabBar {
    width: parent.width
    TabButton {
        text: qsTr("Главная")
    }
    TabButton {
        text: qsTr("Избранное")
    }

    onCurrentIndexChanged: {
        if (currentIndex === 0) stackPage.currentIndex = 0
        else {
            JS.dbShowTrackList()
            stackPage.currentIndex = 2
        }
    }
}