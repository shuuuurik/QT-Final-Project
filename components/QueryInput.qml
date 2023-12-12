import QtQuick
import QtQuick.Controls
// import "../utils" as Utils

Row {
    width: parent.width
    height: 100
    spacing: 5
    property alias inputPlaceholder: query.placeholderText
    property string apiMethod
    // Utils.ApiRequestStorage {id: api}

    TextField {
        id: query
        width: parent.width - 50
        height: 30
        
        placeholderText: "Введите название трека"
        font.pointSize: 12
    }

    Button {
        id: trackQueryButton
        enabled: { query.text == '' ? false : true}
        text: "Искать"
        font.pointSize: 12
        onClicked: {
            stackPage.isLabelNotFoundVisible = true;
            switch(parent.apiMethod) {
                case 'getTracksByName':
                    api.getTracksByName(dataModel, query.text);
                    break;
                case 'getTracksByArtist':
                    api.getTracksByArtist(dataModel, query.text);
                    break;
                case 'getTracksByAlbum':
                    api.getTracksByAlbum(dataModel, query.text);
                    break;
            }
            
        }
    }
}