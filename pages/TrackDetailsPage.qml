import QtQuick
import QtQuick.Controls

Column {
  anchors.fill: parent
  anchors.topMargin: 20
  anchors.leftMargin: 20
  spacing: 3

  property alias currentTrackName: currentTrackName.text
  property alias currentTrackArtist: currentTrackArtist.text
  property alias currentTrackDescription: currentTrackDescription
  property alias currentTrackListeners: currentTrackListeners.text
  property alias currentTrackDuration: currentTrackDuration.text
  property alias currentTrackAlbum: currentTrackAlbum.text  
  property alias currentTrackAlbumImage: currentTrackAlbumImage

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