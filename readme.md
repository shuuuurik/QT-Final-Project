# QT Final Project
Данный репозиторий содержит финальный проект по университетскому курсу разработки приложений на Qt/QML.

## Описание задания
Написать приложение, которое выводит информацию о музыкальных
композициях. Данные берутся со стороннего открытого сервиса (например,
https://www.last.fm/api/). На главном экране приложения имеется форма поиска.
Можно искать по названию трека, исполнителю, категории, названию альбома.
Приложение выводит список найденных по запросу треков с основной
информацией о них: название композиции, название альбома, исполнитель,
жанр/категория. Также приложение должно выводить на отдельном экране
расширенную информацию о треке: название композиции, название альбома,
исполнитель, продолжительность, жанр/категория, описание, картинка (если
api предоставляет такую возможность). Трек можно добавить в избранное,
тогда вся информация о нем должна храниться в базе на локальном
устройстве. Пользователь может просмотреть список избранных треков,
открыть расширенную информацию о конкретном треке, удалить трек из
избранного.

## Технологии
* QML
* Python
* JS

## Запуск проекта
Для запуска проекта в среде разработки VS Code нужно выполнить в терминале:
```
python -m venv .venv

.\.venv\Scripts\activate

pip install PySide6

.\.venv\Scripts\python.exe .\main.py
```
