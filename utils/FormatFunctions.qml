import QtQuick 2.0

Item {
  /**
   * Функция, обрезающая входную строку, если ее длина превышает заданное значение
   * @param {string} text - Входная строка
   * @param {number} size - Максимальная длина
   * @returns {string} Отформатированная строка
   */
  function resize (text, size) {
    return text.length <= size 
        ? text 
        : text.substr(0, size) + "...";
  }

  /**
   * Функция, переводящая время из милисекунд в удобочитаемое время в минутах и секундах
   * @param {string | number} ms - Входное время в милисекундах
   * @returns {string} Отформатированное время
   */
  function msToTime (ms) {
    var duration = parseInt(ms)
    var seconds = Math.floor((duration / 1000) % 60),
      minutes = Math.floor((duration / (1000 * 60)) % 60)
    seconds = (seconds < 10) ? "0" + seconds : seconds;
    return minutes + ":" + seconds;
  }

  /**
   * Функция, переводящая время из секунд в удобочитаемое время в минутах и секундах
   * @param {string | number} seconds - Входное время в секундах
   * @returns {string} Отформатированное время
   */
  function secondsToTime (seconds) {
    var duration = parseInt(seconds)
    var seconds = Math.floor(duration % 60),
      minutes = Math.floor(duration / 60)
    seconds = (seconds < 10) ? "0" + seconds : seconds;
    return minutes + ":" + seconds;
  }
}