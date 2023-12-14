import QtQuick 2.0

Item {

  property string apiKey: '145fdf6a8b5cda51dc51a7f49393052e';

  function getTracksByName(dataModel, name) {
    var request = new XMLHttpRequest()
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=track.search&track=${name}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                stackPage.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()
  
                var json = JSON.parse(request.responseText)
                for (var item of json.results.trackmatches.track) {
                    dataModel.append({
                      "name": item.name, //resize(item.name, 55),
                      "artist": item.artist, //resize(item.artist, 55),
                      "listeners": item.listeners
                    })
                }
                stackPage.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getTracksByArtist(dataModel, artist) {
    var request = new XMLHttpRequest()
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=track.search&track= &artist=${artist}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                stackPage.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()
  
                var json = JSON.parse(request.responseText)
                for (var item of json.results.trackmatches.track) {
                    dataModel.append({
                      "name": item.name, //resize(item.name, 55),
                      "artist": item.artist, //resize(item.artist, 55),
                      "listeners": item.listeners
                    })
                }
                stackPage.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getTracksByAlbum(dataModel, album) {
    var request = new XMLHttpRequest()
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=album.search&album=${album}&limit=5&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                stackPage.isLabelNotFoundVisible = false; // прячем надпись
                dataModel.clear()

                var json = JSON.parse(request.responseText)
                for (var album of json.results.albummatches.album) {
                  getAlbumInfo(dataModel, album.artist, album.name)
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

  function getAlbumInfo(dataModel, artist, album) {
    var request = new XMLHttpRequest()
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=album.getInfo&artist=${artist}&album=${album}&api_key=${this.apiKey}&format=json`, true);
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var json = JSON.parse(request.responseText)
                if (json.album?.tracks?.track) {
                  for (var item of json.album.tracks.track){
                    dataModel.append({
                      "name": item.name,
                      "artist": item.artist.name,
                      "duration": item.duration ?? 0
                    })
                  }
                }
                stackPage.isLabelNotFoundVisible = dataModel.count == 0; // показываем надпись, если модель пуста
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }

  function getTrackInfo(dataModel, track, artist) {
    var request = new XMLHttpRequest()
    var modifiedTrack = track.replace('&', '%26')
    var modifiedArtist = artist.replace('&', '%26')
    request.open('GET', `http://ws.audioscrobbler.com/2.0/?method=track.getInfo&track=${modifiedTrack}&artist=${modifiedArtist}&api_key=${this.apiKey}&format=json`, true);
    
    request.onreadystatechange = function() {
        if (request.readyState === XMLHttpRequest.DONE) {
            if (request.status && request.status === 200) {
                var track = JSON.parse(request.responseText).track

                var imageUrl = null;
                if (track.album) {
                  for(var image of track.album.image) {
                    if (image.size === 'large') {
                      imageUrl = image['#text'];
                    }
                  }
                }

                dataModel.clear()
                dataModel.append({
                  "name": track.name,//resize(track.name, 55),
                  "artist": track.artist.name,//resize(track.artist.name, 55),
                  "description": (track?.wiki?.summary ? track.wiki.summary.replace('Read more on Last.fm', '').slice(0,-1) : ''),
                  "listeners": track.listeners,
                  "duration": track.duration,
                  "album": (track.album ? track.album.title : ''),
                  "albumImage": (imageUrl ?? '')
                })
            } else {
                console.log("HTTP:", request.status, request.statusText)
            }
        }
    }
    request.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    request.setRequestHeader('User-Agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.5993.732 YaBrowser/23.11.1.732 Yowser/2.5 Safari/537.36');
    request.send()
  }
}