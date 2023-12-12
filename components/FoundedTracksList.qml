import QtQuick
import QtQuick.Controls
// import "../utils" as Utils

// Utils.FormatFunctions { id: helper }

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
          visible: {model.listeners ? true : false}
          text: `<b>Прослушиваний:</b> ${model.listeners}`
      }
      Text {
          width: parent.width
          wrapMode: Text.WordWrap
          font.pointSize: 10
          visible: {model.duration ? true : false}
          text: `<b>Длительность:</b> ${helper.secondsToTime(model.duration)}`
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