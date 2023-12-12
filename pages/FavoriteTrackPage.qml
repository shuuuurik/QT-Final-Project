import QtQuick
import QtQuick.Controls

Column {
    anchors.fill: parent
    anchors.topMargin: 20
    anchors.leftMargin: 20
    spacing: 3

    property alias currentTrackName2: currentTrackName2.text
    property alias currentTrackArtist2: currentTrackArtist2.text
    property alias currentTrackDescription2: currentTrackDescription2
    property alias currentTrackListeners2: currentTrackListeners2.text
    property alias currentTrackDuration2: currentTrackDuration2.text
    property alias currentTrackAlbum2: currentTrackAlbum2.text  
    property alias currentTrackAlbumImage2: currentTrackAlbumImage2

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
        width: 174
        height: 174
        // fillMode: Image.PreserveAspectFit
        source: ''
    }
}
