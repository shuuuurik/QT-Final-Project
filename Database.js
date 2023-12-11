function dbInit()
{
    var db = LocalStorage.openDatabaseSync("TRACK_DB", "", "Database for music tracks", 1000000)
    try {
        db.transaction(function (tx) {
            var myString = 'CREATE TABLE IF NOT EXISTS tracks(id integer primary key not null, name text not null, artist text not null, album text, listeners integer not null, duration text not null, description text, image text)'
            tx.executeSql(myString)
        })
    } catch (err) {
        console.log("Error creating table in database: " + err)
    };
}

function dbGetHandle()
{
    try {
        var db = LocalStorage.openDatabaseSync("TRACK_DB", "", "Database for music tracks", 1000000)
    } catch (err) {
        console.log("Error opening database: " + err)
    }
    return db
}

function dbAddTrack(name, artist, album = null, listeners = 0, duration, description = null, image = null)
{
    var db = dbGetHandle()
    var id = 0;
    db.transaction(function (tx) {
        tx.executeSql('INSERT INTO tracks(name, artist, album, listeners, duration, description, image) VALUES(?, ?, ?, ?, ?, ?, ?)',
                      [name, artist, album, listeners, duration, description, image])
    })
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT max(ID) AS maximum FROM TRACKS')
        id = result.rows.item(0).maximum
    })
    return id;
}

function checkFavorites(name, artist, album = null)
{
    var db = dbGetHandle()
    var isInFavorites = false
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT id FROM TRACKS WHERE name = ? AND artist = ? AND album = ?', [name, artist, album])
        if (results.rows.length)
            isInFavorites = true;
    })

    return isInFavorites;
}

function dbShowTrackList()
{
    var db = dbGetHandle()
    trackListModel.clear()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT id, name, artist, listeners FROM tracks')
        for (var i = 0; i < results.rows.length; ++i) {
            trackListModel.append({
                                 id: results.rows.item(i).id,
                                 name: results.rows.item(i).name,
                                 artist: results.rows.item(i).artist,
                                 listeners: results.rows.item(i).listeners
                             })
        }
    })
}

function dbShowTrack(trackId)
{
    var db = dbGetHandle()
    db.transaction(function (tx) {
        var results = tx.executeSql(
                    'SELECT id, name, artist, album, listeners, duration, description, image FROM TRACKS WHERE id = ?', [trackId])
        trackModel.clear()
        trackModel.append({
            id: results.rows.item(0).id,
            name: results.rows.item(0).name,
            artist: results.rows.item(0).artist,
            album: results.rows.item(0).album,
            listeners: results.rows.item(0).listeners,
            duration: results.rows.item(0).duration,
            description:results.rows.item(0).description,
            image: results.rows.item(0).image
        })
    })
}

function deleteTrack(id) {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DELETE FROM tracks WHERE id = ?', [id])
    })
    
    return id;
}

function deleteAll() {
    var db = dbGetHandle()
    db.transaction(function (tx) {
        tx.executeSql('DROP TABLE tracks')
    })
}

function sumAllPrice() {
    var db = dbGetHandle()
    var summa = 0
    db.transaction(function (tx) {
        var result = tx.executeSql('SELECT sum(price) AS summa FROM product_table')
        summa = result.rows.item(0).summa
    })

    return summa
}