import QtQuick 2.0

Item {

  property string apiKey: '145fdf6a8b5cda51dc51a7f49393052e';

  function getTracks(dataModel) {
    var request = new XMLHttpRequest()
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=track.search&track=${query.text}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                dataModel.clear()
  
                var json = JSON.parse(request.responseText)
                for (var item of json.results.trackmatches.track){
                    dataModel.append({
                      "name": resize(item.name, 55),
                      "artist": resize(item.artist, 55),
                      "listeners": item.listeners
                    })
                }
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  /**
   * Метод, обрезающий входную строку, если ее длина превышает заданное значение
   * @param {string} text - Входная строка
   * @param {number} size - Максимальная длина
   * @returns {string} Отформатированная строка
   */
  function resize (text, size) {
    return text.length <= size 
        ? text 
        : text.substr(0, size) + "...";
  }
}