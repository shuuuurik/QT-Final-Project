import QtQuick
import QtQuick.Controls
import "../Database.js" as JS

Rectangle {
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
                  favoritePage.currentTrackName2 = `<b>Название:</b> ${currentTrack.name}`;
                  favoritePage.currentTrackArtist2 = `<b>Исполнитель:</b> ${currentTrack.artist}`;
                  if (currentTrack.description) { 
                      favoritePage.currentTrackDescription2.visible = true; 
                      favoritePage.currentTrackDescription2.text = `<b>Описание:</b> ${currentTrack.description}` 
                  } else {
                      favoritePage.currentTrackDescription2.visible = false;
                  } 
                  favoritePage.currentTrackListeners2 = `<b>Прослушали: </b> ${currentTrack.listeners}`;
                  favoritePage.currentTrackDuration2 = `<b>Длительность: </b> ${currentTrack.duration}`;
                  favoritePage.currentTrackAlbum2 = currentTrack.album ? `<b>Альбом:</b> ${currentTrack.album}` : '';
                  if (currentTrack.image) {
                      favoritePage.currentTrackAlbumImage2.visible = true;
                      favoritePage.currentTrackAlbumImage2.source = currentTrack.image;
                  }
                  else favoritePage.currentTrackAlbumImage2.visible = false;

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
